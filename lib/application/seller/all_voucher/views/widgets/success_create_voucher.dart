import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';
import 'package:projek_skripsi/utils/routes.dart';

class SuccessCreateVoucher extends StatelessWidget {
  final StoreVoucherModel data;
  const SuccessCreateVoucher({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppThemes.blue,
      body: SafeArea(
        child: SingleChildScrollView(
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
              const SuccessVoucherHeader(),
              SizedBox(height: AppThemes().veryExtraSpacing),
              SuccessVoucherBody(data: data),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppThemes().extraSpacing),
                child: const Separator(),
              ),
              const SuccessVoucherFooter()
            ],
          ),
        ),
        )
      ),
    );
  }
}

class SuccessVoucherHeader extends StatelessWidget {
  const SuccessVoucherHeader({Key? key}) : super(key: key);

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
        Text('Voucer Berhasil Dibuat!',
            style: AppThemes().text3Bold(color: AppThemes.blue)),
        SizedBox(height: AppThemes().extraSpacing),
        Text('Voucer Anda telah berhasil dibuat dan telah '
            'ditambahkan ke toko Anda:',
            style: AppThemes().text4(color: AppThemes.blue),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class SuccessVoucherBody extends StatelessWidget {
  final StoreVoucherModel data;
  const SuccessVoucherBody({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailList(title: 'Nama Voucer', subtitle: data.name!),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Kuantitas', subtitle: data.qty == null ? "-" : data.qty!.toString()),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Tanggal Kadaluarsa', subtitle: DateFormat("dd MMM yyyy").format(data.expDate!)),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Koin Diperlukan', subtitle: data.coin == null ? "-" : '${data.coin!.toString()} Coins'),
        SizedBox(height: AppThemes().extraSpacing),
        DetailList(title: 'Deskripsi',
        subtitle: data.description!),
      ],
    );
  }
}

class SuccessVoucherFooter extends StatelessWidget {
  const SuccessVoucherFooter({Key? key}) : super(key: key);

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
                Get.toNamed(AppRoutes.sellerallvoucher);
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: AppThemes.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)
                ),
              ),
              child: Text(
                'Cek Toko',
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

