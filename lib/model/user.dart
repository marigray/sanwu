class UserModel {
  String data;
  UserModelDatas datas;
  String responseMsg;
  String responseTime;
  String responseType;
  String uniqueId;

  UserModel(
      {this.data,
      this.datas,
      this.responseMsg,
      this.responseTime,
      this.responseType,
      this.uniqueId});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    datas = json['datas'] != null ? new UserModelDatas.fromJson(json['datas']) : null;
    responseMsg = json['responseMsg'];
    responseTime = json['responseTime'];
    responseType = json['responseType'];
    uniqueId = json['uniqueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    if (this.datas != null) {
      data['datas'] = this.datas.toJson();
    }
    data['responseMsg'] = this.responseMsg;
    data['responseTime'] = this.responseTime;
    data['responseType'] = this.responseType;
    data['uniqueId'] = this.uniqueId;
    return data;
  }
}

class UserModelDatas {
  int mwTotal;
  String village;
  int cwTotal;
  String familyUserName;
  String town;
  int dwTotal;

  UserModelDatas(
      {this.mwTotal,
      this.village,
      this.cwTotal,
      this.familyUserName,
      this.town,
      this.dwTotal});

  UserModelDatas.fromJson(Map<String, dynamic> json) {
    mwTotal = json['mwTotal'];
    village = json['village'];
    cwTotal = json['cwTotal'];
    familyUserName = json['familyUserName'];
    town = json['town'];
    dwTotal = json['dwTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mwTotal'] = this.mwTotal;
    data['village'] = this.village;
    data['cwTotal'] = this.cwTotal;
    data['familyUserName'] = this.familyUserName;
    data['town'] = this.town;
    data['dwTotal'] = this.dwTotal;
    return data;
  }
}