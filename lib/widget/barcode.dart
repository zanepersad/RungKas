import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> scanBarcode() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'cancle',
      true,
      ScanMode.QR,
    );
    debugPrint(barcodeScanRes);
  } on PlatformException {
    barcodeScanRes = 'gagal memindai';
  }
  return barcodeScanRes;
}
