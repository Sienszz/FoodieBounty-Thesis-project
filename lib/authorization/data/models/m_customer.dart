class CustomerModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? id;
  String? token;

  CustomerModel({this.name, this.phoneNumber, this.email, this.id, this.token});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}