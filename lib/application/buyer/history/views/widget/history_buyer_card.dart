import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

import '../../../../../authorization/data/models/m_customerHistory.dart';

class HistoryBuyerTransaction extends StatelessWidget {
  final CustomerHistoryModel cardValue;
  const HistoryBuyerTransaction({Key? key, required this.cardValue}) : super(key: key);

  // final List<RxMap<String, dynamic>> data;
  //
  // const AllVoucherBuyer({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Container(
          padding: EdgeInsets.all(AppThemes().biggerSpacing),
          decoration: BoxDecoration(
              color: AppThemes.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 4.0,
                    offset: const Offset(0,3))]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardValue.id!, style: AppThemes().text7(color: AppThemes.black)),
              Row(
                children: [
                  // Image.asset('assets/photo/photo_1.jpeg', fit: BoxFit.cover, width: Get.size.width * 0.2)
                  Image.network(cardValue.storeModel.imgUrl!,  fit: BoxFit.cover, width: Get.size.width * 0.2),
                  SizedBox(width: AppThemes().extraSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${cardValue.storeModel.name}',
                            style: AppThemes().text4Bold(color: Colors.black),
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        RichText(
                          text: TextSpan(
                            text: "Voucer: ",
                            style: AppThemes().text5(color: AppThemes.black),
                            children: [
                              TextSpan(
                                text: (cardValue.voucherid == null ? '-' : '${cardValue.voucherModel.name}'),
                                style: AppThemes().text5Bold(color: AppThemes.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppThemes().defaultSpacing),
                        DescText(title: 'Total', subtitle: '${cardValue.totalPrice}')

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: Get.size.width * 0.03, // Adjust as needed
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: Get.size.height * .064,
                width: Get.size.width * .11,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)
                  ),
                  color: AppThemes.levelColor[2],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${cardValue.coin}',
                      style: AppThemes().text5Bold(color: AppThemes.white),
                    ),
                    Text(
                      'Koin',
                      style: AppThemes().text6(color: AppThemes.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: Get.size.width * .015),
              Container(
                height: Get.size.height * .064,
                width: Get.size.width * .11,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),topRight: Radius.circular(12.0),
                  ),
                  color: AppThemes.lightBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${cardValue.exp}',
                      style: AppThemes().text5Bold(color: AppThemes.white),
                    ),
                    Text(
                      'EXP',
                      style: AppThemes().text6(color: AppThemes.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
class HistoryBuyerVoucher extends StatelessWidget {
  final CustomerHistoryModel cardValue;
  const HistoryBuyerVoucher({super.key, required this.cardValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppThemes().biggerSpacing),
      decoration: BoxDecoration(
          color: AppThemes.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 4.0,
                offset: const Offset(0,3))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cardValue.id!, style: AppThemes().text6(color: AppThemes.black)),
          Row(
            children: [
              const Icon(Icons.restaurant_menu, size: 40, color: AppThemes.blue),
              SizedBox(width: AppThemes().extraSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cardValue.voucherModel.name!,
                        style: AppThemes().text4Bold(color: Colors.black),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text(cardValue.storeModel.name!,
                        style: AppThemes().text7(color: Colors.black),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    SizedBox(height: AppThemes().defaultSpacing),
                    DescText(title: 'Total Koin', subtitle: cardValue.totalCoin.toString())
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Desc func
class DescText extends StatelessWidget {
  final String title;
  final String subtitle;
  const DescText({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppThemes().text5(color: Colors.black)),
        Text(subtitle, style: AppThemes().text5Bold(color: Colors.black)),
      ],
    );
  }
}

// const Icon(Icons.restaurant_menu, size: 40, color: AppThemes.blue),


