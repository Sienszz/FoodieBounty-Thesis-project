import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DialogWidgetBuyer {
  forgetPassword({required var controller}) {
    return DialogComponent().onShowModalBottomSheet(
      Padding(
        padding: EdgeInsets.only(
          top: AppThemes().defaultSpacing,
          left: AppThemes().veryExtraSpacing,
          right: AppThemes().veryExtraSpacing,
        ),
        child: Center(
          child: Column(
            children: [
              const TopModalBottom(),
              SizedBox(height: AppThemes().veryExtraSpacing),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Lupa Kata Sandi?',
                      style: AppThemes().text5Bold(color: AppThemes.blue))),
              SizedBox(height: AppThemes().extraSpacing),
              Form(
                key: controller.formkeyResetPassword,
                child: FormInputEmail(
                  title: 'Email',
                  txtcontroller: controller.fieldEmail,
                  textInputType: TextInputType.emailAddress,
                  txtLine: 1,
                  txtEnable: true,
                  txtReadonly: false,
                  mandatory: true,
                  validatorMsg: 'Email wajib diisi',
                ),
              ),
              SizedBox(height: AppThemes().veryExtraSpacing),
              SubmitButton(controller: controller)
            ],
          ),
        ),
      ),
    );
  }
}

class TopModalBottom extends StatelessWidget {
  const TopModalBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final controller;

  const SubmitButton({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width * .5,
      child: ElevatedButton(
        onPressed: () => controller.resetPassword(),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          backgroundColor: AppThemes.blue,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        child: Text(
          'Submit',
          style: AppThemes().text4Bold(color: AppThemes.white),
        ),
      ),
    );
  }
}
