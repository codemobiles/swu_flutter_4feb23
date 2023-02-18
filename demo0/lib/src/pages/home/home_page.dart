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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(HomeEventLoadData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.list),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return false ? _buildListView(state.youtubes) : Text("Oh No");
            },
          ),
        ));
  }

  Widget _buildListView(List<Youtube> youtubes) {
    return ListView.builder(
      itemCount: youtubes.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(youtubes[index].title);
      },
    );
  }
}
