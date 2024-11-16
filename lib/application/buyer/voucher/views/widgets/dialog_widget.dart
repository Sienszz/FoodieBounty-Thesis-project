import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/components/generateQR_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DialogVoucherShowBarcodeWidget {
  onShowBarcode(String customerVoucherId) {
    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))
            ),
            contentPadding: EdgeInsets.only(top: AppThemes().defaultSpacing),
            title: Center(
              child: Text('Pindai Kode QR Voucer',
                style: AppThemes().text3Bold(color: AppThemes.black),
              ),
            ),
            content: Container(
              padding: EdgeInsets.only(
                left: AppThemes().extraSpacing,
                right: AppThemes().extraSpacing,
                bottom: AppThemes().extraSpacing,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('ID Voucer Anda:\n$customerVoucherId',
                    textAlign: TextAlign.center,
                    style: AppThemes().text5Bold(color: AppThemes.black),
                  ),
                  SizedBox(
                    height: AppThemes().veryExtraSpacing
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: AppThemes.blue,
                        width: 4.0,
                      ),
                    ),
                    child: GenerateQRComponent(data: customerVoucherId)
                  ),
                  SizedBox(
                    height: AppThemes().extraSpacing
                  ),
                  Container(
                    // width: Get.size.width * .4,
                    padding: EdgeInsets.all(AppThemes().extraSpacing),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.size.width * .7,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemes.blue,
              ),
              child: Text("SELESAI",
                style: AppThemes().text3Bold(color: AppThemes.white)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
