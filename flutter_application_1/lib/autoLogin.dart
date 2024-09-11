import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class AutoLoginPage extends StatefulWidget {
  const AutoLoginPage({super.key});

  @override
  _AutoLoginPageState createState() => _AutoLoginPageState();
}

class _AutoLoginPageState extends State<AutoLoginPage> {
  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

 void _autoLogin() async {
  final storage = FlutterSecureStorage();
  final prefs = await SharedPreferences.getInstance();
  final expiryDateStr = prefs.getString('expiryDate');
  final formatter = DateFormat('dd-MM-yyyy');
  
  String? userId = await storage.read(key: 'userId');
  String? username = await storage.read(key: 'username');
  String? isAdmin = await storage.read(key: 'admin');

  if (userId != null && username != null && isAdmin != null) {
    if (expiryDateStr != null) {
      final expiryDate = formatter.parse(expiryDateStr);
      if (DateTime.now().isAfter(expiryDate)) {
        await storage.deleteAll();
        await prefs.setBool('isLoggedIn', false);
        context.pushReplacement('/');
        return;
      }
    }
    
    MyData user = MyData(
      id: int.parse(userId),
      username: username,
      password: '', // Not needed for authentication
      admin: isAdmin == 'true',
      branchId: 1,
      expiryDate: expiryDateStr ?? '',
    );

    if (user.admin) {
      context.pushReplacement('/AdminHome', extra: user);
    } else {
      context.pushReplacement('/Home', extra: user);
    }
  } else {
    context.pushReplacement('/');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
