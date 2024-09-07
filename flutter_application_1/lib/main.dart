import 'package:flutter/material.dart';
import 'package:flutter_application_1/Login.dart';
import 'package:flutter_application_1/local_notifications.dart';
import 'package:flutter_application_1/manual_attendance.dart';
import 'package:flutter_application_1/timeSheet.dart';
import 'package:go_router/go_router.dart';
import 'model.dart';
import 'admin_home_page.dart';
import 'home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/Home',
        builder: (context, state) {
          final MyData data = state.extra as MyData;
          return HomePage(data: data);
        }
      ),
      GoRoute(
        path: '/AdminHome',
        builder: (context, state) {
          final MyData data = state.extra as MyData;
          return AdminHomePage(data: data);
        },
      ),
      GoRoute(
        path: '/Timesheet',
        builder: (context,state){
          final MyData data = state.extra as MyData;
          return Timesheet(data:data);
        }
      ),
      GoRoute(
        path: '/ManualAttendance',
        builder: (context, state) {
          final MyData data = state.extra as MyData;
          return UserManualAttendance(data:data);
        },
      )
    ],
  );
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}



