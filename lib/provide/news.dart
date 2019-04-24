import 'package:flutter/material.dart';
import '../model/news.dart';

class NewsProvide with ChangeNotifier{
  int areaId=610823001001;
  int page=1;
  int type=1;
  List<PageList> newsList=[];
  int count=0;
  String noMoreText='';

  setAreaId(int areaId) {
    areaId = areaId;
    notifyListeners();
  }

  setNewsCount(int count) {
    count = count;
    notifyListeners();
  }

  setTypeId(int typeid) {
    type = typeid;
    notifyListeners();
  }

  setNewsTip(String text) {
    noMoreText = text;
    notifyListeners();
  }

  setPage() {
    page = page+1;
    notifyListeners();
  }

  setNewsList(List<PageList> list) {
    newsList=list;
    notifyListeners();
  }

  addNewsList(List<PageList> list) {
    newsList.addAll(list);
    notifyListeners();
  }

}