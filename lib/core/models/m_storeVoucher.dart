import 'package:cloud_firestore/cloud_firestore.dart';

class StoreVoucherModel {
  int? coin;
  int? qty;
  String? name;
  String? description;
  DateTime? expDate;
  String? type;
  int? minTransaction;
  String? typeDiscount;
  double? percentage;
  int? maxNominal;
  int? nominal;
  String? id;

  StoreVoucherModel(
      {this.coin,
      this.qty,
      this.name,
      this.description,
      this.expDate,
      this.type,
      this.minTransaction,
      this.typeDiscount,
      this.percentage,
      this.maxNominal,
      this.nominal,
      this.id});

  StoreVoucherModel.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    qty = json['qty'];
    name = json['name'];
    description = json['description'];
    expDate = (json['exp_date'] as Timestamp).toDate();
    type = json['type'];
    minTransaction = json['min_transaction'];
    typeDiscount = json['type_discount'];
    if(json['percentage'] != null) {
      percentage = json['percentage'].toDouble();
    }
    maxNominal = json['max_nominal'];
    nominal = json['nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coin'] = coin;
    data['qty'] = qty;
    data['name'] = name;
    data['description'] = description;
    data['exp_date'] = expDate;
    data['type'] = type;
    data['min_transaction'] = minTransaction;
    return data;
  }
}