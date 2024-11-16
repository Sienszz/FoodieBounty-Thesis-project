
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/application/buyer/history/views/widget/history_buyer_card.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/application/buyer/history/controllers/history_buyer_controller.dart';

import '../../../../../../authorization/data/models/m_customerHistory.dart';

class AllCouponHistory extends StatelessWidget {
  final List<dynamic> lsData;
  const AllCouponHistory({Key? key, required this.lsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerHistoryModel cardValues; // contain all field of the history that want to print
    // var controller = Get.put(HistoryBuyerController());
    return  Obx(() => lsData.isEmpty ? const Center(child: Text("Tidak Ada Transaksi")) :
        ListView.builder(
          shrinkWrap: true,
          itemCount: lsData.length,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppThemes().extraSpacing, vertical: AppThemes().defaultSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lsData[index]['date'],textAlign: TextAlign.start, style: AppThemes().text6Bold(color: AppThemes.blue)),
                      // Text('Total: ${lsData[index]['total']}',textAlign: TextAlign.start, style: AppThemes().text5Bold(color: AppThemes.black)),
                    ],
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: lsData[index]['data'].length,
                      itemBuilder: (context, index2){
                        // cardValues = controller.lsHistorySorted[index][index2];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppThemes().minSpacing),
                            Container(
                              width: Get.size.width,
                              margin: EdgeInsets.only(
                                top: AppThemes().defaultSpacing,
                                bottom: AppThemes().defaultSpacing,
                              ),
                              child: lsData[index]['data'][index2].type == 'transaction' ?
                                HistoryBuyerTransaction(cardValue: lsData[index]['data'][index2]) :
                                HistoryBuyerVoucher(cardValue: lsData[index]['data'][index2]),
                              // HistoryBuyerTransaction(),
                            )
                          ],
                        );
                      }
                  ),
                ],
              ),
            );
          },
        ));
  }
  String dateformater(DateTime date){
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
