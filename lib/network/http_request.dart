import 'package:dio/dio.dart';
import 'http_config.dart';
import 'dart:convert';

class HttpRequest{
  // 1.创建DIO实例
  static BaseOptions baseOptions = BaseOptions(
      // baseUrl: BASE_URL,
      // connectTimeout: TIMOUT
  );

  static final dio = Dio(baseOptions);

  static Future request(String url, {String method = "get", Map<String, dynamic> params}) async{

    //2.发送网络请求
    Options options = Options(method: method);
    var responseStr  = await dio.request(url,queryParameters: params, options: options);
    var responseJson = json.decode(responseStr.toString());
    return responseJson;
  }
}

