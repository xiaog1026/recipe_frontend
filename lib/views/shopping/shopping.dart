import 'package:flutter/material.dart';

class Shopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物"),
      ),
      body: Center(
        child: Text("购物",style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
