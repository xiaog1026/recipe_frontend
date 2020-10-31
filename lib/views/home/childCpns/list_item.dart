import 'package:flutter/material.dart';
import 'package:lovekitchen/models/home_model.dart';
import 'package:lovekitchen/components/dashed_line.dart';
import 'package:lovekitchen/components/star_rating.dart';
import 'package:lovekitchen/widgets/item_count_title.dart';
import 'package:lovekitchen/widgets/top_item_widget.dart';
import 'package:lovekitchen/router.dart';

import 'package:cached_network_image/cached_network_image.dart';

/// 首页菜谱一栏
class ListItem extends StatelessWidget {
  // 首页组件变量
  final Item item;
  // 首页组件构造函数
  ListItem(this.item);
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
          // 标题显示 首页模块1
          getItemCountTitleWidget('今日特辑', 5),
          // 横向滚动大图组件(首页模块1，今日特辑 )
          getScrollBigImage(),
          SizedBox(height: 5),
          // 标题显示 首页模块2
          getItemCountTitleWidget('新品推荐', 5),
          // 横向滚动小图组件(首页模块2，新品推荐 )
          getScrollSmallImage(),
          SizedBox(height: 5),
          // 标题显示 首页模块3
          getItemCountTitleWidget('我们都在看', 9),
          getScrollNestedImage(),
          SizedBox(height: 5),
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

  // 横向滚动大图 模块1组件
  Widget getScrollBigImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 250.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          getImageByType1(0),
          getImageByType1(1),
          getImageByType1(2),
          getImageByType1(3),
          getImageByType1(4)
        ],
      ),
    );
  }

  // 横向滚动小图组件
  Widget getScrollSmallImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          getImageByType2(0),
          getImageByType2(1),
          getImageByType2(2),
          getImageByType2(3),
          getImageByType2(4)
        ],
      ),
    );
  }

  // 横向滚动嵌套图片组件 模块3组件
  Widget getScrollNestedImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 210.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // 一列三行组件
          getColumnWidgetByType3(1),
          getColumnWidgetByType3(4),
          getColumnWidgetByType3(7)
          //getContentWidget()
        ],
      ),
    );
  }

  // 一列三行组件 模块3组件
  Widget getColumnWidgetByType3(int index ) {
    return Container(
      height: 150,
      child: Column(
        children: <Widget>[
          getRowWidgetByType3(index - 1),
          getRowWidgetByType3(index),
          getRowWidgetByType3(index + 1)
        ],
      ),
    );
  }

  // 行组件 模块3组件
  Widget getRowWidgetByType3(int index) {
    return Container(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getImageByType3(index),
          getContentByType3(index)
        ],
      ),
    );
  }

  // 模块1获取显示的图片组件
  Widget getImageByType1(int index) {
    return GestureDetector(
        child: TopItemWidget(
            title: item.scrollName[index],
            url: item.scrollImageURL[index],
            type: "type1"
        ),
      onTap: () {
        Router.push(context, Router.detailItemPage, "1");
      },
        );
  }
  // 模块2获取显示的图片组件
  Widget getImageByType2(int index) {
    return TopItemWidget(
        title: item.scrollName[index],
        url: item.scrollImageURL[index],
        type: "type2"
    );
  }
  // 模块3获取显示的图片组件
  Widget getImageByType3(int index) {
    return TopItemWidget(
        title: item.foodNameType3[index],
        url: item.foodImagesType3[index],
        type: "type3"
    );
  }
  // 模块3获取显示内容组件
  Widget getContentByType3(int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getRankWidgetByType3(index),
          SizedBox(height: 3,),
          getTitleWidget(item.foodNameType3[index]),
        ],
      ),
    );
  }

  // 模块3排名组件
  Widget getRankWidgetByType3(index) {
    index++;
    return Container(
        padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Color.fromARGB(255, 238, 205, 144)
        ),
        child: Text(
          "No."+index.toString(),
          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36)),
        )
    );
  }

  // 模块3获取名称信息等组件
  Widget getTitleWidget(String foodName) {
    return Stack(
      children: <Widget>[
        Icon(Icons.play_circle_outline, color: Colors.redAccent,),
        Text.rich(
          TextSpan(
              children: [
                TextSpan(
                    text: "     " + foodName,
                    style: TextStyle(
                        fontSize: 18,
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