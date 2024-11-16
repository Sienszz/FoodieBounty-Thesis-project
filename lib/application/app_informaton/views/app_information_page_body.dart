import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class AppInformationPageBody extends StatelessWidget {
  const AppInformationPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bagaimana cara melakukan transaksi?',
          style: AppThemes().text3Bold(color: AppThemes.black),
        ),
        SizedBox(width: AppThemes().extraSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '1. Pelanggan harus menampilkan barcode-nya dengan mengklik tombol bergambar barcode di bawah.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '2. Penjual atau toko akan memindai barcode pelanggan dengan mengklik tombol dengan ikon barcode di bawah pada akun penjual.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '3. Penjual akan memasukkan total jumlah pembelian atau transaksi dan memindai barcode voucher pelanggan jika pelanggan ingin menggunakannya dan total pembelian memenuhi syarat minimum transaksi voucher tersebut.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().veryExtraSpacing),
        const Divider(
          thickness: 1,
          color: AppThemes.darkBlue,
        ),
        SizedBox(width: AppThemes().veryExtraSpacing),
        Text(
          'Bagaimana aplikasi ini bekerja?',
          style: AppThemes().text3Bold(color: AppThemes.black),
        ),
        SizedBox(width: AppThemes().extraSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '1. Setiap pelanggan yang melakukan transaksi pertamanya di suatu toko secara otomatis akan menjadi anggota toko tersebut.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '2. Setiap keanggotaan pelanggan di sebuah toko memiliki koin dan poin pengalaman (exp) masing-masing.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '3. Pelanggan akan menerima koin dan poin pengalaman (exp) sebagai hadiah untuk setiap transaksi di toko tersebut.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '4. Untuk setiap Rp. 1.000 transaksi, pelanggan akan menerima 1 koin dan 1 exp.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '5. EXP yang diperoleh dari transaksi akan diakumulasikan seiring transaksi pelanggan terhadap toko tersebut.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        // SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '6. Pelanggan dapat menggunakan koinnya untuk membeli voucher di toko tersebut.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '7. Setiap voucher memiliki tanggal kadaluwarsa.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
        SizedBox(width: AppThemes().biggerSpacing),
        SizedBox(
          width: Get.size.width * 0.8,
          child: Text(
            '8. Setiap 6 bulan, tingkat loyalitas pelanggan akan direset.',
            style: AppThemes().text4(color: AppThemes.black),
          ),
        ),
      ],
    );
  }
}