import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'model.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _verifyUser() async {
  final username = _usernameController.text;
  final password = _passwordController.text;
  final Data = [
  {
    'userId':1,
    'username':'EMP1',
    'password':'12345',
    'branchId':1,
    'admin':false,
  },
  {
    'userId':2,
    'username':'ADMIN',
    'password':'12345',
    'branchId':1,
    'admin':true,
  }
  ];
  List<MyData> myDataList =Data.map((json)=>MyData.fromJson(json)).toList();
  if(username=="EMP1" && password =='12345'){
    context.push('/Home',extra:myDataList[0]);
    _usernameController.clear();
    _passwordController.clear();
  }
  else if(username == "ADMIN" && password =="12345"){
    context.push('/AdminHome',extra: myDataList[1]);
    _usernameController.clear();
    _passwordController.clear();
  }
  else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid username or password')),
    );
  }
    /*try {
    MyData user = await authenticateUser(username, password);
    _usernameController.clear();
    _passwordController.clear();
    if (user.admin) {
      context.push('/AdminHome',extra: user);
    } else {
      context.push('/Home',extra: user);
    }
  } catch (e) {
    print('Error during authentication: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid username or password')),
    );
  } */
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
                    alignment: const AlignmentDirectional(0, -10),
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
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Password',
                  suffixIcon: IconButton( icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,)
                  ,onPressed: (){
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },)
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
