import 'package:projek_skripsi/core/models/m_level.dart';

class StoreModel {
  String? address;
  String? imgUrl;
  String? name;
  String? phoneNumber;
  String? email;
  String? token;
  double? latitude;
  double? longitude;
  List<String>? lsTag;
  String? id;
  List<LevelModel> lsLevel = List<LevelModel>.empty();

  StoreModel(
      {this.address,
      this.imgUrl,
      this.name,
      this.phoneNumber,
      this.email,
      this.latitude,
      this.longitude,
      this.token,
      this.lsTag,
      this.id});

  StoreModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    imgUrl = json['img_url'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
    token = json['token'];
    if(json['tag'] != null){
      lsTag = <String>[];
      for(var e in json['tag']) {
        lsTag!.add(e);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['img_url'] = imgUrl;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['latitude'] = latitude.toString();
    data['longitude'] = longitude.toString();
    data['token'] = token;
    return data;
  }
}