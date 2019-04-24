class NewsModel {
  String data;
  Datas datas;
  String responseMsg;
  String responseTime;
  String responseType;
  String uniqueId;

  NewsModel(
      {this.data,
      this.datas,
      this.responseMsg,
      this.responseTime,
      this.responseType,
      this.uniqueId});

  NewsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    datas = json['datas'] != null ? new Datas.fromJson(json['datas']) : null;
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

class Datas {
  int totalNum;
  List<PageList> pageList;
  String pageNo;
  String pageSize;

  Datas({this.totalNum, this.pageList, this.pageNo, this.pageSize});

  Datas.fromJson(Map<String, dynamic> json) {
    totalNum = json['totalNum'];
    if (json['pageList'] != null) {
      pageList = new List<PageList>();
      json['pageList'].forEach((v) {
        pageList.add(new PageList.fromJson(v));
      });
    }
    pageNo = json['pageNo'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalNum'] = this.totalNum;
    if (this.pageList != null) {
      data['pageList'] = this.pageList.map((v) => v.toJson()).toList();
    }
    data['pageNo'] = this.pageNo;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class PageList {
  String publicTime;
  String id;
  String module;
  String title;

  PageList({this.publicTime, this.id, this.module, this.title});

  PageList.fromJson(Map<String, dynamic> json) {
    publicTime = json['publicTime'];
    id = json['id'];
    module = json['module'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicTime'] = this.publicTime;
    data['id'] = this.id;
    data['module'] = this.module;
    data['title'] = this.title;
    return data;
  }
}
