import 'dart:convert';

import 'package:demo0/src/bloc/home/home_bloc.dart';
import 'package:demo0/src/models/youtube_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(HomeEventLoadData());
  }
  
  @override
  Widget build(BuildContext context) {
    final dummyArray = ["Angular", "React", "Flutter", "Vue"];

    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(children: dummyArray.map((e) => Text(e)).toList(),),
        ));
  }

}
