import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projek_skripsi/core/const/app_themes.dart';

class FormInputText extends StatelessWidget {
  final String title;
  final int txtLine;
  final bool mandatory;
  final bool txtEnable;
  final bool txtReadonly;
  final TextInputType textInputType;
  final TextEditingController txtcontroller;
  final String? validatorMsg;
  final int? maxLength;

  const FormInputText({
    Key? key,
    required this.title,
    required this.txtcontroller,
    required this.textInputType,
    required this.txtLine,
    required this.txtEnable,
    required this.txtReadonly,
    required this.mandatory,
    this.validatorMsg,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        // horizontal: 12.0,
        vertical: 10.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: mandatory ? '*' : '',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                )),
          ),
          SizedBox(
            width: Get.size.width,
            child: TextFormField(
              keyboardType: textInputType,
              controller: txtcontroller,
              maxLines: txtLine,
              maxLength: maxLength,
              enabled: txtEnable,
              readOnly: txtReadonly,
              validator: (value) {
                if (mandatory && (value == null || value.isEmpty)) {
                  return validatorMsg;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: title,
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
          ),
        ],
      ),
    );
  }
}

class FormInputEmail extends StatelessWidget {
  final String title;
  final int txtLine;
  final bool mandatory;
  final bool txtEnable;
  final bool txtReadonly;
  final TextInputType textInputType;
  final TextEditingController txtcontroller;
  final String? validatorMsg;
  final int? maxLength;

  const FormInputEmail({
    Key? key,
    required this.title,
    required this.txtcontroller,
    required this.textInputType,
    required this.txtLine,
    required this.txtEnable,
    required this.txtReadonly,
    required this.mandatory,
    this.validatorMsg,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        // horizontal: 12.0,
        vertical: 10.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: mandatory ? '*' : '',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                )),
          ),
          SizedBox(
            width: Get.size.width,
            child: TextFormField(
              keyboardType: textInputType,
              controller: txtcontroller,
              maxLines: txtLine,
              maxLength: maxLength,
              enabled: txtEnable,
              readOnly: txtReadonly,
              validator: (value) {
                if (mandatory && (value == null || value.isEmpty)) {
                  return validatorMsg;
                } else if(!EmailValidator.validate(value!)){
                  return "Silakan masukkan email yang valid";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: title,
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
          ),
        ],
      ),
    );
  }
}

class FormInputPassword extends StatelessWidget {
  final String title;
  final int txtLine;
  final bool mandatory;
  final bool txtEnable;
  final bool txtReadonly;
  final TextInputType textInputType;
  final TextEditingController txtcontroller;
  final String? validatorMsg;
  final int? maxLength;
  final controller;

  const FormInputPassword({
    Key? key,
    required this.title,
    required this.txtcontroller,
    required this.textInputType,
    required this.txtLine,
    required this.txtEnable,
    required this.txtReadonly,
    required this.mandatory,
    this.validatorMsg,
    this.maxLength,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: mandatory ? '*' : '',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                )),
          ),
          Obx(() => SizedBox(
            width: Get.size.width,
            child: TextFormField(
              obscureText: controller.isHiddenPassword.value,
              keyboardType: textInputType,
              controller: txtcontroller,
              maxLines: txtLine,
              maxLength: maxLength,
              enabled: txtEnable,
              readOnly: txtReadonly,
              validator: (value) {
                if (mandatory && (value == null || value.isEmpty)) {
                  return validatorMsg;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: title,
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
                  suffixIcon: IconButton(
                    onPressed: () => controller.isHiddenPassword.value =
                      !controller.isHiddenPassword.value,
                    icon: controller.isHiddenPassword.value ?
                      const Icon(Icons.visibility_off, color: AppThemes.blue) :
                      const Icon(Icons.visibility, color: AppThemes.blue),
                  )
              ),
              style: const TextStyle(fontSize: 14),
            ),
          )),
        ],
      ),
    );
  }
}

class FormInputConfirmPassword extends StatelessWidget {
  final String title;
  final int txtLine;
  final bool mandatory;
  final bool txtEnable;
  final bool txtReadonly;
  final TextInputType textInputType;
  final TextEditingController txtcontroller;
  final String? validatorMsg;
  final int? maxLength;
  final controller;

  const FormInputConfirmPassword({
    Key? key,
    required this.title,
    required this.txtcontroller,
    required this.textInputType,
    required this.txtLine,
    required this.txtEnable,
    required this.txtReadonly,
    required this.mandatory,
    this.validatorMsg,
    this.maxLength,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: mandatory ? '*' : '',
                          style: const TextStyle(color: Colors.red)),
                    ],
                  ),
                )),
          ),
          Obx(() => SizedBox(
            width: Get.size.width,
            child: TextFormField(
              obscureText: controller.isHiddenPassword.value,
              keyboardType: textInputType,
              controller: txtcontroller,
              maxLines: txtLine,
              maxLength: maxLength,
              enabled: txtEnable,
              readOnly: txtReadonly,
              validator: (value) {
                if (mandatory && (value == null || value.isEmpty)) {
                  return validatorMsg;
                } else if(controller.fieldPassword.text != '' &&
                controller.fieldPassword.text != value){
                  return "Konfirmasi kata sandi tidak cocok";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: title,
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
                  suffixIcon: IconButton(
                    onPressed: () => controller.isHiddenPassword.value =
                    !controller.isHiddenPassword.value,
                    icon: controller.isHiddenPassword.value ?
                    const Icon(Icons.visibility_off, color: AppThemes.blue) :
                    const Icon(Icons.visibility, color: AppThemes.blue),
                  )
              ),
              style: const TextStyle(fontSize: 14),
            ),
          )),
        ],
      ),
    );
  }
}

class FormInputAddress extends StatelessWidget {
  final String title;
  final int txtLine;
  final bool mandatory;
  final bool txtEnable;
  final bool txtReadonly;
  final TextInputType textInputType;
  final TextEditingController txtcontroller;
  final String? validatorMsg;
  final int? maxLength;
  final controller;

  const FormInputAddress({
    Key? key,
    required this.title,
    required this.txtcontroller,
    required this.textInputType,
    required this.txtLine,
    required this.txtEnable,
    required this.txtReadonly,
    required this.mandatory,
    this.validatorMsg,
    this.maxLength,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        // horizontal: 12.0,
        vertical: 10.0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: title,
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: mandatory ? '*' : '',
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                )),
                ElevatedButton(
                  onPressed: () => controller.onGetAddress(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemes.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      )
                  ),
                  child: Text(
                    'Dapatkan Alamat',
                    style: AppThemes().text5Bold(color: AppThemes.white),
                  ),
                )
              ],
            )
          ),
          SizedBox(
            width: Get.size.width,
            child: TextFormField(
              keyboardType: textInputType,
              controller: txtcontroller,
              maxLines: txtLine,
              maxLength: maxLength,
              enabled: txtEnable,
              readOnly: txtReadonly,
              validator: (value) {
                if (mandatory && (value == null || value.isEmpty)) {
                  return validatorMsg;
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: title,
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
          ),
        ],
      ),
    );
  }
}

class FormInputDate extends StatelessWidget {
  final String title;
  final int txtLine;
  final bool mandatory;
  final bool txtEnable;
  final bool txtReadonly;
  final TextInputType textInputType;
  final TextEditingController txtcontroller;
  final String? validatorMsg;
  final int? maxLength;
  final controller;

  const FormInputDate({
    Key? key,
    required this.title,
    required this.txtcontroller,
    required this.textInputType,
    required this.txtLine,
    required this.txtEnable,
    required this.txtReadonly,
    required this.mandatory,
    this.validatorMsg,
    this.maxLength,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        // horizontal: 12.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
              child:
              RichText(
                text: TextSpan(
                  text: title,
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(text: mandatory ? '*' : '',
                        style: const TextStyle(color: Colors.red)),
                  ],
                ),
            )
          ),
          SizedBox(
            width: Get.size.width,
            child: TextFormField(
              keyboardType: textInputType,
              controller: txtcontroller,
              maxLines: txtLine,
              maxLength: maxLength,
              enabled: txtEnable,
              readOnly: txtReadonly,
              validator: (value) {
                if (mandatory && (value == null || value.isEmpty)) {
                  return validatorMsg;
                } else {
                  return null;
                }
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  txtcontroller.text = formattedDate;
                }
              },
              decoration: InputDecoration(
                hintText: title,
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
          ),
        ],
      ),
    );
  }
}