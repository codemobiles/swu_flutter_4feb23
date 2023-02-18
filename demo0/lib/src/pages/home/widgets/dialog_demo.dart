import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      height: 200,
      child: Column(
        children: [
          Text("AlertDialog"),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Close")),
        ],
      ),
    ));
  }
}
