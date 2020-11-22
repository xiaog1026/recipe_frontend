import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:recipe_frontend/network/router_handlers.dart';

class Routers {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";
  static String register = "/register";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      print("handler not find");
    });
    router.define(login, handler: loginHandler);
    router.define(register, handler: registerHandler);
  }
}
