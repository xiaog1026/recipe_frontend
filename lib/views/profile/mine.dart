import 'package:flutter/material.dart';
import 'package:recipe_frontend/constant/str_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:mall/utils/shared_preferences_util.dart';
import 'package:recipe_frontend/widgets/icon_text_arrow.dart';
import 'package:recipe_frontend/widgets/mall_icon.dart';
import 'package:recipe_frontend/utils/navigator_util.dart';
import 'package:recipe_frontend/event/login_event.dart';
import 'package:recipe_frontend/service/user_service.dart';
import 'package:recipe_frontend/utils/toast_util.dart';

class MineView extends StatefulWidget {
  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  bool isLogin = false;
  var imageHeadUrl;
  var id;
  UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _refreshEvent() {
    loginEventBus.on<LoginEvent>().listen((LoginEvent loginEvent) {
      if (loginEvent.isLogin) {
        setState(() {
          isLogin = true;
          imageHeadUrl = loginEvent.url;
          id = loginEvent.id;
        });
      } else {
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  _getUserInfo() {
    // SharedPreferencesUtils.getToken().then((token) {
    //   if (token != null) {
    //     setState(() {
    //       isLogin = true;
    //     });
    //     SharedPreferencesUtils.getImageHead().then((imageHeadAddress) {
    //       setState(() {
    //         imageHeadUrl = imageHeadAddress;
    //       });
    //     });
    //     SharedPreferencesUtils.getUserName().then((name) {
    //       setState(() {
    //         nickName = name;
    //       });
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: true);
    _refreshEvent();
    return Scaffold(
      appBar: AppBar(
        title: Text(StrConstant.MINE),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(160.0),
            width: double.infinity,
            color: Colors.green,
            alignment: Alignment.center,
            child: isLogin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenUtil().setWidth(100),
                        height: ScreenUtil().setHeight(100),
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(30.0)),
                        child: CircleAvatar(
                          radius: ScreenUtil().setWidth(50),
                          foregroundColor: Colors.green,
                          backgroundImage: NetworkImage(
                            imageHeadUrl,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(10.0)),
                      ),
                      Text(
                        id,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(26.0),
                            color: Colors.white),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () => _loginOutDialog(),
                            child: Offstage(
                              offstage: !isLogin,
                              child: Container(
                                padding: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  StrConstant.LOGIN_OUT,
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil().setSp(45),
                                      color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () => _toLogin(),
                    child: Text(
                      StrConstant.CLICK_LOGIN,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(50.0)),
                    ),
                  ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: ScreenUtil().setHeight(30.0)),
          ),
          IconTextArrowView(
              MallIcon.ORDER, StrConstant.ORDER, Colors.deepPurpleAccent, order),
          Divider(
            height: ScreenUtil().setHeight(1.0),
            color: Color(0xffd3d3d3),
          ),
          IconTextArrowView(
              MallIcon.COUPON, StrConstant.COUPON, Colors.green, mineCoupon),
          Divider(
            height: ScreenUtil().setHeight(1.0),
            color: Color(0xffd3d3d3),
          ),
          IconTextArrowView(
              MallIcon.COLLECTION, StrConstant.COLLECTION, Colors.red, collect),
          Divider(
            height: ScreenUtil().setHeight(1.0),
            color: Color(0xffd3d3d3),
          ),
          IconTextArrowView(
              MallIcon.ADDRESS, StrConstant.ADDRESS, Colors.amber, address),
          Divider(
            height: ScreenUtil().setHeight(1.0),
            color: Color(0xffd3d3d3),
          ),
          IconTextArrowView(
              MallIcon.FOOTPRINT, StrConstant.FOOTPRINT, Colors.pink, footprint),
          Divider(
            height: ScreenUtil().setHeight(1.0),
            color: Color(0xffd3d3d3),
          ),
          IconTextArrowView(MallIcon.FEED_BACK, StrConstant.FEED_BACK,
              Colors.blueAccent, feedbackCallback),
          Divider(
            height: ScreenUtil().setHeight(1.0),
            color: Color(0xffd3d3d3),
          ),
          IconTextArrowView(
              MallIcon.ABOUT_US, StrConstant.ABOUT_US, Colors.teal, aboutUs),
          Divider(
            height: ScreenUtil().setHeight(1.0),
            color: Color(0xffd3d3d3),
          ),
        ],
      ),
    );
  }

  _loginOutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              StrConstant.TIPS,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black54),
            ),
            content: Text(
              StrConstant.LOGIN_OUT_TIPS,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.black54),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  StrConstant.CANCEL,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              FlatButton(
                onPressed: () => _loginOut(),
                child: Text(
                  StrConstant.CONFIRM,
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              )
            ],
          );
        });
  }

  _loginOut() {
    _userService.loginOut((success) {
      loginEventBus.fire(LoginEvent(false));
    }, (error) {
      loginEventBus.fire(LoginEvent(false));
      ToastUtil.showToast(error);
    });
    Navigator.pop(context);
  }

  void feedbackCallback() {
    if (isLogin) {
      //NavigatorUtils.goFeedback(context);
    } else {
      _toLogin();
    }
  }

  void mineCoupon() {
    if (isLogin) {
      //NavigatorUtils.goCoupon(context);
    } else {
      _toLogin();
    }
  }

  void footprint() {
    if (isLogin) {
      //NavigatorUtils.goFootprint(context);
    } else {
      _toLogin();
    }
  }

  void collect() {
    if (isLogin) {
      //NavigatorUtils.goCollect(context);
    } else {
      _toLogin();
    }
  }

  void address() {
    if (isLogin) {
      //NavigatorUtils.goAddress(context);
    } else {
      _toLogin();
    }
  }

  void aboutUs() {
    if (isLogin) {
      //NavigatorUtils.goAboutUs(context);
    } else {
      _toLogin();
    }
  }

  void order() {
    if (isLogin) {
      //NavigatorUtils.goOrder(context);
    } else {
      _toLogin();
    }
  }

  _toLogin() {
    NavigatorUtils.goLogin(context);
  }
}
