import 'package:flutter/material.dart';
import 'package:recipe_frontend/constant/str_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_frontend/widgets/mall_icon.dart';
import 'package:recipe_frontend/service/user_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_frontend/utils/navigator_util.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _accountTextControl = TextEditingController();
  TextEditingController _passwordTextControl = TextEditingController();
  UserService userService = UserService();
  bool _autovalidator = false;
  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: SafeArea(
          child: Container(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(
                ScreenUtil().setWidth(30.0), 0, ScreenUtil().setWidth(30.0), 0),
            height: ScreenUtil().setHeight(700.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Form(
              key: registerFormKey,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(60.0))),
                  Container(
                    margin: EdgeInsets.all(ScreenUtil().setWidth(30.0)),
                    child: TextFormField(
                      maxLines: 1,
                      maxLength: 11,
                      autovalidate: _autovalidator,
                      keyboardType: TextInputType.phone,
                      validator: _validatorAccount,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.deepOrangeAccent,
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
                    margin: EdgeInsets.all(ScreenUtil().setWidth(30.0)),
                    child: TextFormField(
                      maxLines: 1,
                      maxLength: 12,
                      autovalidate: _autovalidator,
                      validator: __validatorPassWord,
                      decoration: InputDecoration(
                        icon: Icon(
                          MallIcon.PASS_WORD,
                          color: Colors.deepOrangeAccent,
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
                      margin:
                          EdgeInsets.all(ScreenUtil().setWidth(30.0)),
                      child: SizedBox(
                        height: ScreenUtil().setHeight(80.0),
                        width: ScreenUtil().setWidth(600.0),
                        child: RaisedButton(
                          onPressed: _register,
                          color: Colors.deepOrangeAccent,
                          child: Text(
                            StrConstant.REGISTER,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(28.0)),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
//
        ),
      )),
    );
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

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(28.0));
  }

  _register() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      Map<String, dynamic> map = Map();
      map.putIfAbsent("username", () => _accountTextControl.text.toString());
      map.putIfAbsent("password", () => _passwordTextControl.text.toString());
      map.putIfAbsent("mobile", () => _accountTextControl.text.toString());
      map.putIfAbsent("code", () => "8888"); //测试验证码写死8888
      userService.register(map, (success) {
        print(success);
        _showToast(StrConstant.REGISTER_SUCCESS);
        NavigatorUtils.popRegister(context);
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
}
