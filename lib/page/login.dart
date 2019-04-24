import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/count.dart';
import 'home.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                _loginBg(),
                _loginForm()
              ],  
            ),
          ),
        )    
    );
  }

  Widget _loginBg() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(472),
      child: Image.asset('assets/images/login-top.png', fit: BoxFit.fill,),
    );
  }

  Widget _loginForm() {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.only(top:ScreenUtil().setHeight(130)),
      child: Column(
        children: <Widget>[
          InputPhoneNum(),
          Container(
            child: Row(
              children: <Widget>[
                InputVeryfy(),
                SendPhoneNum()
              ],
            ),
          ),
          
          LoginBtn()
        ],
      )
    );
  }
}

class InputPhoneNum extends StatefulWidget {
  @override
  _InputPhoneNumState createState() => _InputPhoneNumState();
}

class _InputPhoneNumState extends State<InputPhoneNum> {
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
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
                  decoration: InputDecoration.collapsed(hintText: '请输入手机号'),
                ),
              )
            
    );
  }
}



class InputVeryfy extends StatefulWidget {
  @override
  _InputVeryfyState createState() => _InputVeryfyState();
}

class _InputVeryfyState extends State<InputVeryfy> {
 final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
              alignment: Alignment.center,
              color: Colors.white,
              width: ScreenUtil().setWidth(330),
              height: ScreenUtil().setHeight(88),
              margin: EdgeInsets.only(top:ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
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
                  controller: _controller,
                  decoration: InputDecoration.collapsed(hintText: '请输入验证码'),
                ),
              )
            
            );
  }
}

class SendPhoneNum extends StatefulWidget {
  @override
  _SendPhoneNumState createState() => _SendPhoneNumState();
}

class _SendPhoneNumState extends State<SendPhoneNum> {
final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenUtil().setWidth(330),
      height: ScreenUtil().setHeight(88),
      margin: EdgeInsets.only(top:ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(30)),
      child: new MaterialButton(
        color: Color.fromRGBO(242, 242, 242, 1),
        textColor: Colors.white,
        child: new Text('发送验证码', style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1)),),
        onPressed: () {
            // ...
        },
      ),
    );
  }
}

class LoginBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return  Container(
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
                    Color.fromRGBO(230, 46, 46, 1),
                    Color.fromRGBO(180, 18, 18, 1),
                  ],
                ),
              ),
              child: new MaterialButton(
                textColor: Color.fromRGBO(255, 255, 255, 1),
                child: new Text('登录', style: TextStyle(
                  fontSize: ScreenUtil().setSp(34),
                  fontWeight: FontWeight.bold
                ),),
                onPressed: () {
                    Navigator.of(context).pushNamed("/home");
                },
              ),
            );
  }
}


