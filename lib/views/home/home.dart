import 'package:flutter/material.dart';
import 'package:lovekitchen/models/home_model.dart';
import 'package:lovekitchen/network/http_request.dart';
import 'package:lovekitchen/network/mock_request.dart';
import 'package:lovekitchen/views/home/childCpns/list_item.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Item> items = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    // HttpRequest.request("https://flutter.cn/docs/development/ui/layout#1-select-a-layout-widget").then((res){
    //   print(res);
    // });
    MockRequest.mockTop250().then((res){
      final subjects = res["subjects"];
      List<Item> subItems = [];
      for(var sub in subjects){
        subItems.add(Item.fromMap(sub));
      }
      // 状态改变
      setState(() {
        this.items = subItems;
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index){
          return ListItem(items[index]);
        },
      ),
    );
  }
}
