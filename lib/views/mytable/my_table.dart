import 'package:flutter/material.dart';
import 'package:lovekitchen/widgets/item_count_title.dart';
import 'package:lovekitchen/widgets/top_item_widget.dart';
import 'package:lovekitchen/network/http_request.dart';
import 'package:lovekitchen/network/mock_request.dart';
import 'package:lovekitchen/models/my_table_model.dart';

class MyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的餐桌"),
      ),
      body: MyTableBody(),
    );
  }
}
class MyTableBody extends StatefulWidget {
  @override
  _MyTableBodyState createState() => _MyTableBodyState();
}

class _MyTableBodyState extends State<MyTableBody> {
  // 我的餐桌变量
  MyTableItem myTableItem;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    dataByMock();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border:
            Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 标题显示
            getItemCountTitleWidget(this.myTableItem.dishTypeName,this.myTableItem.dishCount),
            // 横向滚动组件
            getSubScrollImage(),
            SizedBox(height: 5),
          ],
        ),
      )
      // Scaffold(
      //   appBar: AppBar(title: Text("侧边栏菜单")),
      //   drawer: Drawer(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Row(
      //           children: <Widget>[
      //             Icon(Icons.add),
      //             Text("菜单一"),
      //           ],
      //         ),
      //         Row(
      //           children: <Widget>[
      //             Icon(Icons.edit),
      //             Text("菜单二"),
      //           ],
      //         ),
      //         Row(
      //           children: <Widget>[
      //             Icon(Icons.ac_unit),
      //             Text("菜单三"),
      //           ],
      //         ),
      //         Row(
      //           children: <Widget>[
      //             Icon(Icons.access_alarm),
      //             Text("菜单四"),
      //           ],
      //         ),
      //         Row(
      //           children: <Widget>[
      //             Icon(Icons.add_call),
      //             Text("菜单五"),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void dataByMock(){
    MockRequest.mockMyTable().then((res){
        setState(() {
          this.myTableItem = MyTableItem.fromJson(res);
        });
    });
  }

  // 标题组件
  Widget getItemCountTitleWidget(var title, int count) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: ItemCountTitle(
          title,
          count: count,
        ),
      ),
    );
  }
  // 横向滚动图片组件(小图)
  Widget getSubScrollImage() {
    double _height = 150.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: _height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var d in this.myTableItem.dish)
               getImageByType(d),

        ],
      ),
    );
  }

  // 显示的图片组件
  Widget getImageByType(Dish dish) {
    return GestureDetector(
      child: TopItemWidget(
          title: dish.dishName,
          url: dish.dishImageLink,
          type: this.myTableItem.dishType
      ),
      onTap: () {
        //Router.push(context, Router.detailItemPage, dish.dishId);
      },
    );
  }

}
