import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分类"),
      ),
      body: Center(
        child: Text("分类",style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
