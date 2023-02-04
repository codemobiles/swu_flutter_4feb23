import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        color: Colors.yellow,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Text("Box1", style: TextStyle(fontSize: 40)),
            Text("Box2", style: TextStyle(fontSize: 40)),
            Text("Box3", style: TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}
