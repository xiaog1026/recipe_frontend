import 'package:flutter/material.dart';
import 'package:recipe_frontend/constant/str_constant.dart';
import 'package:recipe_frontend/constant/color_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_frontend/widgets/mall_icon.dart';
import 'package:recipe_frontend/service/user_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_frontend/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe_frontend/utils/navigator_util.dart';
import 'package:recipe_frontend/event/login_event.dart';
import 'package:recipe_frontend/utils/shared_preferences_util.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _accountTextControl = TextEditingController();
  TextEditingController _passwordTextControl = TextEditingController();
  UserService userService = UserService();
  UserEntity userEntity;
  bool _autovalidator = false;
  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: true);
    return Scaffold(
      backgroundColor: ColorConstant.colorPrimary,
      body: SafeArea(
        child: Container(
            alignment: Alignment.centerLeft,
            child: Center(
                child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30.0), 0,
                    ScreenUtil().setWidth(30.0), 0),
                height: ScreenUtil().setHeight(900.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Form(
                  key: registerFormKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(60.0))),
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil().setWidth(30.0)),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 11,
                          autovalidate: _autovalidator,
                          keyboardType: TextInputType.phone,
                          validator: _validatorAccount,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.account_circle,
                              color: ColorConstant.colorPrimary,
                              size: ScreenUtil().setWidth(60.0),
                            ),
                            hintText: StrConstant.ACCOUNT_HINT,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(28.0)),
                            labelStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil().setSp(28.0)),
                            labelText: StrConstant.ACCOUNT,
                          ),
                          controller: _accountTextControl,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil().setWidth(30.0)),
                        child: TextFormField(
                          maxLines: 1,
                          maxLength: 12,
                          obscureText: true,
                          autovalidate: _autovalidator,
                          validator: __validatorPassWord,
                          decoration: InputDecoration(
                            icon: Icon(
                              MallIcon.PASS_WORD,
                              color: ColorConstant.colorPrimary,
                              size: ScreenUtil().setWidth(60.0),
                            ),
                            hintText: StrConstant.PASSWORD_HINT,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(28.0)),
                            labelStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil().setSp(28.0)),
                            labelText: StrConstant.PASSWORD,
                          ),
                          controller: _passwordTextControl,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(
                              ScreenUtil().setWidth(30.0)),
                          child: SizedBox(
                            height: ScreenUtil().setHeight(80.0),
                            width: ScreenUtil().setWidth(600.0),
                            child: RaisedButton(
                              onPressed: _login,
                              color: ColorConstant.colorPrimary,
                              child: Text(
                                StrConstant.LOGIN,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(28.0)),
                              ),
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(45.0)),
                            ),
                          )),
                        Container(
                            margin: EdgeInsets.all(
                            ScreenUtil().setWidth(30.0)),
                            child: SizedBox(
                              height: ScreenUtil().setHeight(80.0),
                              width: ScreenUtil().setWidth(600.0),
                              child: RaisedButton(
                                onPressed: _vistorLogin,
                                color: ColorConstant.colorPrimary,
                                child: Text(
                                  StrConstant.VISITOR_LOGIN,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(28.0)),
                                ),
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(45.0)),
                              ),
                            )),
                      Container(
                        margin:
                            EdgeInsets.all(ScreenUtil().setWidth(20.0)),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => _register(),
                          child: Text(
                            StrConstant.NOW_REGISTER,
                            style: TextStyle(
                                color: ColorConstant.colorPrimary,
                                fontSize: ScreenUtil().setSp(24.0)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ))),
      ),
    );
  }

  _register() {
    NavigatorUtils.goRegister(context);
  }

  String _validatorAccount(String value) {
    if (value == null || value.length < 11) {
      return StrConstant.ACCOUNT_RULE;
    }
    return null;
  }

  String __validatorPassWord(String value) {
    if (value == null || value.length < 6) {
      return StrConstant.PASSWORD_HINT;
    }
    return null;
  }

  _login() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      Map<String, dynamic> map = Map();
      map.putIfAbsent("username", () => _accountTextControl.text.toString());
      map.putIfAbsent("password", () => _passwordTextControl.text.toString());
      userService.login(map, (success) {
        print(success);
        userEntity = success;
        _saveUserInfo();
        _showToast(StrConstant.LOGIN_SUCESS);
//        Provider.of<UserInfoModel>(context, listen: true)
//            .updateInfo(userEntity);
        loginEventBus.fire(LoginEvent(true,url: userEntity.userInfo.avatarUrl,id: userEntity.userInfo.id));
        Navigator.pop(context);
      }, (onFail) {
        print(onFail);
        _showToast(onFail);
      });
    } else {
      setState(() {
        _autovalidator = true;
      });
    }
  }

  _vistorLogin() {
      registerFormKey.currentState.save();
      Map<String, dynamic> map = Map();
      map.putIfAbsent("username", () => _accountTextControl.text.toString());
      map.putIfAbsent("password", () => _passwordTextControl.text.toString());
      userService.vistorLogin(map, (success) {
        print(success);
        userEntity = success;
        _saveUserInfo();
        _showToast(StrConstant.LOGIN_SUCESS);
//        Provider.of<UserInfoModel>(context, listen: true)
//            .updateInfo(userEntity);
        loginEventBus.fire(LoginEvent(true,url: userEntity.userInfo.avatarUrl,id: userEntity.userInfo.id));
        Navigator.pop(context);
      }, (onFail) {
        print(onFail);
        _showToast(onFail);
      });

  }

  _showToast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorConstant.colorPrimary,
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(28.0));
  }

  _saveUserInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferencesUtils.token = userEntity.token;
    await sharedPreferences.setString(StrConstant.TOKEN, userEntity.token);
    await sharedPreferences.setString(
        StrConstant.HEAD_URL, userEntity.userInfo.avatarUrl);
    await sharedPreferences.setString(
        StrConstant.NICK_NAME, userEntity.userInfo.id);
  }
}
