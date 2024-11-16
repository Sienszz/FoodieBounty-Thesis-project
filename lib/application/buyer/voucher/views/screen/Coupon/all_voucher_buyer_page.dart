
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/components/dialog_component.dart';
import 'package:projek_skripsi/core/components/voucher_buyer_card.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';


class AllVoucherBuyer extends StatelessWidget {

  final List<RxMap<String, dynamic>> data;

  const AllVoucherBuyer({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("testt2: ${data.length}");
    return  ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index){
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
                child: GestureDetector(
                  onTap: () {
                    final voucher = data[index]['StoreVoucher'];
                    DialogComponent().onShowDetailVoucher(data: voucher, qty: 1);
                  },
                  child: VoucherBuyerCard(
                    data: data[index]
                  ),
                ),
                // HistoryBuyerTransaction(),
              )
            ],
          );
        }
    );
  }
}
