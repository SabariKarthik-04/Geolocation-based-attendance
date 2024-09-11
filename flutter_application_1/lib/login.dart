import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _storage = const FlutterSecureStorage();

  void _verifyUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      MyData user = await authenticateUser(username, password);
      await saveLoginInfo(user);

      if (user.admin) {
        context.pushReplacement('/AdminHome', extra: user);
      } else {
        context.pushReplacement('/Home', extra: user);
      }

      _usernameController.clear();
      _passwordController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  Future<void> saveLoginInfo(MyData user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    await _storage.write(key: 'userId', value: user.id.toString());
    await _storage.write(key: 'username', value: user.username);
    await _storage.write(key: 'admin', value: user.admin.toString());

    await prefs.setString('expiryDate', user.expiryDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(150.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150.0),
                  child: Image.asset(
                    'assets/image/logo.jpg',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Password',
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: _verifyUser,
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<MyData> authenticateUser(String username, String password) async {
  if (username == 'EMP1' && password == '12345') {
    return MyData(id: 1, username: 'EMP1', password: '12345', branchId: 1, admin: false, expiryDate: "08-09-2024");
  } else if (username == 'ADMIN' && password == '12345') {
    return MyData(id: 2, username: 'ADMIN', password: '12345', branchId: 1, admin: true, expiryDate: "15-09-2024");
  } else {
    throw Exception('Invalid credentials');
  }
}
