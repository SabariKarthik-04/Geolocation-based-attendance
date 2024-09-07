import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';

class UserManualAttendance extends StatefulWidget {
  final MyData data;
  const UserManualAttendance({super.key,required this.data});

  @override
  State<UserManualAttendance> createState() => _UserManualAttendanceState();
}

class _UserManualAttendanceState extends State<UserManualAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Hello"),
    );
  }
}