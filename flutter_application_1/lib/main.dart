import 'package:flutter/material.dart';
import 'package:flutter_application_1/Login.dart';
import 'package:go_router/go_router.dart';
import 'model.dart';
import 'admin_home_page.dart';
import 'home_page.dart';


void main() {
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



