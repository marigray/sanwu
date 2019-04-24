import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../model/user.dart';
import '../util/httpUtil.dart';
import 'dart:convert';


class UserProvide with ChangeNotifier {

  UserModel userInfo;

  setUserInfo(String uid) async{
      var formData = {
        "familyId":uid
      };
      String url = "http://47.110.95.212:6003/yunlansoft/a/wap/public/showHome";

      await HttpUtil().get(url, data: formData).then((val){
        var data = json.decode(val.toString());
        userInfo = UserModel.fromJson(data);
        notifyListeners();
      });

  }

}
