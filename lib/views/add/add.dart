import 'package:flutter/material.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("上传"),
      ),
      body: Center(
        child: Text("上传",style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
