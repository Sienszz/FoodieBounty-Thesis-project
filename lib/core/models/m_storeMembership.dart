import 'package:projek_skripsi/core/models/m_level.dart';

class StoreMembershipModel {
  String? address;
  String? imgUrl;
  String? name;
  String? phoneNumber;
  List<String>? tag;
  String? email;
  double? latitude;
  double? longitude;
  String? id;
  int? level;
  int? exp;
  int? coin;
  int? totalVoucher;
  double distanceWithUser = 0.0;
  List<LevelModel>? lsLevelStore;

  StoreMembershipModel(
      {this.address,
      this.imgUrl,
      this.name,
      this.phoneNumber,
      this.tag,
      this.email,
      this.latitude,
      this.longitude,
      this.id,
      this.level, 
      this.exp, 
      this.coin,
      this.totalVoucher,
      });

  StoreMembershipModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    imgUrl = json['img_url'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    if(json['tag'] != null){
      tag = <String>[];
      for(var e in json['tag']) {
        tag!.add(e);
      }
    }
    email = json['email'];
    if (json['latitude'] != null) {
      latitude = json['latitude'];
    }
    if (json['longitude'] != null) {
      longitude = json['longitude'];  
    }
    level = json['level'];
    exp = json['exp'];
    coin = json['coin'].toInt();
    totalVoucher = json['total_voucher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['img_url'] = imgUrl;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['tag'] = tag;
    data['email'] = email;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['level'] = level;
    data['exp'] = exp;
    data['coin'] = coin;
    data['total_voucher'] = totalVoucher;
    return data;
  }
}