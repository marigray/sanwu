import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import '../model/newsDetail.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPage extends StatefulWidget {
  String id;
  String areaId;
  DetailPage({Key key, @required this.id, @required this.areaId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  NewsDetailDatas newsDetail;
  String title="";
  String content="";
  String time="";

  @override
  void initState() {
    super.initState();
    _getNewsDetail();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("村务公开"),
          backgroundColor: Color.fromRGBO(163, 25, 25, 1)
        ),
        body: SingleChildScrollView(
          child:  Container(
            color: Colors.white,
            width: ScreenUtil().setWidth(750),
            child:_showContent(context),
          )
        ),
    );
  }

  Widget _showContent(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: ScreenUtil().setWidth(750),
                  child: Text('${title}', style: TextStyle(fontSize: ScreenUtil().setSp(34), fontWeight: FontWeight.bold), maxLines: 2,),
                ),
                Container(
                  child: Text('${time}', style: TextStyle( fontSize: ScreenUtil().setSp(30), color: Colors.black26),),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                ),
                Container(
                  child: Divider(
                    color: Colors.black12,
                  ),
                ),
                Container(
                  child: Container(
                    child: Html(
                              data: """
                                ${content}
                              """,
                              //Optional parameters:
                              padding: EdgeInsets.all(8.0),
                              backgroundColor: Colors.white70,
                              defaultTextStyle: TextStyle(fontFamily: 'serif'),
                              linkStyle: const TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                  ),
                )
              ],
            ),
      );
  }

  Future _getNewsDetail () async {
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    // areaId=610823001001&publicId=ddc071419cfd40928d8d8fc76a6b7e41
    response = await dio.get("http://47.110.95.212:6003/yunlansoft/a/wap/public/selectOne", 
      queryParameters: {
        'areaId':610823001001,
        'publicId': '${widget.id}',
      }
    );
    var data = json.decode(response.data.toString());
    
    NewsDetailModel newsDetailModel = NewsDetailModel.fromJson(data);
    setState(() {
      newsDetail = newsDetailModel.datas;
      title = newsDetailModel.datas.title;
      content =newsDetailModel.datas.content;
      time = newsDetailModel.datas.publicTime;
    });
  }

}