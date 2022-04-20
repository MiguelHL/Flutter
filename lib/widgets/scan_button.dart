import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
 
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async{
        //String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF','Cancelar', false,ScanMode.BARCODE);
        String barcodeScanRes = "https://fernando-herrera.com";

        // ignore: avoid_print
        print(barcodeScanRes);
      }
      );
  }
}