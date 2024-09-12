import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/fetch.dart';
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

  DateTime convert12To24Hour(String time12h) {
    try {
      final RegExp timePattern = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)', caseSensitive: false);
      final match = timePattern.firstMatch(time12h);

      if (match == null) {
        throw FormatException("Invalid time format. Expected format is hh:mm AM/PM.");
      }

      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!.toUpperCase();

      if (period == 'PM' && hour != 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }

      return DateTime(2024, 1, 1, hour, minute); // Date part is arbitrary
    } catch (e) {
      throw FormatException("Invalid time format. Expected format is hh:mm AM/PM.");
    }
  }

  Future<bool> ManualCheckin(String value) async {
    try {
      DateTime time = convert12To24Hour(value);
      String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      String formattedTime = DateFormat('HH:mm:ss').format(time);

      UserAttendance userAttendance = UserAttendance(
        userId: widget.data.id,
        userName: widget.data.username,
        date: formattedDate,
        autoGeoAttendance: AutomatedGeoAttendance(
          geoCheckIn: null,
          geoCheckOut: null,
          geoTotalHours: null,
        ),
        manualGeoAttendance: ManualAttendance(
          manualCheckIn: formattedTime,
          manualCheckOut: null,
          manualTotalHours: null,
        ),
      );

      await newUserAttendance(userAttendance);
      LocalNotifications.showSimpleNotification(
        title: "Check In",
        body: "Successfully Sign In Continue To work<3!!",
        payload: "check In"
      );
      return true;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to check in. Please try again.")),
        );
      }
      return false;
    }
  }

  Future<bool> ManualCheckOut(String value) async {
    try {
      DateTime time = convert12To24Hour(value);
      String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      String formattedTime = DateFormat('HH:mm:ss').format(time);

      UserAttendance userAttendance = UserAttendance(
        userId: widget.data.id,
        userName: widget.data.username,
        date: formattedDate,
        autoGeoAttendance: AutomatedGeoAttendance(
          geoCheckIn: null,
          geoCheckOut: null,
          geoTotalHours: null,
        ),
        manualGeoAttendance: ManualAttendance(
          manualCheckIn: null,
          manualCheckOut: formattedTime,
          manualTotalHours: null,
        ),
      );

      await newUserAttendance(userAttendance);
      LocalNotifications.showSimpleNotification(
        title: "Check Out",
        body: "Successfully Completed The Day Bye Bye See You Tommorow!!",
        payload: "check out"
      );
      return true;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to check out. Please try again.")),
        );
      }
      return false;
    }
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
                if (mounted) {
                  setState(() {
                    if (action == 'Check In') {
                      _checkInTime = formattedTime;
                      checkInController.text = formattedTime;
                      ManualCheckin('${checkInController.text} ${_selectedCheckInAmPm}');
                    } else if (action == 'Check Out') {
                      _checkOutTime = formattedTime;
                      checkOutController.text = formattedTime;
                      ManualCheckOut('${checkOutController.text} ${_selectedCheckOutAmPm}');
                    }
                  });
                  Navigator.of(context).pop();
                }
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid time format. Please use hh:mm AM/PM."),
            backgroundColor: Colors.red,
          ),
        );
      }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Home',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
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
                            onChanged: (String value) {
                              _updateTimeFromInput(value, isCheckIn: true);
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
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
                            onChanged: (String value) {
                              _updateTimeFromInput(value, isCheckIn: false);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog('Check In');
                          },
                          child: const Text('Manual Check In'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog('Check Out');
                          },
                          child: const Text('Manual Check Out'),
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

class AnalogClock extends StatelessWidget {
  final DateTime currentTime;
  final ValueChanged<DateTime> onTimeChanged;

  const AnalogClock({
    Key? key,
    required this.currentTime,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent,
      ),
      child: Center(
        child: Text(
          DateFormat('hh:mm a').format(currentTime),
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
