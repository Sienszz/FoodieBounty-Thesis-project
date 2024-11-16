import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projek_skripsi/application/seller/all_voucher/controllers/all_voucher_controller.dart';
import 'package:projek_skripsi/core/components/form_component.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class DropdownType extends GetView<AllVoucherController> {
  const DropdownType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                  text: 'Tipe Voucer',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                  ],
                ),
              )),
        ),
        Obx(() => InputDecorator(
              decoration: InputDecoration(
                  hintText: 'Tipe',
                  contentPadding: EdgeInsets.all(AppThemes().biggerSpacing),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: AppThemes.darkBlue),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: controller.fieldType.value,
                  isDense: true,
                  onChanged: (String? newValue) {
                    controller.fieldType.value = newValue!;
                  },
                  items: controller.types.map((String value) {
                    print("coba ke print ga: $value");
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: AppThemes().text5(color: Colors.black)),
                    );
                  }).toList(),
                ),
              ),
            )),
      ],
    );
  }
}

class DropdownTypeDiscount extends GetView<AllVoucherController> {
  const DropdownTypeDiscount ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                  text: 'Tipe Diskon',
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: '*', style: TextStyle(color: Colors.red)),
                  ],
                ),
              )),
        ),
        Obx(() => InputDecorator(
          decoration: InputDecoration(
              hintText: 'Tipe',
              contentPadding: EdgeInsets.all(AppThemes().biggerSpacing),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: AppThemes.darkBlue),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: controller.fieldTypeDiscount.value,
              isDense: true,
              onChanged: (String? newValue) {
                controller.fieldTypeDiscount.value = newValue!;
              },
              items: controller.typeDiscount.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: AppThemes().text5(color: Colors.black)),
                );
              }).toList(),
            ),
          ),
        )),
      ],
    );
  }
}

class FormPercentage extends GetView<AllVoucherController> {
  const FormPercentage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FormInputText(
                title: 'Diskon persentase',
                txtcontroller: controller.fieldPercentage,
                textInputType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                txtLine: 1,
                txtEnable: true,
                txtReadonly: false,
                mandatory: true,
                validatorMsg: 'Persentase diskon wajib diisi',
              ),
            ),
            SizedBox(width: AppThemes().extraSpacing),
            Padding(padding: EdgeInsets.only(top: AppThemes().biggerSpacing),
                child: Text('%', style: AppThemes().text4Bold(color: Colors.black))
            )
          ],
        ),
        Obx(() => CheckboxListTile(
          title: Text('Maksimal nominal diskon',
              style: AppThemes().text5(color: Colors.black)),
          dense: true,
          contentPadding: EdgeInsets.zero,
          value: controller.isCheckMaxDisc.value,
          onChanged: (newValue) {
            controller.isCheckMaxDisc.value = !controller.isCheckMaxDisc.value;
          },
        )),
        Obx(() => controller.isCheckMaxDisc.isTrue ?
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: AppThemes().biggerSpacing),
                  child: Text('Rp', style: AppThemes().text5Bold(color: Colors.black))
              ),
              SizedBox(width: AppThemes().extraSpacing),
              Expanded(
                child: FormInputText(
                  title: 'Maks. Nominal diskon',
                  txtcontroller: controller.fieldNominal,
                  textInputType: const TextInputType.numberWithOptions(signed: false, decimal: true),
                  txtLine: 1,
                  txtEnable: true,
                  txtReadonly: false,
                  mandatory: true,
                  validatorMsg: 'Maks. Nominal diskon wajib diisi',
                ),
              ),
            ],
          ) : const SizedBox())
      ],
    );
  }
}

class FormNominal extends GetView<AllVoucherController> {
  const FormNominal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(padding: EdgeInsets.only(top: AppThemes().biggerSpacing),
          child: Text('Rp', style: AppThemes().text5Bold(color: Colors.black))
        ),
        SizedBox(width: AppThemes().extraSpacing),
        Expanded(
          child: FormInputText(
            title: 'Diskon Nominal',
            txtcontroller: controller.fieldNominal,
            textInputType: const TextInputType.numberWithOptions(signed: false, decimal: true),
            txtLine: 1,
            txtEnable: true,
            txtReadonly: false,
            mandatory: true,
            validatorMsg: 'Diskon nominal wajib diisi',
          ),
        ),
      ],
    );
  }
}
