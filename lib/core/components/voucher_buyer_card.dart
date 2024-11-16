import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/application/buyer/voucher/views/widgets/dialog_widget.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import '../../application/buyer/voucher/controllers/voucher_buyer_controller.dart';

class VoucherBuyerCard extends StatelessWidget {
  final RxMap<String, dynamic> data;
  const VoucherBuyerCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(VoucherBuyerController());
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
              Row(
                children: [
                  Column(
                    children: [
                      const Icon(Icons.discount, size: 35, color: AppThemes.blue),
                      SizedBox(height: AppThemes().minSpacing),
                      Text('x1', style: AppThemes().text6Bold(color: Colors.black),)
                    ],
                  ),
                  SizedBox(width: AppThemes().extraSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['StoreVoucher'].name,
                            style: AppThemes().text4Bold(color: Colors.black),
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        DescText(title: 'Berlaku hingga', subtitle: DateFormat('dd MMM yyyy').format(data['StoreVoucher'].expDate)),
                        SizedBox(height: AppThemes().defaultSpacing),
                        DescText(title: 'Min. transaksi', subtitle: data['StoreVoucher'].minTransaction.toString())

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
              IconButton(
                onPressed: () => DialogVoucherShowBarcodeWidget().onShowBarcode(data['CustomerVoucherId'].toString()), 
                icon: const Icon(Icons.qr_code_scanner, color: AppThemes.black,size: 30,)
              )
              // Container(
              //   height: Get.size.height * .064,
              //   width: Get.size.width * .11,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)
              //     ),
              //     color: AppThemes.level2,
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         '10',
              //         style: AppThemes().text5Bold(color: AppThemes.white),
              //       ),
              //       Text(
              //         'Coin',
              //         style: AppThemes().text6(color: AppThemes.white),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        )
      ],
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
        Text(title, style: AppThemes().text6(color: Colors.black)),
        Text(subtitle, style: AppThemes().text5Bold(color: Colors.black)),
      ],
    );
  }
}

