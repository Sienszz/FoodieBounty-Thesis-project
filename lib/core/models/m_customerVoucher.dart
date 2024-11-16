import 'package:cloud_firestore/cloud_firestore.dart';


class CustomerVoucher {
  String? voucherId;
  DateTime? expDate;
  DateTime? purchaseDate;
  String? id;

  CustomerVoucher({this.voucherId, this.expDate, this.purchaseDate, this.id});

  CustomerVoucher.fromJson(Map<String, dynamic> json) {
    voucherId = json['voucher_id'];
    expDate = (json['exp_date'] as Timestamp).toDate();
    purchaseDate = (json['purchase_date'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voucher_id'] = voucherId;
    data['exp_date'] = expDate;
    data['purchase_date'] = purchaseDate;
    return data;
  }
}