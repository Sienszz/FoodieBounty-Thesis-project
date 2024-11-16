import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeHistory.dart';

class HistoryCard extends StatelessWidget {
  final StoreHistoryModel data;
  const HistoryCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      margin: EdgeInsets.only(
        top: AppThemes().biggerSpacing,
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
          const Icon(Icons.restaurant_menu, size: 40, color: AppThemes.blue),
          SizedBox(width: AppThemes().extraSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(data.id!,
                      style: AppThemes().text6(color: Colors.black),
                      maxLines: 1, overflow: TextOverflow.ellipsis)),
                    Text(DateFormat("HH:mm:ss").format(data.date!),
                      style: AppThemes().text6(color: Colors.black))  
                  ],
                ),
                SizedBox(height: AppThemes().minSpacing),
                Text(data.customerName!,
                  style: AppThemes().text4Bold(color: Colors.black),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: AppThemes().defaultSpacing),
                RichText(
                  text: TextSpan(
                    text: "Voucer: ",
                    style: AppThemes().text5(color: AppThemes.black),
                    children: [
                      TextSpan(
                        text: data.voucherId ?? "-",
                        style: AppThemes().text5Bold(color: AppThemes.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppThemes().extraSpacing),
                DescText(title: 'Total', subtitle: 'Rp ${data.total!}')

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppThemes().text5(color: Colors.black)),
        Text(subtitle, style: AppThemes().text5Bold(color: Colors.black)),
      ],
    );
  }
}

