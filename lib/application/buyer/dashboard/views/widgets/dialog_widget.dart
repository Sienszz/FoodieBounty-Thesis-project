import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:projek_skripsi/authorization/data/models/m_buyer.dart';
import 'package:projek_skripsi/core/components/generateQR_component.dart';
import 'package:projek_skripsi/core/components/saveImage_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:screenshot/screenshot.dart';

class DialogWidget {
  final _controller = ScreenshotController();
  onShowBarcode(BuyerModel data) {
    return Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Screenshot(
                      controller: _controller,
                    child: AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0))
                      ),
                      contentPadding: EdgeInsets.only(top: AppThemes().defaultSpacing),
                      title: Center(
                        child: Text('Kode QR Keanggotaaan',
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
                            Text(data.name!,
                              style: AppThemes().text5Bold(color: AppThemes.black),
                            ),
                            SizedBox(
                                height: AppThemes().extraSpacing
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
                                child: GenerateQRComponent(data: data.id!)
                            ),
                            SizedBox(
                                height: AppThemes().veryExtraSpacing
                            ),
                            SizedBox(
                                height: AppThemes().extraSpacing
                            ),
                            SizedBox(
                                height: AppThemes().veryExtraSpacing
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: AppThemes().veryExtraSpacing),
                    // width: Get.size.width * .4,
                    padding: EdgeInsets.all(AppThemes().extraSpacing),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _captureScreen();
                        Get.defaultDialog(
                          title: 'Berhasil',
                          middleText: 'Profile berhasil disimpan',
                          textCancel: 'Ok',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppThemes.darkBlue,
                      ),
                      child: Text("SIMPAN KE GALERI",
                          style: AppThemes().text6Bold(color: AppThemes.white)
                      ),
                    ),
                  )
                ],
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
  _captureScreen() async {
    final image = await _controller.capture();
    await saveQR(image!);
  }
  onShowLoading(){
    return Container(
      color: AppThemes.white,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppThemes.blue,
          strokeWidth: 5.0,
        ),
      ),
    );
  }

  onBuyConfirm({required var controller, required String voucherId}){
    return Get.defaultDialog(
      title: 'Konfirmasi',
      middleText: 'Apakah anda yakin ingin membeli?',
      textConfirm:'Ok',
      textCancel: 'Batal',
      onConfirm: () {
        Get.back();
        controller.onBuyVoucher(voucherId: voucherId);
      }
    );
  }

  popupVoucher({required String name}){
    return Get.dialog(
      GestureDetector(
        onTap: () => Get.offAllNamed(AppRoutes.buyerDashboard),
          child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.7),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/vector/header_voucher.png'),
                Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: Get.size.width * .17),
                        child: Image.asset('assets/vector/coupon_suprised.png',
                          width: Get.size.width * .17,),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                          width: Get.size.width *.5,
                          height: Get.size.width * .5,
                          child: Lottie.asset(
                            'assets/lottie/voucher_suprised.json',
                            repeat: true,
                            frameRate: FrameRate.max,
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppThemes().extraSpacing),
                Text(name,
                    style: AppThemes().text3Bold(color: const Color(0xffBBF3FF))),
                SizedBox(height: AppThemes().veryExtraSpacing),
                Text('Tekan layar untuk keluar',
                    style: AppThemes().text6Bold(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: false
    );
  }
}