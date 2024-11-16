import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class CategoryCard extends StatelessWidget {
  String name = "";
   String image = "";
  CategoryCard({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              width: Get.size.height * .08,
              height: Get.size.height * .08,
              decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover
                  ),
                  border: Border.all(color: Colors.grey.shade300),
              )
          ),
          Text(
            name,
            style: AppThemes().text5Bold(color: AppThemes.black),
          )
        ],
      ),
    );
  }
}