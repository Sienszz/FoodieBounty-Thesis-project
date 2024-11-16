import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/authorization/modules/login/buyer_login/views/wigets/dialog_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/authorization/modules/login/buyer_login/controllers/login_buyer_controller.dart';

class LoginPageBody extends GetView<LoginBuyerController> {
  const LoginPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width * .8,
      child: Form(
        key: controller.formkeyLogin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FormInputEmail(
                title: 'Email',
                txtcontroller: controller.fieldEmail,
                textInputType: TextInputType.emailAddress,
                txtLine: 1,
                txtEnable: true,
                txtReadonly: false,
                mandatory: true,
                validatorMsg: 'Email wajib diisi',
            ),
            FormInputPassword(
                title: 'Kata Sandi',
                txtcontroller: controller.fieldPassword,
                textInputType: TextInputType.visiblePassword,
                txtLine: 1,
                txtEnable: true,
                txtReadonly: false,
                mandatory: true,
                validatorMsg: 'Kata Sandi wajib diisi',
                controller: controller,
            ),
            Obx(() => controller.errorMsg.value != ''
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Text(controller.errorMsg.value,
                        style: AppThemes().text5(color: Colors.red)),
                  )
                : const SizedBox()),
            SizedBox(height: AppThemes().extraSpacing),
            GestureDetector(
              onTap: () => DialogWidgetBuyer().forgetPassword(controller: controller),
                child: Text(
                  'Lupa Kata Sandi?',
                  style: AppThemes().text5(color: AppThemes.lightBlue),
                ),
            ),
            SizedBox(height: AppThemes().veryExtraSpacing),
            SizedBox(
              width: Get.size.width,
              child: ElevatedButton(
                onPressed: () => controller.login(),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: AppThemes.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                ),
                child: Text(
                  'Masuk',
                  style: AppThemes().text4Bold(color: AppThemes.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
