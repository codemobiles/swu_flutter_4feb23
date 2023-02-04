

import 'package:demo0/src/pages/home/home_page.dart';
import 'package:demo0/src/pages/login/login_page.dart';
import 'package:demo0/src/pages/management/management_page.dart';
import 'package:demo0/src/pages/map/map_page.dart';
import 'package:flutter/material.dart';

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
