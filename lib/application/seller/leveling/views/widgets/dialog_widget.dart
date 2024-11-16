import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DialogWidget {
  onChooseReward({required var controller}) {
    return Get.dialog(
        AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: AppThemes().defaultSpacing),
            title: Text('Pilih satu dari dua hadiah',
                style: AppThemes().text3Bold(color: AppThemes.black)),
            content: Container(
              padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () => controller.selectedReward.value = 'coin',
                            child: Obx(() => Container(
                              padding: EdgeInsets.all(AppThemes().biggerSpacing),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: AppThemes.darkBlue),
                                  color: controller.selectedReward.value == 'coin' ?
                                  AppThemes.blue : AppThemes.white
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset('assets/vector/icon_coin.png', width: 50, height: 50,),
                                    SizedBox(height: AppThemes().extraSpacing),
                                    Text('Koin',
                                        style: AppThemes().text5Bold(
                                            color: controller.selectedReward.value == 'coin' ?
                                            AppThemes.white : AppThemes.blue))
                                  ],
                                ),
                              ),
                            ))
                        ),
                      ),
                      SizedBox(width: AppThemes().extraSpacing),
                      Expanded(
                        child: GestureDetector(
                            onTap: () => controller.selectedReward.value = 'voucher',
                            child: Obx(() => Container(
                              padding: EdgeInsets.all(AppThemes().biggerSpacing),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: AppThemes.darkBlue),
                                  color: controller.selectedReward.value == 'voucher' ?
                                  AppThemes.blue : AppThemes.white
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Image.asset('assets/vector/icon_voucher.png', width: 50, height: 50,),
                                    SizedBox(height: AppThemes().extraSpacing),
                                    Text('Voucer',
                                        style: AppThemes().text5Bold(
                                            color: controller.selectedReward.value == 'voucher' ?
                                            AppThemes.white : AppThemes.blue))
                                  ],
                                ),
                              ),
                            ))
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: AppThemes().extraSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          "Batal",
                          style: AppThemes().text5Bold(color: AppThemes.blue),
                        ),
                      ),
                      SizedBox(width: AppThemes().extraSpacing),
                      ElevatedButton(
                        onPressed: () => controller.addReward(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppThemes.blue),
                        child: const Text("Konfirmasi", style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  )
                ],
              ),
            )),
        barrierDismissible: false);
  }
}
