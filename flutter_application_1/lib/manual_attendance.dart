import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';
import 'package:intl/intl.dart';

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
  String _selectedCheckInAmPm = 'AM';
  String _selectedCheckOutAmPm = 'AM';
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    var formattedTime = DateFormat('hh:mm a').format(_currentTime);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm $action'),
          content: Text('Do you want to $action at ${formattedTime}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (action == 'Check In') {
                    _checkInTime = formattedTime;
                    checkInController.text = formattedTime;
                  } else if (action == 'Check Out') {
                    _checkOutTime = formattedTime;
                    checkOutController.text = formattedTime;
                  }
                });
                Navigator.of(context).pop();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: checkInController,
                            decoration: InputDecoration(
                              labelText: 'Check In Time',
                              hintText: 'Enter Check In Time (hh:mm AM/PM)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.login),
                              suffixIcon: DropdownButton<String>(
                                value: _selectedCheckInAmPm,
                                items: ['AM', 'PM']
                                    .map((String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedCheckInAmPm = value!;
                                    final timeWithAmPm = '${checkInController.text} ${_selectedCheckInAmPm}';
                                    _updateTimeFromInput(timeWithAmPm, isCheckIn: true);
                                  });
                                },
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            onFieldSubmitted: (value) {
                              _updateTimeFromInput(value, isCheckIn: true);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: checkOutController,
                            decoration: InputDecoration(
                              labelText: 'Check Out Time',
                              hintText: 'Enter Check Out Time (hh:mm AM/PM)',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.logout),
                              suffixIcon: DropdownButton<String>(
                                value: _selectedCheckOutAmPm,
                                items: ['AM', 'PM']
                                    .map((String value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedCheckOutAmPm = value!;
                                    final timeWithAmPm = '${checkOutController.text} ${_selectedCheckOutAmPm}';
                                    _updateTimeFromInput(timeWithAmPm, isCheckIn: false);
                                  });
                                },
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            onFieldSubmitted: (value) {
                              _updateTimeFromInput(value, isCheckIn: false);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            _showConfirmationDialog('Check Out');
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Check Out'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
    int hour = (((_hourAngle + pi / 2) / (pi / 6)).floor() % 12).toInt();
    int minute = ((_minuteAngle + pi / 2) / (pi / 30)).toInt();
    return DateTime(0, 0, 0, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final center = Offset(200 / 2, 200 / 2);
        final radius = min(200 / 2, 200 / 2);
        final offset = details.localPosition - center;
        final angle = atan2(offset.dy, offset.dx);

        if (details.localPosition.dx > center.dx) {
          setState(() {
            _hourAngle = angle - (pi / 6 * widget.currentTime.hour / 12) - (pi / 6);
            _minuteAngle = angle - (pi / 30 * widget.currentTime.minute) - (pi / 30);
          });
          widget.onTimeChanged(_calculateTimeFromAngles());
        }
      },
      child: CustomPaint(
        size: Size(200, 200),
        painter: AnalogClockPainter(
          hourAngle: _hourAngle,
          minuteAngle: _minuteAngle,
        ),
      ),
    );
  }
}

class AnalogClockPainter extends CustomPainter {
  final double hourAngle;
  final double minuteAngle;

  AnalogClockPainter({
    required this.hourAngle,
    required this.minuteAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    final hourHandPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8.0;

    final minuteHandPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius - 8, paint);

    final hourHandLength = radius * 0.5;
    final minuteHandLength = radius * 0.8;

    canvas.drawLine(center, Offset(
      center.dx + hourHandLength * cos(hourAngle),
      center.dy + hourHandLength * sin(hourAngle),
    ), hourHandPaint);

    canvas.drawLine(center, Offset(
      center.dx + minuteHandLength * cos(minuteAngle),
      center.dy + minuteHandLength * sin(minuteAngle),
    ), minuteHandPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
