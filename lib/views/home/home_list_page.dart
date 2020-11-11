import 'package:flutter/material.dart';
import 'package:recipe_frontend/models/home_list_model.dart';
import 'package:recipe_frontend/components/dashed_line.dart';
import 'package:recipe_frontend/components/star_rating.dart';
import 'package:recipe_frontend/widgets/item_count_title.dart';
import 'package:recipe_frontend/widgets/top_item_widget.dart';
import 'package:recipe_frontend/router.dart' as r;

import 'package:cached_network_image/cached_network_image.dart';

/// 首页菜谱一栏
class HomeListPage extends StatelessWidget {
  // 首页组件变量
  final Cards dishs;
  // 首页组件构造函数
  HomeListPage(this.dishs);
  // 横向滚动图片大小
  var scrollimgSize;
  //
  BuildContext context;

  @override
  Widget build(BuildContext lcontext) {
    context = lcontext;
    // 横向滚动图片大小
    scrollimgSize = MediaQuery.of(context).size.width / 5 * 3;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题显示
          getItemCountTitleWidget(this.dishs.dishTypeName,this.dishs.dishCount),
          // 横向滚动组件
          getScrollImage(),

        ],
      ),
    );
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

  // 横向滚动图片组件
  Widget getScrollImage() {
    if("nestedImage" == this.dishs.dishType){
      return getScrollNestedImage();
    }else{
      return getSubScrollImage();
    }
  }
  // 横向滚动图片组件(小图和大图)
  Widget getSubScrollImage() {
    double _height = 250.0;
    if("smallImage" == this.dishs.dishType){
      _height = 130.0;
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: _height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var d in this.dishs.dish)
            getImageByType(d),
        ],
      ),
    );
  }

  //横向滚动嵌套图片组件
  Widget getScrollNestedImage() {
    int _index = 1;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 210.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // 一列三行组件
          for (var i = 1; i < this.dishs.dish.length + 1; i = i + 3)
            getColumnWidgetByNestedImage(i),
          //getContentWidget()
        ],
      ),
    );
  }

  //一列三行组件 模块3组件
  Widget getColumnWidgetByNestedImage(int index ) {
    return Container(
      height: 150,
      width: 300,
      child: Column(
        children: <Widget>[
          get3RowWidget(index - 1),
          get3RowWidget(index),
          get3RowWidget(index + 1)
        ],
      ),
    );
  }

  //行组件 模块3组件
  Widget get3RowWidget(int index) {
    return GestureDetector(
      child: Container(
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getImageByNestedImage(index),
            getContentByNestedImage(index)
          ],
        ),
      ),
      onTap: () {
        r.Router.push(context, r.Router.detailItemPage, this.dishs.dish[index].dishId);
      },
    );

    return Container(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getImageByNestedImage(index),
          getContentByNestedImage(index)
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
          type: this.dishs.dishType
      ),
      onTap: () {
        r.Router.push(context, r.Router.detailItemPage, dish.dishId);
      },
    );
  }
  // 获取显示的图片嵌套组件
  Widget getImageByNestedImage(int index) {
    return TopItemWidget(
        title: this.dishs.dish[index].dishName,
        url: this.dishs.dish[index].dishImageLink,
        type: "nestedImage"
    );
  }
  // 获取显示内容嵌套组件
  Widget getContentByNestedImage(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getRankWidgetByNestedImage(index),
          SizedBox(height: 3,),
          getTitleWidget(this.dishs.dish[index].dishName),
        ],
      ),
    );
  }

  // 排名嵌套组件
  Widget getRankWidgetByNestedImage(index) {
    index++;
    return Container(
        padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Color.fromARGB(255, 238, 205, 144)
        ),
        child: Text(
          "No."+index.toString(),
          style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 131, 95, 36)),
        )
    );
  }

  // 获取名称信息等嵌套组件
  Widget getTitleWidget(String foodName) {
    return Stack(
      children: <Widget>[
        //Icon(Icons.play_circle_outline, color: Colors.redAccent,),
        Text.rich(
          TextSpan(
              children: [
                TextSpan(
                    text: foodName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    )
                ),
                // TextSpan(
                //   text: "(${item.playDate})",
                //   style: TextStyle(
                //       fontSize: 18,
                //       color: Colors.black54
                //   ),
                // )
              ]
          ),
          maxLines: 2,
        ),
      ],
    );
  }
}