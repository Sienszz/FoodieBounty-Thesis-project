import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';


class GenerateQRComponent extends StatelessWidget {
  final String data;

  const GenerateQRComponent({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: QrImageView(
        data: data,
        version: QrVersions.auto,
      ),
    );
  }

}
