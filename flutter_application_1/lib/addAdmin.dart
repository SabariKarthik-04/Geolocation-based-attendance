import 'package:flutter/material.dart';

class Addadmin extends StatefulWidget {
  const Addadmin({super.key});

  @override
  State<Addadmin> createState() => _AddadminState();
}

class _AddadminState extends State<Addadmin> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _postingController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfrmpasswordController = TextEditingController();
  bool _obsecureText=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              Text(
                "Personal Info Of Admin",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
              children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter the name of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter the email of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _mobileNoController,
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  hintText: "Enter the mobile number of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: "Date of birth",
                  hintText: "Enter the DOB of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today_sharp),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _postingController,
                decoration: InputDecoration(
                  labelText: "Posting",
                  hintText: "Enter the posting of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work_outline_rounded),
                ),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  // Action on save
                },
                child: Text('Save Admin'),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50,),
              Text(
                "Login Info Of Admin",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
              children: [ const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "User Name",
                  hintText: "Enter the user name of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                obscureText: _obsecureText,
                decoration: InputDecoration(
                  labelText: "PassWord",
                  hintText: "Enter the Password of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(_obsecureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obsecureText = !_obsecureText;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _cnfrmpasswordController,
                obscureText: _obsecureText,
                decoration: InputDecoration(
                  labelText: "PassWord",
                  hintText: "Enter the Password of the admin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  
                },
                child: Text('Save Login Info'),
              ),
              ]
         )
        ]
      )
      ]
      )
      )
    )
    );
  }
}