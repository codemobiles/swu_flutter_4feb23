import 'package:flutter/material.dart';

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
    loadData();
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

  void loadData() {}
}
