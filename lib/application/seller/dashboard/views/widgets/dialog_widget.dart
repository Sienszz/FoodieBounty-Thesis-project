import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_level.dart';

class DialogWidget {
  onShowDetailLevel({required LevelModel data, required int level}) {
    return Get.dialog(
        AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.all(
                AppThemes().extraSpacing,
              ),
              width: Get.size.width,
              constraints: BoxConstraints(
                maxHeight: Get.size.height *.5
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text('Level $level',
                        style: AppThemes().text3Bold(color: AppThemes.black)),
                  ),
                  SizedBox(height: AppThemes().veryExtraSpacing),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.size.width * .3,
                          child: Text('Exp diperlukan: ',
                              style:
                                  AppThemes().text5Bold(color: Colors.black)),
                        ),
                        Expanded(
                          child: Text('${data.exp ?? "-"} exp',
                              style: AppThemes().text5(color: Colors.black)),
                        )
                      ]),
                  SizedBox(height: AppThemes().extraSpacing),
                  Text('Reward: ', style: AppThemes().text5Bold(color: Colors.black)),
                  SizedBox(height: AppThemes().defaultSpacing),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: Get.size.height * .2
                    ),
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            data.coinReward != null ? 
                            Text('  ${data.coinReward!} Koin',
                                  style: AppThemes().text5(color: Colors.black)) : const SizedBox(),  
                            if(data.voucherReward != null)
                              for(var item in data.voucherReward!)
                                Text('  ~ ' + item['name'],style: AppThemes().text5(color: Colors.black))
                          ],      
                        ),
                    ),
                  ),
                  SizedBox(height: AppThemes().veryExtraSpacing),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppThemes.blue),
                      child: Text("Ok",
                          style: AppThemes().text5(color: Colors.white),
                          textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        barrierDismissible: false);
  }
}
