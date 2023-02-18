import 'package:demo0/src/bloc/home/home_bloc.dart';
import 'package:demo0/src/bloc/login/login_bloc.dart';
import 'package:demo0/src/constants/network_api.dart';
import 'package:demo0/src/pages/app_routes.dart';
import 'package:demo0/src/pages/home/home_page.dart';
import 'package:demo0/src/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider<LoginBloc>(create: (context) => LoginBloc());
    final homeBloc = BlocProvider<HomeBloc>(create: (context) => HomeBloc());

    return MultiBlocProvider(
      providers: [loginBloc, homeBloc],
      child: MaterialApp(
        routes: AppRoute.all,
        home: _loadDefaultPage(),
      ),
    );
  }

  _loadDefaultPage() {
    // final prefs = await SharedPreferences.getInstance();
    // final token = await prefs.getString(NetworkAPI.token);
    // print(token);
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Text("Loading..."),
          );
        }
        final token = snapshot.data!.getString(NetworkAPI.token);
        return token == null ? LoginPage() : HomePage();
      },
    );
  }
}
