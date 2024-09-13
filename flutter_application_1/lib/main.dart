import 'package:flutter/material.dart';
import 'package:flutter_application_1/Login.dart';
import 'package:flutter_application_1/addAdmin.dart';
import 'package:flutter_application_1/addEmployee.dart';
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
  WidgetsFlutterBinding.ensureInitialized(); // Ensures widgets are initialized before locking orientation.
  
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
    final expiryDate = DateFormat('dd-MM-yyyy').parse(expiryDateStr);
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
  late final GoRouter _router;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
    _setupRouter();
  }

  void _setupRouter() {
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
        GoRoute(
        path: '/AddEmployee',
        builder: (context, state) => Addemployee()
        ),
        GoRoute(
        path: "/AddAdmin",
        builder: (context, state) => Addadmin(),
        ),
      ],
    );
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: _router,
    );
  }
}
