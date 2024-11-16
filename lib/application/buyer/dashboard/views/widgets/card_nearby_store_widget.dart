import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeMembership.dart';

class NearbyStoreCard extends StatelessWidget {
  final StoreMembershipModel data;
  const NearbyStoreCard ({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.size.width * .4,
        margin: EdgeInsets.only(
          left: AppThemes().extraSpacing,
          right: AppThemes().defaultSpacing,
          bottom: AppThemes().extraSpacing,
        ),
        decoration: BoxDecoration(
          color: AppThemes.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500, 
              blurRadius: 4.0,
              offset: const Offset(0,3)
            )
          ]
        ),
        child: data.exp != 0 || data.level != 0 ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.size.width * .4,
              height: Get.size.height * .2,
              child: Stack(
                  children: [
                    Container(
                        width: Get.size.width,
                        height: Get.size.height * .19,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0)
                            ),
                            image: DecorationImage(
                                image:  NetworkImage(data.imgUrl!),
                                fit: BoxFit.cover
                            ),
                            border: Border.all(color: Colors.grey.shade300)
                        )
                    ),
                    Container(
                      height: Get.size.height * .03,
                      width: Get.size.width * .15,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)
                        ),
                        color: AppThemes.levelColor[data.level! <= 5 ? data.level! : 5],
                      ),
                      child: Center(
                        child: Text(
                          'lvl. ${data.level! <= 5 ? data.level! : 'max'}',
                          style: AppThemes().text5Bold(color: AppThemes.white),
                        ),
                      ),
                    )
                  ]
              )),
            SizedBox(
              height: AppThemes().biggerSpacing
            ),
            Container(
              padding: EdgeInsets.only(left: AppThemes().biggerSpacing),
              child: Text(
                data.name!,
                style: AppThemes().text5Bold(color: AppThemes.black),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ),
            SizedBox(
              height: AppThemes().extraSpacing
            ),
            Container(
              padding: EdgeInsets.only(left: AppThemes().biggerSpacing),
              child: Row(
                children: [
                  Icon(Icons.location_on, size: 20, color: Colors.orange[400]),
                  SizedBox(width: Get.size.width * .01),
                  Text("${data.distanceWithUser.toInt()} Km"),
                ],
              ),
            ),
            // SizedBox(
            //   height: AppThemes().extraSpacing
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: AppThemes().biggerSpacing),
                child: Row(
                  children: [
                    Image.asset('assets/vector/coin.png', 
                      fit: BoxFit.cover, width: Get.size.width * .05),
                    SizedBox(width: Get.size.width * .01),
                    Text('${data.coin!} Koin')
                  ],
                ),
              ),
            )
          ],
        )
        :
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.size.width * .4,
            height: Get.size.height * .2,
            child: Expanded(
              child: Stack(
                children: [
                  Container(
                      width: Get.size.width,
                      height: Get.size.height * .19,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)
                          ),
                          image: DecorationImage(
                              image:  NetworkImage(data.imgUrl!),
                              fit: BoxFit.cover
                          ),
                          border: Border.all(color: Colors.grey.shade300)
                      )
                  ),
                  Container(
                      width: Get.size.width,
                      height: Get.size.height * .19,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)
                          ),
                          color: AppThemes.black.withOpacity(0.6),
                          border: Border.all(color: Colors.grey.shade300)
                      )
                  ),
                  Center(
                    child: Container(
                        width: Get.size.width * .14,
                        height: Get.size.height * .08,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/vector/lock.png'),
                              fit: BoxFit.cover
                          )
                        )
                    ),
                  ),
                ]
              ),
            )),
          SizedBox(
            height: AppThemes().biggerSpacing
          ),
          Container(
            padding: EdgeInsets.only(left: AppThemes().biggerSpacing),
            child: Text(
              data.name!,
              style: AppThemes().text5Bold(color: AppThemes.black),
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ),
          SizedBox(
            height: AppThemes().extraSpacing
          ),
          Container(
            padding: EdgeInsets.only(left: AppThemes().biggerSpacing),
            child: Row(
              children: [
                Icon(Icons.location_on, size: 20, color: Colors.orange[400]),
                SizedBox(width: Get.size.width * .01),
                Text("${data.distanceWithUser.toInt()} Km"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}