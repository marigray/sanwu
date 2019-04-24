import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'list.dart';
import 'dart:convert';
import './pickdata.dart';
import 'login.dart';
import 'package:provide/provide.dart';
import '../provide/user.dart';
import './home/home_item.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final TextEditingController _controller = new TextEditingController();
  String stateText;

  @override
  void initState() {
    _validUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('榆林智慧村务信息公开系统',),
        backgroundColor: Color(0xFFa31919),
        centerTitle:true,
      ),
      resizeToAvoidBottomPadding: false, //输入框抵住键盘
      body: FutureBuilder(
        future: _getUserInfo(context),
        builder: (context, snapshot){
          if (snapshot.hasData != null) {
            return Container(
              width: ScreenUtil().setWidth(750),
              color: Color.fromRGBO(247, 247, 247, 1),
              child: Column(
                children: <Widget>[
                  _userInfo(),
                  InputTitle(),
                  _seachBox(context),
                  Container(
                    width: ScreenUtil().setWidth(750),
                    color: Colors.white,
                    margin: EdgeInsets.only(top:20),
                    height: ScreenUtil().setHeight(360),
                    child: Container(
                      child: HomeItem(),
                    )
                  ),
                  Container(
                    width:ScreenUtil().setWidth(690),
                    height: ScreenUtil().setHeight(88),
                    margin: EdgeInsets.only(top:ScreenUtil().setHeight(50)),
                  
                    decoration: new BoxDecoration(
                      border: new Border.all(color: Colors.black12, width: 1), // 边色与边宽度
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color.fromRGBO(242, 242, 242, 1),
                        ],
                      ),
                    ),
                    child: new MaterialButton(
                      textColor: Color.fromRGBO(51, 51, 51, 1),
                      child: new Text('退出', style: TextStyle(
                        fontSize: ScreenUtil().setSp(32)
                      ),),
                      onPressed: () {
                          // ...
                      },
                    ),
                  ),
                  
                ],
              ),
            );
          } else {
            return Text('数据加载...');
          }
        },
      ),
      
      
    );
  }

    Future _getUserInfo(BuildContext context )async{
      await Provide.value<UserProvide>(context).setUserInfo('fe4fa4ec639442a2befe0dbed72e3f64');
      return '完成加载';
  }

  void _validUser() {

      //Navigator.of(context).pushNamed("/login");
  }

  Widget _seachBox(context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(left:15, top: 20.0),
      child:  Row(
        children: <Widget>[
              Container(
                child: HomeTypePopMenu(),
                width: ScreenUtil().setWidth(330),
                height: ScreenUtil().setHeight(88),
                color: Colors.white,
              ),
               Container(
                  width: ScreenUtil().setWidth(330),
                  height: ScreenUtil().setHeight(88),
                  margin: EdgeInsets.only(left: 10),
                  child: _searchBut(),
              )
              
        ],
      ),
    );
  }


  Widget _searchBut() {
    return Container(
      width: ScreenUtil().setWidth(330),
      height: ScreenUtil().setHeight(88),
      margin: EdgeInsets.only(left:10.0),
      child: MaterialButton(
        color: Color.fromRGBO(179, 18, 18, 1),
        textColor: Colors.white,
        child: new Text('搜索', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontSize: ScreenUtil().setSp(30)),),
        onPressed: () {
            // ...
        },
      ),
    ); 
  }

  Widget _userInfo() {
    return Container(
      margin: EdgeInsets.only(top:ScreenUtil().setHeight(50), left: ScreenUtil().setHeight(30)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset('assets/images/avater.png'),
            width: ScreenUtil().setWidth(120),
            height: ScreenUtil().setHeight(120),
            margin: EdgeInsets.only(top:10),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text('村名甲', style: TextStyle( color: Color.fromRGBO(51, 51, 51, 1) ,fontSize: ScreenUtil().setSp(36), fontWeight: FontWeight.bold)),
                  margin:EdgeInsets.only(top:10.0),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.asset('assets/images/user-location.png'),
                        width: ScreenUtil().setWidth(31),
                        height: ScreenUtil().setWidth(43),
                      ),
                      Text('某某镇 某某村', style: TextStyle(fontSize: ScreenUtil().setSp(36), color:Color.fromRGBO(51, 51, 51, 1)),)
                    ],
                  ),
                )
              ],
            ),
          )
         
        ],
      ),
    );
  }

  Widget _listOne(title, count, image, typeId) {
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

class InputTitle extends StatefulWidget {
  @override
  _InputTitleState createState() => _InputTitleState();
}

class _InputTitleState extends State<InputTitle> {
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
              margin: EdgeInsets.only(top:30),
              alignment: Alignment.center,
              color: Colors.white,
              width: ScreenUtil().setWidth(690),
              height: ScreenUtil().setHeight(88),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.center,
                height: 60.0,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Color.fromRGBO(230, 230, 230, 1), width: 1.0),
                    borderRadius: new BorderRadius.circular(5.0)
                ),
                child: new TextFormField(
                  decoration: InputDecoration.collapsed(hintText: '请输入关键字', hintStyle: TextStyle(color: Color.fromRGBO(153, 153, 153, 1))),
                  style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1)),
                ),
              )
            
    );
  }
}

class HomeTypePopMenu extends StatefulWidget {
  @override
  _HomeTypePopMenuState createState() => _HomeTypePopMenuState();
}

class _HomeTypePopMenuState extends State<HomeTypePopMenu> {
  String checkValue='全部类型';

 @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Color.fromRGBO(230, 230, 230, 1))
        ),
        child: Center(
          child: PopupMenuButton(
//              icon: Icon(Icons.home),
            child: Container(
              width: ScreenUtil().setWidth(330),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('${checkValue}', style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1), fontSize: ScreenUtil().setSp(34)),),
                    )
                  ),
                  Container(
                    child: Icon(Icons.arrow_drop_down),
                     width: ScreenUtil().setWidth(80),
                  )
                  
                ],
              ),
            ),
            initialValue: "",
            padding: EdgeInsets.all(0.0),
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                PopupMenuItem<String>(child: Text("全部类型"), value: "",),
                PopupMenuItem<String>(child: Text("村务公开"), value: "1",),
                PopupMenuItem<String>(child: Text("财务公开"), value: "2",),
                PopupMenuItem<String>(child: Text("党务公开"), value: "3",),
              ];
            },
            onSelected: (String action) {
              switch (action) {
                case "1":
                  print("村务公开");
                  setState(() {
                   checkValue = "村务公开" ;
                  });
                  break;
                case "2":
                  print("财务公开");
                  setState(() {
                   checkValue = "财务公开" ;
                  });
                  break;
                case "3":
                  print("党务公开");
                  setState(() {
                   checkValue = "党务公开" ;
                  });
                  break;
                default :
                  print("全部");
                  setState(() {
                   checkValue = "全部类型" ;
                  });
                  break;
              }
            },
            onCanceled: () {
              print("onCanceled");
            },
          ),
        ),
    );
  }
}