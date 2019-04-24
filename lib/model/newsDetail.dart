class NewsDetailModel {
  String data;
  NewsDetailDatas datas;
  String responseMsg;
  String responseTime;
  String responseType;
  String uniqueId;

  NewsDetailModel(
      {this.data,
      this.datas,
      this.responseMsg,
      this.responseTime,
      this.responseType,
      this.uniqueId});

  NewsDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    datas = json['datas'] != null ? new NewsDetailDatas.fromJson(json['datas']) : null;
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

class NewsDetailDatas {
  String publicTime;
  String content;
  String typeName;
  String module;
  String title;
  String publicAreaName;
  String type;

  NewsDetailDatas(
      {this.publicTime,
      this.content,
      this.typeName,
      this.module,
      this.title,
      this.publicAreaName,
      this.type});

  NewsDetailDatas.fromJson(Map<String, dynamic> json) {
    publicTime = json['publicTime'];
    content = json['content'];
    typeName = json['typeName'];
    module = json['module'];
    title = json['title'];
    publicAreaName = json['publicAreaName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicTime'] = this.publicTime;
    data['content'] = this.content;
    data['typeName'] = this.typeName;
    data['module'] = this.module;
    data['title'] = this.title;
    data['publicAreaName'] = this.publicAreaName;
    data['type'] = this.type;
    return data;
  }
}