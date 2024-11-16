import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projek_skripsi/utils/routes.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class RegisterPageFooter extends StatelessWidget {
  const RegisterPageFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Sudah memiliki akun? ",
        style: AppThemes().text4(color: AppThemes.blue),
        children: [
          TextSpan(
            text: "Masuk",
            style: AppThemes().text4Bold(color: AppThemes.blue),
            recognizer: TapGestureRecognizer()..onTap = () {
              Get.until((route) => Get.currentRoute == AppRoutes.buyerlogin);
            },
          ),
        ],
      ),
    );
  }
}
