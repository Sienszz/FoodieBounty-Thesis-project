import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';

class CouponCard extends StatelessWidget {
  final Widget widget;
  final StoreVoucherModel data;
  const CouponCard({Key? key, required this.widget, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      margin: EdgeInsets.only(
        left: AppThemes().veryExtraSpacing,
        right: AppThemes().veryExtraSpacing,
        top: AppThemes().extraSpacing,
        bottom: AppThemes().defaultSpacing,
      ),
      padding: EdgeInsets.all(AppThemes().extraSpacing),
      decoration: BoxDecoration(
        color: AppThemes.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500, 
            blurRadius: 3.0,
            offset: const Offset(0,1))]
      ),
      child: Row(
        children: [
          const Icon(Icons.discount, size: 40, color: AppThemes.blue),
          SizedBox(width: AppThemes().extraSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.name!,
                  style: AppThemes().text5Bold(color: Colors.black),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: AppThemes().biggerSpacing),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DescText(title: 'Koin', subtitle: data.coin == null ? "-" : data.coin!.toString()),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      DescText(title: 'Tgl. kadaluarsa', subtitle: DateFormat('dd MMM yyyy').format(data.expDate!)),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      DescText(title: 'Min. transaksi', subtitle: 'Rp ${data.minTransaction}' ),
                    ],
                  ),
                ),
                SizedBox(height: AppThemes().defaultSpacing),
                widget
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DescText extends StatelessWidget {
  final String title;
  final String subtitle;
  const DescText({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppThemes().text6(color: Colors.grey)),
        Text(subtitle, style: AppThemes().text6Bold(color: Colors.black)),
      ],
    );
  }
}

