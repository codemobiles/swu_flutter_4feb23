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
  var _isShowListView = true;

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
              onPressed: () {
                setState(() {
                  _isShowListView = !_isShowListView;
                });
              },
              icon: Icon(_isShowListView ? Icons.list : Icons.grid_3x3),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return _isShowListView ? _buildListView(state.youtubes) : _buildGridView(state.youtubes);
            },
          ),
        ));
  }

  Widget _buildGridView(List<Youtube> youtubes) {
    return GridView.builder(
      itemCount: youtubes.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            color: Colors.black,
            child: Text(
              youtubes[index].title,
              style: TextStyle(color: Colors.white),
            ));
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 0.8
      ),
    );
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
