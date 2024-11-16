
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/buyer/history/views/widget/history_buyer_card.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';

class CategoryExpandStoreCard extends StatelessWidget {
  final StoreMembershipModel data;
  const CategoryExpandStoreCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var tagString = "";
    for (var i = 0; i < data.tag!.length; i++) {
        tagString += data.tag![i];
        if (i != data.tag!.length - 1) {
            tagString += ", ";
        }
    }
    return Container(
      width: Get.size.width,
      // margin: EdgeInsets.only(
      //   top: AppThemes().biggerSpacing,
      //   bottom: AppThemes().defaultSpacing,
      // ),
      // padding: EdgeInsets.all(AppThemes().extraSpacing),
      decoration: BoxDecoration(
        color: AppThemes.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500, 
            blurRadius: 3.0,
            offset: const Offset(0,1))]
      ),
      child: data.exp != 0 ? Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  width: Get.size.width * .3,
                  height: Get.size.height * .17,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                      // image: AssetImage('assets/photo/photo_1.jpeg'),
                      image: NetworkImage(data.imgUrl!),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                Container(
                    height: Get.size.height * .03,
                    width: Get.size.width * .15,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0)
                      ),
                      color: AppThemes.levelColor[data.level! <= 5 ? data.level : 5],
                    ),
                    child: Center(
                      child: Text(
                          'lvl. ${data.level! <= 5 ? data.level : 'max'}',
                          style: AppThemes().text5Bold(color: AppThemes.white),
                      ),
                    ),
                  )
              ],
            ),
          ),
          SizedBox(width: AppThemes().extraSpacing),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(
                top: AppThemes().biggerSpacing,
                bottom: AppThemes().defaultSpacing,
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name!,
                      style: AppThemes().text4Bold(color: Colors.black),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text(
                      tagString,
                      style: AppThemes().text6Bold(color: AppThemes.blue),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    ),
                    SizedBox(height: AppThemes().veryExtraSpacing),
                    Row(
                      children: [
                        DescText(title: 'Jarak', subtitle: '${data.distanceWithUser.toInt()}km'),
                        SizedBox(width: AppThemes().veryExtraSpacing),
                        DescText(title: 'Koin', subtitle: '${data.coin}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
      :
      Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  width: Get.size.width * .3,
                  height: Get.size.height * .17,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(data.imgUrl!),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                Container(
                  width: Get.size.width * .3,
                  height: Get.size.height * .17,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                    color: AppThemes.black.withOpacity(0.6),
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: Get.size.width * .14,
                      height: Get.size.height * .08,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/vector/lock.png'),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppThemes().extraSpacing),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(
                top: AppThemes().biggerSpacing,
                bottom: AppThemes().defaultSpacing,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name!,
                    style: AppThemes().text4Bold(color: Colors.black),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                  Text(
                    tagString,
                    style: AppThemes().text6Bold(color: AppThemes.blue),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                  ),
                  SizedBox(height: AppThemes().veryExtraSpacing),
                  DescText(title: 'Jarak', subtitle: '${data.distanceWithUser.toInt()}km'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}