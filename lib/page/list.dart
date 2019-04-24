import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:sanwu/model/news.dart';
import 'detail.dart';
import '../provide/news.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListPage extends StatefulWidget {
  int typeId;
  ListPage({Key key, this.typeId}) : super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with SingleTickerProviderStateMixin{
  TabController mController;
  List newsLists= [];
  int page = 1;
  int newsCount= 0;
  int type;

  @override
  void initState() {
    type = widget.typeId;
    print(type);
    if (type != widget.typeId) {
      Provide.value<NewsProvide>(context).setNewsList([]);
      page = 1;
    } 

    _getList(page, type);
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Color.fromRGBO(163, 25, 25, 1)
      ),
      body: SingleChildScrollView(
        child:  Container(
          width: ScreenUtil().setWidth(750),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(750),
                height: ScreenUtil().setHeight(102),
                padding: EdgeInsets.all(0),
                child:Row(
                  children: <Widget>[
                    Container(
                      child: _tabItem('财务公开', 1),
                    ),
                    Container(
                      child: _tabItem('村务公开', 2),
                    ),
                    Container(
                      child: _tabItem('党务公开', 3),
                    ),
                  ],
                )
              ),
              Container(
                color: Colors.black12,
                width: ScreenUtil().setWidth(750),
                height: 1,
              ),
              Container(
                width: ScreenUtil().setWidth(750),
                height: ScreenUtil().setHeight(70),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 30),
                color: Color.fromRGBO(247, 247, 247, 1),
                child: Text('${newsCount}条公开内容'),
              ),
              Container(
                  width: ScreenUtil().setWidth(750),
                  height: ScreenUtil().setHeight(1100),
                  child: ListNews(),
              ),
              
              
            ],
          ),
        )
      )  
    );
  }

  Widget _tabItem(title, i) {
    return Container(
      width: ScreenUtil().setWidth(250),
      height: ScreenUtil().setHeight(102),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: type == i? Color.fromRGBO(179, 18, 18, 1) :Color.fromRGBO(255, 255, 255, 1),
            width: 2.0
          )
        )
      ),
      child: InkWell(
        child: Text('${title}', 
          style: TextStyle(
            color: type == i? Colors.pink :Colors.black, 
            fontSize: ScreenUtil().setSp(34),
            fontWeight: type == i ? FontWeight.bold : FontWeight.normal
          ),
        ),
        onTap: () {
          print(i);
          _getList(page, i);
        },
      ),
    );
  }

  //areaId=610823001001&moduleType=3  
   Future _getList (page, typeId) async {
    
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    
    try {   
      response = await dio.get("http://47.110.95.212:6003/yunlansoft/a/wap/public/selectList", 
        queryParameters: {
          'areaId':610823001001,
          'moduleType': typeId,
        }
      );
      var data = json.decode(response.data.toString());
      NewsModel newsModel = NewsModel.fromJson(data);

      setState(() {
        type = typeId;
        newsCount = newsModel.datas.totalNum;
      });

      Provide.value<NewsProvide>(context).setNewsCount(newsModel.datas.totalNum);
        // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
      if (Provide.value<NewsProvide>(context).type == typeId) {
        if(newsModel.datas.pageList==null){
          Provide.value<NewsProvide>(context).setNewsList([]);
        }else{
          Provide.value<NewsProvide>(context).addNewsList(newsModel.datas.pageList);
        }
      } else {
        if(newsModel.datas.pageList==null){
          Provide.value<NewsProvide>(context).setNewsList([]);
        }else{
          Provide.value<NewsProvide>(context).setNewsList(newsModel.datas.pageList);
        }
      }
      Provide.value<NewsProvide>(context).setTypeId(typeId);
    } catch (e) {
      print('网络错误！');
    }
  }

}

class ListNews extends StatefulWidget {
  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  var scrollController=new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<NewsProvide>(
      builder: (context, child, data){
        if (data.newsList.length > 0) {
          return Container(
                  width: ScreenUtil().setWidth(570) ,
                  child:EasyRefresh(
                    refreshFooter: ClassicsFooter(
                      key:_footerKey,
                      bgColor:Colors.white,
                      textColor:Colors.pink,
                      moreInfoColor: Colors.pink,
                      showMore:true,
                      noMoreText:Provide.value<NewsProvide>(context).noMoreText,
                      moreInfo:'加载中',
                      loadReadyText:'上拉加载'
                    ),
                    child:ListView.builder(
                      itemCount: data.newsList.length,
                      itemBuilder: (context,index){
                        return _listOne(data.newsList[index]);
                      },
                    ),
                    loadMore: ()async{
                      if(Provide.value<NewsProvide>(context).noMoreText=='没有更多了'){
                         Fluttertoast.showToast(
                            msg: "已经到底了",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.pink,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else{
                         _getMoreNewsList();
                      }
                     
                    },
                  )
                  
              );
              
        } else {
            return  Text('暂时没有数据');
        }
      },
    );
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

  Future _getMoreNewsList() async{
    Provide.value<NewsProvide>(context).setPage();
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    
    try {   
      response = await dio.get("http://47.110.95.212:6003/yunlansoft/a/wap/public/selectList", 
        queryParameters: {
          'areaId':Provide.value<NewsProvide>(context).areaId,
          'page':Provide.value<NewsProvide>(context).page,
          'type':Provide.value<NewsProvide>(context).type
        }
      );
      var data = json.decode(response.data.toString());
    
      NewsModel newsModel = NewsModel.fromJson(data);


      Provide.value<NewsProvide>(context).setNewsCount(newsModel.datas.totalNum);
        // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
      //print(newsModel.datas.pageList);
      if(newsModel.datas.pageList==null){
        Provide.value<NewsProvide>(context).setNewsList([]);
      }else{
        Provide.value<NewsProvide>(context).setNewsList(newsModel.datas.pageList);
      }
    } catch (e) {
      print('网络错误！');
    }

  }

}