import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:sanwu/model/news.dart';
import 'detail.dart';
import '../provide/count.dart';
import 'login.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with SingleTickerProviderStateMixin{
  TabController mController;
  List<TabTitle> tabList;

  List newsLists= [];
  int page = 1;

  @override
  void initState() {
    _getList(page, 1);
    initTabData();
    mController = TabController(
      length: tabList.length,
      vsync: this,
    );
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }
  
  initTabData() {
    tabList = [
      new TabTitle('党务公开', 1),
      new TabTitle('村务公开', 2),
      new TabTitle('财务公开', 3),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Color.fromRGBO(163, 25, 25, 1)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provide.value<Counter>(context).increment();
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        width: ScreenUtil().setWidth(750),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Provide<Counter>(
              builder: (context, child, counter) {
                return Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            Container(
              child: InkWell(
                child: Text('provide'),
                onTap: () {
                    Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ),
            Container(
              color: Colors.white,
              height: ScreenUtil().setHeight(100),
              child: TabBar(
                isScrollable: false,
                //是否可以滚动
                controller: mController,
                indicatorColor: Color.fromRGBO(179, 18, 18, 1),
                indicatorWeight: 2.0,
                labelColor: Color.fromRGBO(179, 18, 18, 1),
                labelStyle: TextStyle(fontSize: ScreenUtil().setSp(34), fontWeight: FontWeight.bold),
                unselectedLabelColor: Color.fromRGBO(102, 102, 102, 1),
                unselectedLabelStyle: new TextStyle(fontSize: ScreenUtil().setSp(34), fontWeight: FontWeight.normal),
                tabs: tabList.map((item) {
                  return Tab(
                    text: item.title,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: mController,
                children: [
                    _TabPage1(context, 1),
                    _TabPage1(context, 2),
                    _TabPage1(context, 3),
                ]
              ),
            )
          ],
        ),
      )  
    );
  }
  //areaId=610823001001&moduleType=3  
   Future _getList (page, type) async {
    
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    
    try {   
      response = await dio.get("http://47.110.95.212:6003/yunlansoft/a/wap/public/selectList", 
        queryParameters: {
          'areaId':610823001001,
          'moduleType': type,
        }
      );
      var data = json.decode(response.data.toString());
    
      NewsModel newsModel = NewsModel.fromJson(data);
      setState(() {
        newsLists = newsModel.datas.pageList; 
      });
    } catch (e) {
      print('网络错误！');
    }

  }

  Widget _listOne(item){
    return Container(
        width: ScreenUtil().setWidth(750),
        margin: EdgeInsets.only(top:10),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left:30),
        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new DetailPage(id: '${item.id}', areaId: '${item.module}',)),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(690),
                padding: EdgeInsets.only(right:30),
                alignment: Alignment.centerLeft,
                child: Text(
                  item.title, 
                  maxLines: 2, 
                  style: TextStyle(fontSize: ScreenUtil().setSp(34), color: Color.fromRGBO(51, 51, 51, 1)),
                ),
              ),
              Container(
                child: Text(item.publicTime, style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Color.fromRGBO(217, 217, 217, 1))),
                alignment: Alignment.centerLeft,
              ),
              Container(
                padding: EdgeInsets.only(right:30),
                child: Divider(
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
              )
            ],
          ),
        )
          
    );
  }

  Widget _TabPage1(context, type) {
    _getList(page, type);
    return Container(
      width: ScreenUtil().setWidth(690),
      child: ListView.builder(
          itemCount: newsLists.length,
          itemBuilder: (context, index) {
            return _listOne(newsLists[index]);
          },
      )
    );
  }

}

class TabTitle {
  String title;
  int id;

  TabTitle(this.title, this.id);
}

