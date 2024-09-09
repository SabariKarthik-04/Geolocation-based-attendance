import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting date and time
import 'package:flutter_application_1/model.dart';

class UserManualAttendance extends StatefulWidget {
  final MyData data;
  const UserManualAttendance({super.key, required this.data});

  @override
  State<UserManualAttendance> createState() => _UserManualAttendanceState();
}

class _UserManualAttendanceState extends State<UserManualAttendance> {
  DateTime _currentTime = DateTime.now();
  String? _checkInTime;
  String? _checkOutTime;

  // Function to show confirmation dialog
  Future<void> _showConfirmationDialog(String action) async {
    final formattedTime = DateFormat('hh:mm a').format(_currentTime); // Use current time from the clock

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm $action'),
          content: Text('Do you want to $action at $formattedTime?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without action
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (action == 'Check In') {
                    _checkInTime = formattedTime;
                  } else if (action == 'Check Out') {
                    _checkOutTime = formattedTime;
                  }
                });
                Navigator.of(context).pop(); // Close dialog and confirm action
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manual Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnalogClock(
              currentTime: _currentTime,
              onTimeChanged: (newTime) {
                setState(() {
                  _currentTime = newTime;
                });
              },
            ),
            const SizedBox(height: 40),

            // Check-In Button
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog('Check In');
              },
              child: const Text('Check In'),
            ),
            const SizedBox(height: 20),

            // Check-Out Button
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog('Check Out');
              },
              child: const Text('Check Out'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalogClock extends StatefulWidget {
  final DateTime currentTime;
  final Function(DateTime) onTimeChanged;

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

  // Function to update angles based on the time
  void _updateAnglesFromTime(DateTime time) {
    _hourAngle = ((time.hour % 12) + time.minute / 60) * pi / 6;
    _minuteAngle = time.minute * pi / 30;
  }

  // Function to calculate time based on the angles
  DateTime _calculateTimeFromAngles() {
    int hour = ((_hourAngle * 6 / pi).round() % 12);
    int minute = ((_minuteAngle * 30 / pi).round() % 60);
    return DateTime(
      widget.currentTime.year,
      widget.currentTime.month,
      widget.currentTime.day,
      hour,
      minute,
    );
  }

  // Function to update the time based on the angles
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
        final double angle = atan2(dy, dx);

        setState(() {
          if (details.localPosition.distance <= 100) {
            // Update the hour hand if dragging near the center
            _hourAngle = angle;
          } else {
            // Update the minute hand if dragging farther from the center
            _minuteAngle = angle;
          }
        });

        _updateTime();
      },
      child: CustomPaint(
        size: Size(300, 300),
        painter: _ClockPainter(_hourAngle, _minuteAngle),
      ),
    );
  }
}

class _ClockPainter extends CustomPainter {
  final double hourAngle;
  final double minuteAngle;

  _ClockPainter(this.hourAngle, this.minuteAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    final Paint clockCircle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw clock face
    canvas.drawCircle(center, radius, clockCircle);

    // Draw hour markers
    final Paint hourMarkerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;

    for (int i = 0; i < 12; i++) {
      final double angle = i * pi / 6;
      final double startX = center.dx + radius * 0.9 * cos(angle);
      final double startY = center.dy + radius * 0.9 * sin(angle);
      final double endX = center.dx + radius * 0.8 * cos(angle);
      final double endY = center.dy + radius * 0.8 * sin(angle);
      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), hourMarkerPaint);
    }

    // Draw hour hand
    _drawHand(canvas, center, hourAngle, radius * 0.5, 8);

    // Draw minute hand
    _drawHand(canvas, center, minuteAngle, radius * 0.8, 6);

    // Draw clock center
    canvas.drawCircle(center, 8, Paint()..color = Colors.black);
  }

  void _drawHand(Canvas canvas, Offset center, double angle, double length, double thickness) {
    final Paint handPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    final handX = center.dx + length * cos(angle);
    final handY = center.dy + length * sin(angle);
    canvas.drawLine(center, Offset(handX, handY), handPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
