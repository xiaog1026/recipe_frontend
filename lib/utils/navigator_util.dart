import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:recipe_frontend/network/application.dart';
import 'package:recipe_frontend/network/routers.dart';
import 'package:recipe_frontend/utils/string_util.dart';
import 'package:recipe_frontend/utils/fluro_convert_utils.dart';

class NavigatorUtils {
  static goMallMainPage(BuildContext context) {
    Application.router.navigateTo(context, Routers.home,
        transition: TransitionType.inFromRight, replace: true);
  }

  static goRegister(BuildContext context) {
    Application.router.navigateTo(context, Routers.register,
        transition: TransitionType.inFromRight);
  }

  static goLogin(BuildContext context) {
    Application.router.navigateTo(context, Routers.login,
        transition: TransitionType.inFromRight);
  }

  static popRegister(BuildContext context) {
    Application.router.pop(context);
  }

  static submitOrderSuccessPop(BuildContext context) {
    Application.router.navigateTo(context, Routers.home,
        clearStack: true, transition: TransitionType.inFromRight);
  }
}
