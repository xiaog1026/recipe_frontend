import 'http_config.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

///模拟数据
class MockRequest {

  Future<dynamic> get(String action, {Map params}) async {
    return MockRequest.mock(action: getJsonName(action), params: params);
  }

  static Future<dynamic> post({String action, Map params}) async {
    return MockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  static Future<dynamic> mockTop250() async {
    var responseStr = await rootBundle.loadString('mock/home.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  Map<String, String> map = {
    IN_THEATERS: 'in_theaters',
    COMING_SOON: 'coming_soon',
    TOP_250: 'top250',
    WEEKLY: 'weekly',
    REIVIEWS: 'reviews',
  };

  getJsonName(String action) {
    return map[action];
  }
}
