import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/application/seller/history/controllers/history_seller_controller.dart';
import 'package:projek_skripsi/application/seller/history/views/widgets/card_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeHistory.dart';

class HistoryPageBody extends GetView<HistorySellerController> {
  final List<dynamic> lsData;
  const HistoryPageBody({Key? key, required this.lsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.isTrue ?
      const Center(
        child: CircularProgressIndicator(
          color: AppThemes.blue,
          strokeWidth: 5.0,
        ),
      ) : lsData.isEmpty ? const Center(child: Text("Tidak Ada Data Riwayat")) :
          ListView.builder(
            shrinkWrap: true,
            itemCount: lsData.length,
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: AppThemes().veryExtraSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppThemes().veryExtraSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lsData[index]['date'], style: AppThemes().text6Bold(color: AppThemes.blue)),
                        Text('Total: ${lsData[index]['total']}',
                            textAlign: TextAlign.start, style: AppThemes().text5Bold(color: AppThemes.black)),
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: lsData[index]['data'].length,
                        itemBuilder: (context, index2){
                          return HistoryCard(data: lsData[index]['data'][index2]);
                        }
                    ),
                    // HistoryCard(data: lsData[index])
                  ],
                ),
              );
            },
          )
    );
  }
}