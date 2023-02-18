import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class DialogBarcodeImage extends StatelessWidget {
  final String data;

  const DialogBarcodeImage(this.data);

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

  BarcodeWidget _buildQRImage() =>    BarcodeWidget(
    // barcode: Barcode.qrCode(
    //   errorCorrectLevel: BarcodeQRCorrectionLevel.high,
    // ),
    barcode: Barcode.code128(),
    data: data,
    width: 200,
    drawText: true,
    errorBuilder: (cxt, err) => Center(
      child: Text("Uh oh! Something went wrong..."),
    ),
  );
}