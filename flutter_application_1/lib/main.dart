import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Login.dart';
import 'package:flutter_application_1/autoLogin.dart';
import 'package:flutter_application_1/local_notifications.dart';
import 'package:flutter_application_1/manual_attendance.dart';
import 'package:flutter_application_1/timeSheet.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'admin_home_page.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensures that widgets are initialized before locking orientation.
  
  // Initialize the local notifications
  await LocalNotifications.init();


  bool isLoggedIn = await checkLoginStatus();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final expiryDateStr = prefs.getString('expiryDate');

  if (!isLoggedIn) return false;

  if (expiryDateStr != null) {
    final formatter = DateFormat('dd-MM-yyyy');
    final expiryDate = formatter.parse(expiryDateStr);
    if (DateTime.now().isAfter(expiryDate)) {
      await prefs.setBool('isLoggedIn', false);
      return false;
    }
  }

  return true;
}

Future<MyData?> retrieveUserData() async {
  final storage = FlutterSecureStorage();
  String? userId = await storage.read(key: 'userId');
  String? username = await storage.read(key: 'username');
  String? isAdmin = await storage.read(key: 'admin');
  String? expiryDate = await storage.read(key: 'expiryDate');

  if (userId != null && username != null && isAdmin != null) {
    return MyData(
      id: int.parse(userId),
      username: username,
      password: '', 
      admin: isAdmin == 'true',
      branchId: 1,
      expiryDate: expiryDate ?? '',
    );
  }

  return null;
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  const MyApp({required this.isLoggedIn});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

=======
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return widget.isLoggedIn ? AutoLoginPage() : const Login();
          },
        ),
        GoRoute(
          path: '/Home',
          builder: (context, state) {
            final MyData data = state.extra as MyData;
            return HomePage(data: data);
          },
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
          builder: (context, state) {
            final MyData data = state.extra as MyData;
            return Timesheet(data: data);
          },
        ),
        GoRoute(
          path: '/ManualAttendance',
          builder: (context, state) {
            final MyData data = state.extra as MyData;
            return UserManualAttendance(data: data);
          },
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
