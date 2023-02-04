import 'package:demo0/src/pages/home/home_page.dart';
import 'package:demo0/src/pages/loading/loading_page.dart';
import 'package:demo0/src/pages/pages.dart';
import 'package:flutter/cupertino.dart';

class AppRoute {
  static const home = 'home';
  static const login = 'login';
  static const management = 'management';
  static const map = 'map';
  static const loading = 'loading';

  static get all => <String, WidgetBuilder>{
        login: (context) => const LoginPage(), // demo how to used widget
        home: (context) => const HomePage(),
        management: (context) => const ManagementPage(),
        map: (context) => const MapPage(),
      };
}
