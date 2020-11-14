import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recipe_frontend/widgets/item_title.dart';
import 'package:recipe_frontend/widgets/top_item_widget.dart';
import 'package:recipe_frontend/network/http_request.dart';
import 'package:recipe_frontend/network/mock_request.dart';
import 'package:recipe_frontend/models/my_table_model.dart';
import 'package:recipe_frontend/router.dart' as r;

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
  MyTableItem myTableItem = new MyTableItem();

  @override
  void initState() {
    super.initState();
    MockRequest.mockMyTable().then((res){
      setState(() {
        this.myTableItem = MyTableItem.fromJson(res);
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    if(this.myTableItem.dishTypeName == null){
      return Scaffold();
    }
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 每日菜单标题显示
                getItemCountTitleWidget(this.myTableItem.dishTypeName,r.Router.moreDishPage),
                // 横向滚动组件
                getSubScrollImage(),
                SizedBox(height: 5),
                // 我的可用食材标题显示
                getItemCountTitleWidget(this.myTableItem.ingredentTypeName,r.Router.ingredentNaviPage),
                getIngredents(),
                SizedBox(height: 5),
                // 基础配菜条件标题显示
                getItemCountTitleWidget(this.myTableItem.sideDishBaseTypeName,r.Router.sideDishNaviPage),
                getSideDishBases(),
                SizedBox(height: 5),
                // 选项喜欢吃配菜条件标题显示
                getItemCountTitleWidget(this.myTableItem.sideDishOptionLikeTypeName,r.Router.sideDishNaviPage),
                getSideDishOptionLikes(),
                SizedBox(height: 5),
                // 选项不喜欢吃配菜条件标题显示
                getItemCountTitleWidget(this.myTableItem.sideDishOptionHateTypeName,r.Router.sideDishNaviPage),
                getSideDishOptionHates(),
                SizedBox(height: 5),
                // 选项口味配菜条件标题显示
                getItemCountTitleWidget(this.myTableItem.sideDishOptionTasteTypeName,r.Router.sideDishNaviPage),
                getSideDishOptionTastes(),
                SizedBox(height: 5),
              ],
            ),
          )
          ,
    );
  }
  // 标题组件
  Widget getItemCountTitleWidget(var title, var url) {
    print(url);
    if (title == null){
      return Container();
    }
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: ItemTitle(
          title,
          url: url,
        ),
      ),
    );
  }
  // 横向滚动图片组件(小图)
  Widget getSubScrollImage() {
    if (this.myTableItem.dishTypeName == null){
      return Container();
    }
    double _height = 120.0;
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
        r.Router.push(context, r.Router.detailItemPage, dish.dishId);
      },
    );
  }
  //食材列表
  Widget getIngredents() {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 3),
          Wrap(
            spacing: 5.0, //两个widget之间横向的间隔
            direction: Axis.horizontal, //方向
            alignment: WrapAlignment.start, //内容排序方式
            children: List<Widget>.generate(
              this.myTableItem.ingredents.length,
                  (int index) {
                return ActionChip(
                  //标签文字
                  label: Text(
                    this.myTableItem.ingredents[index].ingredentName + "  " + (this.myTableItem.ingredents[index].ingredentWeight).toString() + this.myTableItem.ingredents[index].ingredentUnit,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  //点击事件
                  onPressed: () async {

                  },
                  elevation: 3,
                  backgroundColor: Color.fromARGB(
                    180,
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
    // return Column(
    //   children: <Widget>[
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         SizedBox(width: 5),
    //       ],
    //     ),
    //     SizedBox(width: 5),
    //     //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
    //     for (var item in this.myTableItem.ingredents)
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           SizedBox(width: 5),
    //           //Text(item.ingredentName + "  " + (item.ingredentWeight).toString() + item.ingredentUnit)
    //           buildSuggestions(item.ingredentName + "  " + (item.ingredentWeight).toString() + item.ingredentUnit)
    //         ],
    //       )
    //   ],
    // );
  }

  //基础配菜列表
  Widget getSideDishBases() {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 3),
          Wrap(
            spacing: 5.0, //两个widget之间横向的间隔
            direction: Axis.horizontal, //方向
            alignment: WrapAlignment.start, //内容排序方式
            children: List<Widget>.generate(
              this.myTableItem.sideDishBases.length,
                  (int index) {
                return ActionChip(
                  //标签文字
                  label: Text(
                    this.myTableItem.sideDishBases[index].sideDishBaseName + "  " + ( this.myTableItem.sideDishBases[index].sideDishBaseNum).toString() +  this.myTableItem.sideDishBases[index].sideDishBaseUnit,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  //点击事件
                  onPressed: () async {

                  },
                  elevation: 3,
                  backgroundColor: Color.fromARGB(
                    180,
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
    // return Column(
    //   children: <Widget>[
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: <Widget>[
    //         SizedBox(width: 5),
    //         // OutlineButton.icon(
    //         //   icon: Icon(Icons.edit_location_outlined),
    //         //   label: Text("编辑标准配菜条件"),
    //         //   onPressed: () {
    //         //     setState(() {
    //         //       //_counter++;
    //         //     });
    //         //   },
    //         // )
    //       ],
    //     ),
    //     SizedBox(width: 5),
    //     //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
    //     for (var item in this.myTableItem.sideDishBases)
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           SizedBox(width: 5),
    //           //Text(item.sideDishBaseName + "  " + (item.sideDishBaseNum).toString() + item.sideDishBaseUnit)
    //           buildSuggestions(item.sideDishBaseName + "  " + (item.sideDishBaseNum).toString() + item.sideDishBaseUnit)
    //         ],
    //       )
    //   ],
    // );
  }
  //选项喜欢吃配菜列表
  Widget getSideDishOptionLikes() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 5),
            // OutlineButton.icon(
            //   icon: Icon(Icons.edit_location_outlined),
            //   label: Text("编辑喜欢吃选项配菜条件"),
            //   onPressed: () {
            //     setState(() {
            //       //_counter++;
            //     });
            //   },
            // )
          ],
        ),
        SizedBox(width: 5),
        //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
        for (var item in this.myTableItem.sideDishOptionLikes)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 5),
              if(item.sideDishOptionLikeStatus == 1 )
              //Text(item.sideDishOptionLikeName)
                buildSuggestions(item.sideDishOptionLikeName)
            ],
          )
      ],
    );
  }
  //选项不喜欢吃配菜列表
  Widget getSideDishOptionHates() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 5),
            // OutlineButton.icon(
            //   icon: Icon(Icons.edit_location_outlined),
            //   label: Text("编辑不喜欢吃选项配菜条件"),
            //   onPressed: () {
            //     setState(() {
            //       //_counter++;
            //     });
            //   },
            // )
          ],
        ),
        SizedBox(width: 5),
        //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
        for (var item in this.myTableItem.sideDishOptionHates)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 5),
              if(item.sideDishOptionHateStatus == 1 )
                //Text(item.sideDishOptionHateName)
                buildSuggestions(item.sideDishOptionHateName)
            ],
          )
      ],
    );
  }

  //选项口味吃配菜列表
  Widget getSideDishOptionTastes() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 5),
            // OutlineButton.icon(
            //   icon: Icon(Icons.edit_location_outlined),
            //   label: Text("编辑口味选项配菜条件"),
            //   onPressed: () {
            //     setState(() {
            //       //_counter++;
            //     });
            //   },
            // )
          ],
        ),
        SizedBox(width: 5),
        //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
        for (var item in this.myTableItem.sideDishOptionTastes)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 5),
              if(item.sideDishOptionTasteStatus == 1 )
                //Text(item.sideDishOptionTasteName)
                buildSuggestions(item.sideDishOptionTasteName)
            ],
          )
      ],
    );
  }

  /// 搜索建议 调用的话就不能返回null
  @override
  Widget buildSuggestions(String name) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 3),
          Wrap(
            spacing: 5.0, //两个widget之间横向的间隔
            direction: Axis.horizontal, //方向
            alignment: WrapAlignment.start, //内容排序方式
            children: List<Widget>.generate(
             1,
                  (int index) {
                return ActionChip(
                  //标签文字
                  label: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  //点击事件
                  onPressed: () async {

                  },
                  elevation: 3,
                  backgroundColor: Color.fromARGB(
                    180,
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

}
