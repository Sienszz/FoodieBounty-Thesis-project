import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/account/controllers/account_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class ManyCoins extends GetView<BuyerAccountController> {
  const ManyCoins({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.isTrue ?
        const Center(
          child: CircularProgressIndicator(
            color: AppThemes.blue,
            strokeWidth: 5.0,
          ),
        ) :
        controller.mostCoinStoreMembership.value.coin != null && controller.mostCoinStoreMembership.value.coin != 0 ?
        Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: Get.size.width * .2,
              child: Text(controller.mostCoinStoreMembership.value.coin.toString(),
                style: AppThemes().text3Bold(color: AppThemes.white),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(controller.mostCoinStoreMembership.value.name!,
                          style: AppThemes().text4Bold(color: AppThemes.white),
                          maxLines: 3,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: AppThemes().minSpacing,),
                      Text('Koin terbanyak pada suatu toko',
                        style: AppThemes().text6(color: AppThemes.white),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  SizedBox(width: 15.0,),
                  Image.asset('assets/vector/coin.png', fit: BoxFit.cover, width: Get.size.width * .1),
                ],
              ),
            ),
            
          ],
        )
      :
      Center(
        child: Text(
          'Anda membutuhkan setidaknya 1 koin pada suatu toko.',
          style: AppThemes().text5Bold(color: AppThemes.white),
          textAlign: TextAlign.center,
        )
      )
    );
  }
}