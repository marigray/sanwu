import 'package:dio/dio.dart';
import 'dart:io';
import 'package:sanwu/config/config.dart';//用于配置公用常量

class HttpUtil{
  static HttpUtil instance;
  static String token;
  static Config _config = new Config();
  static Dio _dio;
  Options _options;

  static HttpUtil getInstance(){
    print("getInstance");
    if(instance == null){
      instance  = new HttpUtil();
    }
  }

  HttpUtil(){
  		// 初始化 Options
    BaseOptions _options = new BaseOptions(
      baseUrl: _config.base_url,
      connectTimeout: _config.connectTimeout,
      receiveTimeout: _config.receiveTimeout,
      headers: {},
    );

    _dio = new Dio(_options);

  }



   // get 请求封装
  get(url,{ cancelToken, data=null}) async {
    Response response;
    try{
      response = await _dio.get(
        url,
        queryParameters:data,
        cancelToken:cancelToken
      );
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('get请求取消! ' + e.message);
      }else{
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }
	
	// post请求封装
  post(url,{ cancelToken, data=null}) async {
    print('post请求::: url：$url ,body: $data');
    Response response;

    try{
      response = await _dio.post(
          url,
          data:data !=null ? data : {},
          cancelToken:cancelToken
      );
      print(response);
    }on DioError catch(e){
      if(CancelToken.isCancel(e)){
        print('get请求取消! ' + e.message);
      }else{
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }
}