import 'package:recipe_frontend/network/http_util.dart';
import 'package:recipe_frontend/constant/str_constant.dart';
import 'package:recipe_frontend/models/user_model.dart';
import 'package:recipe_frontend/network/http_config.dart';

typedef OnSuccess<T>(T data);

typedef OnFail(String message);

class UserService {
  Future register(Map<String, dynamic> parameters, OnSuccess onSuccess,
      OnFail onFail) async {
    // try {
    //   var response =
    //       await HttpUtil.instance.post(ApiConstant.REGISTER, parameters: parameters);
    //   if (response['errno'] == 0) {
    //     onSuccess("");
    //   } else {
    //     onFail(response['errmsg']);
    //   }
    // } catch (e) {
    //   print(e);
    //   onFail(StrConstant.SERVER_EXCEPTION);
    // }
  }

  Future login(Map<String, dynamic> parameters, OnSuccess onSuccess,
      OnFail onFail) async {
    try {
      var response =
          await HttpUtil.instance.post(ApiConstant.LOGIN, parameters: parameters);
      if (response['errno'] == 0) {
        UserEntity userEntity = UserEntity.fromJson(response['data']);
        onSuccess(userEntity);
      } else {
        onFail(response['errmsg']);
      }
    } catch (e) {
      print(e);
      onFail(StrConstant.SERVER_EXCEPTION);
    }
  }

  Future vistorLogin(Map<String, dynamic> parameters, OnSuccess onSuccess,
      OnFail onFail) async {
    try {
      var response =
      await HttpUtil.instance.get(ApiConstant.VISITOR_LOGIN, parameters: parameters);
      // if (response['errno'] == 0) {
        UserEntity userEntity = UserEntity.fromJson(response);
        onSuccess(userEntity);
      // } else {
      //   onFail(response['errmsg']);
      // }
    } catch (e) {
      print(e);
      onFail(StrConstant.SERVER_EXCEPTION);
    }
  }

  Future loginOut(OnSuccess onSuccess, OnFail onFail) async {
    // try {
    //   var response = await HttpUtil.instance.post(ApiConstant.LOGIN_OUT);
    //   if (response['errno'] == 0) {
    //     onSuccess(StrConstant.SUCCESS);
    //   } else {
    //     onFail(response['errmsg']);
    //   }
    // } catch (e) {
    //   print(e);
    //   onFail(StrConstant.SERVER_EXCEPTION);
    // }
  }
}
