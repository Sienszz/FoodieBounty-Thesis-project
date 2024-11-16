import 'package:cloud_firestore/cloud_firestore.dart';

class StoreHistoryModel {
  DateTime? date;
  int? total;
  String? voucherId;
  String? customerId;
  String? customerName;
  String? id;

  StoreHistoryModel({this.date, this.total, this.voucherId, 
    this.customerName, this.customerId});

  StoreHistoryModel.fromJson(Map<String, dynamic> json) {
    date = (json['date'] as Timestamp).toDate();
    total = json['total'];
    voucherId = json['voucher_id'];
    customerName = json['customer_name'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['total'] = total;
    data['voucher_id'] = voucherId;
    data['customer_name'] = customerName;
    data['customer_id'] = customerId;
    return data;
  }
}