import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/edit_store/controllers/edit_store_controller.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DialogWidget {
  var controller = Get.put(EditStoreController());
  onConfirmPassword(){
    return Get.dialog(
        AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: AppThemes().defaultSpacing),
            title: Text('Masukan Kata Sandi Akun',
              style: AppThemes().text3Bold(color: AppThemes.black)),
            content: Container(
              padding: EdgeInsets.only(
                left: AppThemes().extraSpacing,
                right: AppThemes().extraSpacing,
                bottom: AppThemes().extraSpacing,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FormInputText(
                      title: 'Kata Sandi',
                      txtcontroller: controller.fieldPassword,
                      textInputType: TextInputType.visiblePassword,
                      txtLine: 1,
                      txtEnable: true,
                      txtReadonly: false,
                      mandatory: true,
                      validatorMsg: 'Kata Sandi wajib diisi',
                  ),
                  SizedBox(height: AppThemes().extraSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text("Batal",
                          style: AppThemes().text5Bold(color: AppThemes.blue),),
                      ),
                      SizedBox(width: AppThemes().extraSpacing),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppThemes.blue
                        ),
                        child: const Text("Konfirmasi"),
                      ),
                    ],
                  )
                ],
              ),
            )
        ),
        barrierDismissible: false
    );
  }

}