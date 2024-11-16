import 'package:projek_skripsi/authorization/data/models/m_store.dart';
import 'package:projek_skripsi/core/models/m_storeVoucher.dart';

class CustomerHistoryModel {
  int? coin;
  DateTime? transactionDate;
  int? exp;
  String? storeId;
  int? totalPrice;
  int? totalCoin;
  String? type;
  String? id;
  String? voucherid;
  String? token;
  StoreVoucherModel voucherModel = StoreVoucherModel();
  StoreModel storeModel = StoreModel();

  CustomerHistoryModel({this.coin, this.transactionDate, this.exp, this.storeId, this.totalPrice, this.type, this.id, this.token});

  CustomerHistoryModel.fromJson(Map<String, dynamic> json) {
    coin = json['coin'];
    transactionDate = json['date'].toDate();
    exp = json['exp'];
    storeId = json['store_id'];
    totalPrice = json['total_price'];
    totalCoin = json['total_coin'];
    type = json['type'];
    voucherid = json['voucher_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coin'] = coin;
    data['date'] = transactionDate;
    data['exp'] = exp;
    data['store_id'] = storeId;
    data['total_price'] = totalPrice;
    data['type'] = type;
    data['voucher_id'] = voucherid;
    data['token'] = token;
    return data;
  }
}