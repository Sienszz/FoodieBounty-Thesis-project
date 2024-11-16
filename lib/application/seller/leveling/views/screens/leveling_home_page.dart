
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/leveling/controllers/leveling_seller_controller.dart';
import 'package:projek_skripsi/application/seller/leveling/views/widgets/card_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/utils/routes.dart';

class LevelingHomePage extends GetView<LevelingSellerController> {
  const LevelingHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.isTrue? 
      const Center(
          child: CircularProgressIndicator(
            color: AppThemes.blue,
            strokeWidth: 5.0,
          ),
        ) : 
      Container(
        padding: EdgeInsets.all(AppThemes().veryExtraSpacing),
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.sellercreateleveling, arguments: {
                  'title': 'Level ${index+1}'
                }),
                child: LevelingCard(
                  title: 'Level ${index+1}',
                  color: controller.levelColors[index],
                  data: controller.lsLevel[index]
                ),
              );
            }),
      ));
  }
}
