import 'package:flutter/material.dart';

class ImageNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.image_not_supported,
          size: 50,
          color: Colors.black45,
        ),
        SizedBox(height: 8),
        Text(
          'Image Not Found',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
