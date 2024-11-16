
class LevelModel {
  List<Map<String, dynamic>>? voucherReward;
  int? exp;
  int? coinReward;
  String? id;

  LevelModel({this.voucherReward, this.exp, this.coinReward, this.id});

  LevelModel.fromJson(Map<String, dynamic> json) {
    exp = json['exp'];
    coinReward = json['coinReward'];
    if(json['voucherReward'] != null){
      voucherReward = [];
      for(var e in json['voucherReward']){
        voucherReward!.add(e);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['voucherReward'] = voucherReward;
    data['exp'] = exp;
    data['coinReward'] = coinReward;
    return data;
  }
}