import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/scanner_controller.dart';

class QRScanner extends StatelessWidget {

  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    var scanQRController = Get.put(QRScannerController());
    return WillPopScope(
      onWillPop: () async {
        scanQRController.controller!.stopCamera();
        return true;
      },
      child: Scaffold(
          body: Stack(
            children: [
              QRView(
                key: scanQRController.qrKey,
                onQRViewCreated: scanQRController.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: AppThemes.blue,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: Get.size.width * 0.8)
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Get.size.height * .05,
                    left: Get.size.width * .01
                ),
                child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppThemes.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: const Offset(0, 2), // Offset in x and y direction
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new,
                      color: AppThemes.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => scanQRController.clickFlash(),
            backgroundColor: AppThemes.blue,
            icon: Obx(() => scanQRController.isFlash.value
                ? const Icon(
              Icons.flash_on,
              color: AppThemes.white,
            )
                : const Icon(
              Icons.flash_off,
              color: Colors.white,
            )),
            label: const Text(
              'Flash',
              style: TextStyle(color: AppThemes.white),
            ),
          ),
        ),
    );
  }
}
