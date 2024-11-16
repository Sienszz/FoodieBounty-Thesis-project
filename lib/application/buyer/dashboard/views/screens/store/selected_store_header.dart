import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/dashboard/controllers/store_detail_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SelectedStoreHeader extends GetView<StoreDetailController> {
  const SelectedStoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var tagString = "";
    for (var i = 0; i < controller.storeMembership.value.tag!.length; i++) {
        tagString += controller.storeMembership.value.tag![i];
        if (i != controller.storeMembership.value.tag!.length - 1) {
            tagString += ", ";
        }
    }
    return controller.storeMembership.value.level != 0 || controller.storeMembership.value.exp != 0 ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 118.0,
          width: Get.size.width * .75,
          decoration: const BoxDecoration(
            color: AppThemes.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            )
          ),
          child: Center(
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.storeMembership.value.name!,
                    style: controller.storeMembership.value.name!.length < 12 ? 
                      AppThemes().text2Bold(color: AppThemes.white) : 
                      controller.storeMembership.value.name!.length > 11 && controller.storeMembership.value.name!.length < 20 ? 
                      AppThemes().text3Bold(color: AppThemes.white) : AppThemes().text4Bold(color: AppThemes.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    tagString,
                    style: AppThemes().text5(color: AppThemes.white
                  )),
                  SizedBox(height: Get.size.height * .02),
                  RichText(
                    text: TextSpan(
                      text: controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.exp!.toString() : 'max',
                      style: AppThemes().text5Bold(color: AppThemes.white),
                      children: [
                        TextSpan(
                          text: "/",
                          style: AppThemes().text5Bold(color: AppThemes.black),
                        ),
                        TextSpan(
                          text: controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.lsLevelStore!
                            [controller.storeMembership.value.level!-1].exp!.toString() : 'max',
                          style: AppThemes().text5Bold(color: Colors.yellow),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.size.height * .02,
                    width: Get.size.width * .75,
                    child: Stack(
                      children: [
                        SfSlider(
                          value: controller.storeMembership.value.exp! >= controller.storeMembership.value.lsLevelStore![(controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.level! : 5)-1].exp! || controller.storeMembership.value.level! > 5
                          ? controller.storeMembership.value.lsLevelStore![(controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.level! : 5)-1].exp : controller.storeMembership.value.exp!,
                          min: 0.0,
                          max: controller.storeMembership.value.lsLevelStore![(controller.storeMembership.value.level! <= 5 ?controller.storeMembership.value.level! : 5)-1].exp,
                          activeColor: AppThemes.levelColor[controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.level : 5],
                          inactiveColor: Colors.grey[350],
                          labelPlacement: LabelPlacement.onTicks,
                          thumbIcon: Center(
                            child: Text(
                              controller.storeMembership.value.level! <= 5 ? controller.storeMembership.value.level.toString() : '',
                              style: AppThemes().text6Bold(color: AppThemes.white),
                            )
                          ),
                          tickShape: const SfTickShape(),
                          onChanged: (dynamic value){
                            controller.storeMembership.value.exp = value;
                          }
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppThemes.levelColor[controller.storeMembership.value.level! <= 4 ? controller.storeMembership.value.level!+1 : 5],
                            ),
                            child: Center(
                              child: Text(
                                controller.storeMembership.value.level! <= 4 ? (controller.storeMembership.value.level!+1).toString() : controller.storeMembership.value.level! == 5 ? (controller.storeMembership.value.level!).toString() : '',
                                style: AppThemes().text6Bold(color: AppThemes.white),
                              ),
                            ),
                         ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: Get.size.width * .02),
        Container(
          height: 118.0,
          width: Get.size.width * .20,
          decoration: const BoxDecoration(
              color: AppThemes.blue,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/vector/coin.png', fit: BoxFit.cover, width: Get.size.width * .1),
              SizedBox(height: AppThemes().biggerSpacing),
              Text(controller.storeMembership.value.coin!.toString() , style: AppThemes().text6Bold(color: Colors.yellow),),
              Text('Koin' , style: AppThemes().text6(color: AppThemes.white),),
            ],
          )
        )
      ],
    )
    :
    Container(
      margin: EdgeInsets.only(
        top: Get.size.height * .06,
        right: Get.size.width * .05,
        left: Get.size.width * .05,
      ),
      width: Get.size.width,
      decoration: BoxDecoration(
        color: AppThemes.blue,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(controller.storeMembership.value.name!,
            style: controller.storeMembership.value.name!.length < 12 ?
                  AppThemes().text2Bold(color: AppThemes.white) :
                  controller.storeMembership.value.name!.length > 11 && controller.storeMembership.value.name!.length < 20 ?
                  AppThemes().text3Bold(color: AppThemes.white) : AppThemes().text4Bold(color: AppThemes.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            tagString,
            style: AppThemes().text5(color: AppThemes.white
          ))
        ],
      ),
    );
  }
}