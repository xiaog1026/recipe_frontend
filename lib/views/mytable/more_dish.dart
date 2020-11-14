import 'dart:math';
import 'package:flutter/material.dart';
import 'package:recipe_frontend/models/more_dish_model.dart';
import 'package:recipe_frontend/widgets/item_title.dart';
import 'package:recipe_frontend/widgets/top_item_widget.dart';
import 'package:recipe_frontend/network/http_request.dart';
import 'package:recipe_frontend/network/mock_request.dart';
import 'package:recipe_frontend/router.dart' as r;
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:recipe_frontend/views/mytable/more_dish_list.dart';

class MoreDishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("更多做法"),
      ),
      body: MoreDishBody(),
    );
  }
}
class MoreDishBody extends StatefulWidget {
  @override
  _MoreDishBodyState createState() => _MoreDishBodyState();
}

class _MoreDishBodyState extends State<MoreDishBody> {
  EasyRefreshController _controller;
  List<Data> _datas = new List<Data>();
  String dish_type = "smallImage";
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   getHttp();
  // }
  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      firstRefresh: true,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      controller: _controller,
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          print('onRefresh');
          dataRefreshByMock();
          //dataLoadByHttp();
          _controller.resetLoadState();
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          print('onLoad');
          dataLoadByMock();
          //dataLoadByHttp();
          _controller.finishLoad(noMore: this._datas.length >= 10);
        });
      },
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Container(
                  child: Center(
                    child: MoreDishListPage(_datas[index]),
                  )
              );
            },
            childCount: this._datas.length,
          ),
        ),
      ],
    );
  }

  void dataRefreshByHttp(){
    // HttpRequest.request(Constant.BASE_URL + "/card/card_page="+1.toString() + "/n_cards=6/n_dishs=6").then((res){
    //   final subjects = res["cards"];
    //   //print(subjects);
    //   List<Cards> subItems = [];
    //   for(var sub in subjects){
    //     subItems.add(Cards.fromJson(sub));
    //   }
    //   // 状态改变
    //   setState(() {
    //     this.cardsList = subItems;
    //   });
    //   //print(this.cardsList.length);
    // });
  }

  void dataLoadByHttp(){
    // pageIndex++;
    // HttpRequest.request(Constant.BASE_URL + "/card/card_page=" + pageIndex.toString() + "/n_cards=6/n_dishs=6").then((res){
    //
    //   final subjects = res["cards"];
    //   //print(subjects);
    //   List<Cards> subItems = [];
    //   for(var sub in subjects){
    //     subItems.add(Cards.fromJson(sub));
    //   }
    //   // 状态改变
    //   setState(() {
    //     this.cardsList.addAll(subItems);
    //   });
    //   //print(pageIndex);
    // });
  }

  void dataRefreshByMock(){
    MockRequest.mockMoreDish().then((res){
      Map userMap = json.decode(res.toString());
      var moreDish = new MoreDishModel.fromJson(userMap);
      setState(() {
        _datas = moreDish.data;
      });
    });
  }

  void dataLoadByMock(){
    MockRequest.mockMoreDish().then((res){
      Map userMap = json.decode(res.toString());
      var moreDish = new MoreDishModel.fromJson(userMap);
      setState(() {
        _datas = moreDish.data;
      });
    });
  }

  void getHttp() async {
    try {
      MockRequest.mockMoreDish().then((res){
        Map userMap = json.decode(res.toString());
        var moreDish = new MoreDishModel.fromJson(userMap);
        setState(() {
          _datas = moreDish.data;
        });
      });
    } catch (e) {
      print(e);
    }
  }
  // @override
  // Widget build(BuildContext context) {
  //   if(this._datas == null || this._datas.length == 0){
  //     return Scaffold();
  //   } else {
  //     return Container(
  //       padding: EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //           border:
  //           Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
  //       child:SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           //<Widget>[
  //           //for(Data data in _datas)
  //            //getScrollImage(data),
  //             //for (var i = 0; i < _datas.length - 1; i++)
  //               //getScrollImage(_datas[0]),
  //           //],
  //         ),
  //       )
  //       ,
  //     );
  //   }
  // }
  Widget getScrollImage(){
    // 每日菜单标题显示
    //getItemCountTitleWidget(data.dishTypeName,"aa");
    // 横向滚动组件
    //getSubScrollImage(data);
    SizedBox(height: 5);
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
          url: url,
        ),
      ),
    );
  }
  // 横向滚动图片组件(小图)
  Widget getSubScrollImage(Data data) {
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
        //Router.push(context, Router.detailItemPage, dish.dishId);
      },
    );
  }
}
