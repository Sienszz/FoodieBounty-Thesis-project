import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/utils/routes.dart';

class TransactionSuccessful extends StatelessWidget {
  final StoreVoucherModel voucher;
  final DateTime time;
  final String customerName;
  final int totalPurchase;
  final int discount;
  const TransactionSuccessful({Key? key, required this.voucher, required this.time,
    required this.customerName, required this.totalPurchase, required this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.blue,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: Get.size.width,
            margin: EdgeInsets.all(AppThemes().veryExtraSpacing),
            padding: EdgeInsets.all(AppThemes().extraSpacing),
            decoration: BoxDecoration(
                color: AppThemes.white,
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TransactionSuccessfulHeader(),
                SizedBox(height: AppThemes().veryExtraSpacing),
                TransactionSuccessfulBody(
                  voucher: voucher,
                  time: time,
                  customerName: customerName,
                  totalPurchase: totalPurchase,
                  discount: discount,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppThemes().veryExtraSpacing),
                  child: const Separator(),
                ),
                const TransactionSuccessfulFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionSuccessfulHeader extends StatelessWidget {
  const TransactionSuccessfulHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppThemes().extraSpacing),
        const CircleAvatar(
          backgroundColor: AppThemes.blue,
          radius: 65,
          child: Icon(Icons.done, size: 100, color: AppThemes.white,),
        ),
        SizedBox(height: AppThemes().veryExtraSpacing),
        Text('Transaksi Berhasil!',
            style: AppThemes().text3Bold(color: AppThemes.blue)),
        SizedBox(height: AppThemes().extraSpacing),
        Text('transaksi Anda telah berhasil dibuat dan telah '
            'ditambahkan ke riwayat toko Anda:',
            style: AppThemes().text4(color: AppThemes.blue),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class TransactionSuccessfulBody extends StatelessWidget {
  final StoreVoucherModel voucher;
  final DateTime time;
  final String customerName;
  final int totalPurchase;
  final int discount;
  const TransactionSuccessfulBody({Key? key,required this.voucher, required this.time,
    required this.customerName, required this.totalPurchase, required this.discount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailList(title: 'Nama Pelanggan', subtitle: customerName),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Total Belanja', subtitle: 'Rp $totalPurchase'),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Diskon', subtitle: 'Rp $discount'),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Total akhir', subtitle: 'Rp ${totalPurchase - discount}'),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Tnggal dan Waktu',
          subtitle: DateFormat("dd MMMM yyyy HH:mm:ss").format(time)),
        SizedBox(height: AppThemes().extraSpacing),
        const DetailList(title: 'Kuantitas', subtitle: '1'),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'ID Voucer', subtitle: voucher.id ?? "Tidak ada Voucer"),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Nama Voucer', subtitle: voucher.name ?? "Tidak ada Voucer"),
      ],
    );
  }
}

class TransactionSuccessfulFooter extends StatelessWidget {
  const TransactionSuccessfulFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.size.width * .5,
            child: ElevatedButton(
              onPressed: () async {
                Get.offAllNamed(AppRoutes.sellerdashboard);
                await Future.delayed(const Duration(milliseconds: 350));
                Get.toNamed(AppRoutes.sellerhistory);
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: AppThemes.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
              ),
              child: Text(
                'Cek Riwayat',
                style: AppThemes().text4Bold(color: AppThemes.white),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.sellerdashboard);
              },
              child: Text(
                'Kembali ke Beranda',
                style: AppThemes().text4Bold(color: AppThemes.blue),
              ),
          )
        ],
      ),
    );
  }
}

class DetailList extends StatelessWidget {
  final String title;
  final String subtitle;
  const DetailList({Key? key,
    required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppThemes().text5Bold(color: AppThemes.black),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: AppThemes().minSpacing),
        Text(
          subtitle,
          style: AppThemes().text5(color: AppThemes.blue),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

