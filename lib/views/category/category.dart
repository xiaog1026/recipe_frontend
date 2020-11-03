import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的餐桌"),
      ),
      body: Center(
        child: Text("餐桌",style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
