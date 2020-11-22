import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_frontend/constant/str_constant.dart';

class SharedPreferencesUtils {
  static String token = "";

  static Future getToken() async {
    if (token == null || token.isEmpty) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      token = sharedPreferences.getString(StrConstant.TOKEN) ?? null;
    }
    return token;
  }

  static Future getImageHead() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(StrConstant.HEAD_URL);
  }

  static Future getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(StrConstant.NICK_NAME);
  }
}
//增删改查 增：
//SharedPreferences prefs = await SharedPreferences.getInstance();
//prefs.setString(key, value)
//prefs.setBool(key, value)
//prefs.setDouble(key, value)
//prefs.setInt(key, value)
//prefs.setStringList(key, value)
//
//其中key就是你存贮的名称，value就是你存储的值 删：
//SharedPreferences prefs = await SharedPreferences.getInstance();
//prefs.remove(key); //删除指定键
//prefs.clear();//清空键值对