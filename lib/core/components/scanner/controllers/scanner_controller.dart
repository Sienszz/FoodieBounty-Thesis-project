
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerController extends GetxController {
  Barcode? result;
  QRViewController? controller;

  var isFlash = false.obs;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((barcodeData) {
      result = barcodeData;
      if (result != null) {
        controller.stopCamera();
        Get.back(result: result!.code);
      }
    });
  }

  void clickFlash() {
    isFlash.value = !isFlash.value;
    controller!.toggleFlash();
  }
}
