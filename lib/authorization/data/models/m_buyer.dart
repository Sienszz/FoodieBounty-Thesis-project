import 'package:cloud_firestore/cloud_firestore.dart';

class BuyerModel {
  String? imgUrl;
  String? name;
  String? phoneNumber;
  String? email;
  String? id;
  String? token;
  DateTime? resetDate;

  BuyerModel(
      {
        this.imgUrl,
        this.name,
        this.phoneNumber,
        this.email,
        this.id,
        this.token,
        this.resetDate
      }
    );

  BuyerModel.fromJson(Map<String, dynamic> json) {
    imgUrl = json['img_url'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    token = json['token'];
    resetDate = (json['reset_date'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['img_url'] = imgUrl;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}