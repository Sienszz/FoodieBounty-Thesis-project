import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DescText extends StatelessWidget {
  final String title;
  final String subtitle;
  const DescText({Key? key,
    required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.size.width * .3,
          child: Text(title, style: AppThemes().text5Bold(color: AppThemes.blue)),
        ),
        SizedBox(
          width: Get.size.width * .05,
          child: Text(':', style: AppThemes().text5Bold(color: AppThemes.blue)),
        ),
        Expanded(child: Text(subtitle,
          style: AppThemes().text5(color: AppThemes.black)))
      ],
    );
  }
}
