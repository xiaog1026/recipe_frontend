import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
///模拟数据
class MockRequest {

  static Future<dynamic> post({String action, Map params}) async {
    return MockRequest.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  static Future<dynamic> mockHome() async {
    //var responseStr = await rootBundle.loadString('mock/home.json');
    var responseStr = await rootBundle.loadString('mock/home_list1.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  static Future<dynamic> mockHomeDetailItem() async {
    var responseStr = await rootBundle.loadString('mock/home_detail_item1.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  static Future<dynamic> mockMyTable() async {
    var responseStr = await rootBundle.loadString('mock/my_table.json');
    var responseJson = json.decode(responseStr);
    return responseJson;
  }

  static Future<dynamic> mockIngredent() async {
    var responseStr = await rootBundle.loadString('mock/ingredent_navi.json');
    // responseJson = json.decode(responseStr);
    return responseStr;
  }
  static Future<dynamic> mockSideDish() async {
    var responseStr = await rootBundle.loadString('mock/side_dish_navi.json');
    // responseJson = json.decode(responseStr);
    return responseStr;
  }

  static Future<dynamic> mockMoreDish() async {
    var responseStr = await rootBundle.loadString('mock/more_dish.json');
    //var responseJson = json.decode(responseStr);
    return responseStr;
  }


}
