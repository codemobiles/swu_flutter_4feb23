import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class DialogQRImage extends StatelessWidget {
  final String data;
  final String image;

  const DialogQRImage(this.data, {this.image = ''});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildQRImage(),
            Container(
              margin: EdgeInsets.only(top: 12),
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('close'),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildQRImage() => Stack(
        alignment: Alignment.center,
        children: [
          BarcodeWidget(
            barcode: Barcode.qrCode(
              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
            ),
            data: 'www.codemobiles.com',
            width: 200,
            height: 200,
          ),
          Container(
            color: Colors.white,
            width: 60,
            height: 60,
            child: const FlutterLogo(),
          ),
        ],
      );
}
