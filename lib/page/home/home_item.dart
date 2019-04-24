import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/user.dart';
import '../list.dart';


class HomeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<UserProvide>(
      builder: (context, child, val){
        var userInfo  = Provide.value<UserProvide>(context).userInfo;
        if (userInfo != null) {
          return Container(
              width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(370),
              child: ListView(
                children:<Widget>[
                  _listOne(context, '村务公开', '${userInfo.datas.cwTotal}', 'cunwu', 2),//(1=财务公开 2=村务公开3=党务公开)
                  _listOne(context, '财务公开', '${userInfo.datas.mwTotal}', 'caiwu', 1),
                  _listOne(context, '党务公开', '${userInfo.datas.dwTotal}', 'dangwu', 3),
                ]
              ),
          );

        } else {
          return Text('加载中');
        }
      },
    );
  }

  Widget _listOne(context, title, count, image, typeId) {
    return Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          margin: EdgeInsets.only(left: ScreenUtil().setWidth(30), top: 5),
          width: ScreenUtil().setWidth(690),
          decoration: new BoxDecoration(
              border: new Border( bottom: BorderSide(color: Color.fromRGBO(230, 230, 230, 1), width: 1)),
            ),
            child: InkWell(
              onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new ListPage(typeId: typeId,)),
                  );
              },
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/${image}.png'),
                    margin: EdgeInsets.only(left:5.0),
                    width: ScreenUtil().setWidth(43),
                    height: ScreenUtil().setHeight(43),
                  ),
                  Expanded(
                    child:  Container(
                      child: Text('${title}',
                          style: TextStyle(color: Color.fromRGBO(100, 100, 100, 1), fontSize: ScreenUtil().setSp(42)) ),
                      margin: EdgeInsets.only(left: 5.0),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Text("${count}条"),

                  ),

                  Container(
                    child: Image.asset('assets/images/more.png'),
                    margin: EdgeInsets.only(right: 5),
                  ),
                  
                ],
              ),
            ),
            
    );
  }
}