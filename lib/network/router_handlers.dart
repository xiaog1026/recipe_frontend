import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:recipe_frontend/views/login/register.dart';
import 'package:recipe_frontend/views/login/login.dart';

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return RegisterView();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
  return LoginView();
});
