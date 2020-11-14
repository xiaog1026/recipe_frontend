import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recipe_frontend/models/more_dish_model.dart';
import 'package:recipe_frontend/widgets/item_title.dart';
import 'package:recipe_frontend/widgets/top_item_widget.dart';
import 'package:recipe_frontend/network/http_request.dart';
import 'package:recipe_frontend/network/mock_request.dart';
import 'package:recipe_frontend/router.dart' as r;
import 'dart:convert';

class MoreDishListPage extends StatelessWidget {
  BuildContext context;
  final Data data;
  MoreDishListPage(this.data);

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 每日菜单标题显示
            getItemCountTitleWidget(this.data.dishTypeName,"aa"),
            // 横向滚动组件
            getSubScrollImage(data),
            SizedBox(height: 5),
          ],
        ),
    );
  }
  // 标题组件
  Widget getItemCountTitleWidget(var title, var url) {
    if (title == null){
      return Container();
    }
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: ItemTitle(
          title,
          url: null,
        ),
      ),
    );
  }
  // 横向滚动图片组件(小图)
  Widget getSubScrollImage(Data data) {
    String dish_type = "smallImage";
    if (data.dishTypeName == null){
      return Container();
    }
    double _height = 120.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: _height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var d in data.dish)
            getImageByType(dish_type,d),
        ],
      ),
    );
  }

  // 显示的图片组件
  Widget getImageByType(String dishType,Dish dish) {
    return GestureDetector(
      child: TopItemWidget(
          title: dish.dishName,
          url: dish.dishImageLink,
          type: dishType
      ),
      onTap: () {
        r.Router.push(context, r.Router.detailItemPage, dish.dishId);
      },
    );
  }

}

