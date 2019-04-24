import 'package:flutter/material.dart';
import 'page/home.dart';
import 'package:provide/provide.dart';
import './provide/count.dart';
import './provide/news.dart';
import './page/login.dart';
import './page/home.dart';
import './provide/user.dart';

void main(){
  var counter = Counter();
  var newsProvide = NewsProvide();
  var userProvide = UserProvide();

  var providers = Providers();

  //将counter对象添加进providers
  providers.provide(Provider<Counter>.value(counter));
  providers.provide(Provider<NewsProvide>.value(newsProvide));
  providers.provide(Provider<UserProvide>.value(userProvide));

  runApp(
    ProviderNode(
        child: MyApp(), 
        providers: providers
      ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '榆林智慧村务信息公开系统',
      theme: ThemeData(
        backgroundColor: Color(0xFFf7f7f7)
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder> {
          '/home': (BuildContext context) => new MyHomePage(),
          '/login' : (BuildContext context) => new LoginPage()
        },
    );
  }
}