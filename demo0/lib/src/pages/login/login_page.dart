import 'package:demo0/src/bloc/login/login_bloc.dart';
import 'package:demo0/src/models/user.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int count = 0;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.text = "admin";
    _passwordController.text = "1234";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [_buildBanner(), _buildForm()],
          ),
        ),
      ),
    );
  }

  _buildForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success){
          // Navigator.pushNamed(context, AppRoute.home);
          Navigator.pushReplacementNamed(context, AppRoute.home);
        }
      },
      child: Card(
        elevation: 7,
        margin: EdgeInsets.only(top: 50, left: 32, right: 32),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'codemobiles@gmail.com',
                  labelText: 'Username',
                  icon: Icon(Icons.email),
                ),
              ),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter password',
                  labelText: 'Password',
                  icon: Icon(Icons.password_outlined),
                ),
              ),
              SizedBox(height: 10),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state.status == LoginStatus.failed) {
                    return Text(
                      "!Error, invalid username or password",
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 30),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.status == LoginStatus.fetching ? null : _handleLogin,
                    child: Text(
                      state.status == LoginStatus.fetching ? "Loading.." : "Login",
                    ),
                  );
                },
              ),
              OutlinedButton(onPressed: _handleRegister, child: Text("Register")),
            ],
          ),
        ),
      ),
    );
  }

  _buildBanner() => Image.asset("assets/images/logo.png");

  void _handleLogin() {
    final user = User(
      _usernameController.text,
      _passwordController.text,
    );

    context.read<LoginBloc>().add(LoginEventSubmit(user));
  }

  void _handleRegister() {
    final user = User(
      _usernameController.text,
      _passwordController.text,
    );

    context.read<LoginBloc>().add(LoginEventRegister(user));
  }
}
