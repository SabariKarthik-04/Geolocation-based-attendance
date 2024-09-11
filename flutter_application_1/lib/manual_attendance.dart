import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;


class UserManualAttendance extends StatefulWidget {
  final MyData data;
  const UserManualAttendance({super.key,required this.data});

  @override
  State<UserManualAttendance> createState() => _UserManualAttendanceState();
}

class _UserManualAttendanceState extends State<UserManualAttendance> {
  DateTime _currentTime = DateTime.now();
  String? _checkInTime;
  String? _checkOutTime;
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text fields with the current time
    _updateCheckInText();
    _updateCheckOutText();
  }

  @override
  void dispose() {
    checkInController.dispose();
    checkOutController.dispose();
    super.dispose();
  }

  Future<void> _showConfirmationDialog(String action) async {
    final formattedTime = DateFormat('hh:mm a').format(_currentTime);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm $action'),
          content: Text('Do you want to $action at $formattedTime?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (action == 'Check In') {
                    _checkInTime = formattedTime;
                    checkInController.text = formattedTime; // Update text field
                  } else if (action == 'Check Out') {
                    _checkOutTime = formattedTime;
                    checkOutController.text = formattedTime; // Update text field
                  }
                });
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _updateTimeFromInput(String inputTime, {required bool isCheckIn}) {
    try {
      final parsedTime = DateFormat('hh:mm a').parseStrict(inputTime);
      setState(() {
        _currentTime = DateTime(
          _currentTime.year,
          _currentTime.month,
          _currentTime.day,
          parsedTime.hour,
          parsedTime.minute,
        );

        if (isCheckIn) {
          _checkInTime = inputTime;
        } else {
          _checkOutTime = inputTime;
        }
      });
    } catch (e) {
      // Show an error message if the format is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid time format. Please use hh:mm AM/PM."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updateCheckInText() {
    _checkInTime = DateFormat('hh:mm a').format(_currentTime);
    checkInController.text = _checkInTime!;
  }

  void _updateCheckOutText() {
    _checkOutTime = DateFormat('hh:mm a').format(_currentTime);
    checkOutController.text = _checkOutTime!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Attendance'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Center the content vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    // Center the clock
                    Center(
                      child: AnalogClock(
                        currentTime: _currentTime,
                        onTimeChanged: (newTime) {
                          setState(() {
                            _currentTime = newTime;
                            _updateCheckInText();
                            _updateCheckOutText();
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Check In Input Section
                    TextFormField(
                      controller: checkInController,
                      decoration: const InputDecoration(
                        labelText: 'Check In Time',
                        hintText: 'Enter Check In Time (hh:mm AM/PM)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.login),
                      ),
                      keyboardType: TextInputType.datetime,
                      onFieldSubmitted: (value) {
                        _updateTimeFromInput(value, isCheckIn: true);
                      },
                      onChanged: (value) {
                        // Optional: live update as user types
                      },
                    ),
                    const SizedBox(height: 20),
                    // Check Out Input Section
                    TextFormField(
                      controller: checkOutController,
                      decoration: const InputDecoration(
                        labelText: 'Check Out Time',
                        hintText: 'Enter Check Out Time (hh:mm AM/PM)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.logout),
                      ),
                      keyboardType: TextInputType.datetime,
                      onFieldSubmitted: (value) {
                        _updateTimeFromInput(value, isCheckIn: false);
                      },
                      onChanged: (value) {
                        // Optional: live update as user types
                      },
                    ),
                    const SizedBox(height: 40),
                    // Check In and Check Out buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _showConfirmationDialog('Check In');
                          },
                          icon: const Icon(Icons.login),
                          label: const Text('Check In'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            _showConfirmationDialog('Check Out');
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Check Out'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalogClock extends StatefulWidget {
  final DateTime currentTime;
  final ValueChanged<DateTime> onTimeChanged;

  const AnalogClock({
    Key? key,
    required this.currentTime,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  late double _hourAngle;
  late double _minuteAngle;

  @override
  void initState() {
    super.initState();
    _updateAnglesFromTime(widget.currentTime);
  }

  @override
  void didUpdateWidget(covariant AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentTime != widget.currentTime) {
      _updateAnglesFromTime(widget.currentTime);
    }
  }

  void _updateAnglesFromTime(DateTime time) {
    setState(() {
      _hourAngle =
          ((time.hour % 12) + time.minute / 60) * pi / 6 - (pi / 2);
      _minuteAngle = time.minute * pi / 30 - (pi / 2);
    });
  }

  DateTime _calculateTimeFromAngles() {
    int hour = (((_hourAngle + pi / 2) * 6 / pi).round() % 12);
    int minute = (((_minuteAngle + pi / 2) * 30 / pi).round() % 60);

    // Handle edge case where hour is 0
    hour = hour == 0 ? 12 : hour;

    return DateTime(
      widget.currentTime.year,
      widget.currentTime.month,
      widget.currentTime.day,
      hour,
      minute,
    );
  }

  void _updateTime() {
    DateTime newTime = _calculateTimeFromAngles();
    widget.onTimeChanged(newTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset center = box.size.center(Offset.zero);
        final Offset position = details.localPosition;
        final double dx = position.dx - center.dx;
        final double dy = position.dy - center.dy;
        final double distanceFromCenter = sqrt(dx * dx + dy * dy);
        final double angle = atan2(dy, dx);

        setState(() {
          double threshold = box.size.width / 3;

          if (distanceFromCenter < threshold) {
            // User is near the center, control the hour hand
            _hourAngle = angle;
          } else {
            // User is near the outer edge, control the minute hand
            _minuteAngle = angle;
          }
        });

        _updateTime();
      },
      child: CustomPaint(
        size: const Size(300, 300),
        painter: ClockPainter(_hourAngle, _minuteAngle),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final double hourAngle;
  final double minuteAngle;

  ClockPainter(this.hourAngle, this.minuteAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Paint for the clock circle
    final circlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Draw clock circle
    canvas.drawCircle(center, radius, circlePaint);

    // Draw numerical markers (1-12)
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,

    );

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    for (int i = 1; i <= 12; i++) {
      final angle = (i * 30) * pi / 180 - pi / 2; // Convert to radians
      final double x = center.dx + (radius - 30) * cos(angle);
      final double y = center.dy + (radius - 30) * sin(angle);

      textPainter.text = TextSpan(
        text: '$i',
        style: textStyle,
      );

      textPainter.layout();
      final offset = Offset(
        x - textPainter.width / 2,
        y - textPainter.height / 2,
      );

      textPainter.paint(canvas, offset);
    }

    // Draw hour hand
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final hourHandLength = radius * 0.5;
    final hourHandEnd = Offset(
      center.dx + hourHandLength * cos(hourAngle),
      center.dy + hourHandLength * sin(hourAngle),
    );
    canvas.drawLine(center, hourHandEnd, hourHandPaint);

    // Draw minute hand
    final minuteHandPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final minuteHandLength = radius * 0.75;
    final minuteHandEnd = Offset(
      center.dx + minuteHandLength * cos(minuteAngle),
      center.dy + minuteHandLength * sin(minuteAngle),
    );
    canvas.drawLine(center, minuteHandEnd, minuteHandPaint);

    // Optionally, draw a center dot
    final centerDotPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 5, centerDotPaint);
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return hourAngle != oldDelegate.hourAngle ||
        minuteAngle != oldDelegate.minuteAngle;
  }
}
