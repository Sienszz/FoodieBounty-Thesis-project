
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/leveling/controllers/create_level_controller.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';
import 'package:projek_skripsi/core/models/m_level.dart';

class LevelingCard extends StatelessWidget {
  final String title;
  final Color color;
  final LevelModel data;

  const LevelingCard({Key? key, required this.title, 
    required this.color, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width * .8,
      padding: EdgeInsets.symmetric(
        vertical: AppThemes().extraSpacing,
        horizontal: AppThemes().defaultSpacing,
      ),
      margin: EdgeInsets.only(bottom: AppThemes().extraSpacing),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 3.0,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(title, style: AppThemes().text5Bold(color: AppThemes.white)),
                  SizedBox(height: AppThemes().extraSpacing),
                  Text('Exp dibutuhkan: ${data.exp == null ? 'Belum diatur' : '${data.exp!} EXP'}',
                      style: AppThemes().text5(color: AppThemes.white)),
                  SizedBox(height: AppThemes().extraSpacing),
                  Text('Hadiah: ${data.coinReward ?? "-"} Koin & ${data.voucherReward == null ? "-" : data.voucherReward!.length} Voucer',
                      style: AppThemes().text5(color: AppThemes.white)),
                ],
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios, color: AppThemes.white))
        ],
      ),
    );
  }
}

class VoucherField extends GetView<CreateLevelController> {
  final int index;
  const VoucherField({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppThemes().extraSpacing),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.removeReward(index),
            child: const Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 30,
            ),
          ),
          SizedBox(width: AppThemes().defaultSpacing),
          Expanded(
              child: Obx(() => controller.lsStoreVoucher.isEmpty ?
                Center(child: const Text("Tidak Ada Data Voucer")) : 
                InputDecorator(
                  decoration: InputDecoration(
                      hintText: 'Voucer',
                      contentPadding: EdgeInsets.all(AppThemes().biggerSpacing),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 1, color: AppThemes.darkBlue),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: controller.lsFieldReward[index],
                      isDense: true,
                      onChanged: (newValue) {
                        controller.lsFieldReward[index] = newValue!;
                      },
                      items: controller.lsStoreVoucher.map((value) {
                        return DropdownMenuItem<String>(
                          value: value.id!,
                          child: Text(value.name!),
                        );
                      }).toList(),
                    ),
                  ),
                ))
          )
        ],
      ),
    );
  }
}

class CoinField extends GetView<CreateLevelController> {
  final int index;
  const CoinField({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppThemes().extraSpacing),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.removeReward(index),
            child: const Icon(
              Icons.remove_circle_outline,
              color: Colors.red,
              size: 30,
            ),
          ),
          SizedBox(width: AppThemes().defaultSpacing),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller.lsFieldReward[index],
              maxLines: 1,
              enabled: true,
              readOnly: false,
              decoration: InputDecoration(
                hintText: 'Koin',
                hintStyle:
                TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.only(top: 12.0, left: 12.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppThemes.darkBlue, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppThemes.darkBlue, width: 1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              style: const TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
