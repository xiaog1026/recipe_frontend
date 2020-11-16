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
    MockRequest.mockMyTable().then((res) {
      setState(() {
        this.myTableItem = MyTableItem.fromJson(res);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    CurrentRecommendation _currentRecommendation = this.myTableItem
        .currentRecommendation;
    if (_currentRecommendation == null) {
      return Container();
    }
    CurrentRecommendConditionSummary _currentRecommendConditionSummary = this
        .myTableItem.currentRecommendConditionSummary;
    if (_currentRecommendConditionSummary == null) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 每日菜单标题显示
            getItemCountTitleWidget("每日菜单", r.Router.moreDishPage),
            // 横向滚动组件
            getSubScrollImage(_currentRecommendation),
            SizedBox(height: 5),
            // 我的可用食材标题显示
            getItemCountTitleWidget("我的可用的主要食材", r.Router.ingredentNaviPage),
            getIngredents(_currentRecommendConditionSummary),
            SizedBox(height: 5),
            // 基础配菜条件标题显示
            getItemCountTitleWidget("基础配菜条件", r.Router.sideDishNaviPage),
            getSideDishBases(_currentRecommendConditionSummary),
            SizedBox(height: 5),
            // 想吃
            getItemCountTitleWidget("想吃",r.Router.sideDishNaviPage),
            getFavoriteIngredients(_currentRecommendConditionSummary),
            SizedBox(height: 5),
            // 不想吃
            getItemCountTitleWidget("不想吃",r.Router.sideDishNaviPage),
            getUnlikeIngredients(_currentRecommendConditionSummary),
            SizedBox(height: 5),
            // 最喜欢
            getItemCountTitleWidget("最喜欢",r.Router.sideDishNaviPage),
            getFavoriteFlavor(_currentRecommendConditionSummary),
            SizedBox(height: 5),
            // 烹饪方法
            getItemCountTitleWidget("烹饪方法",r.Router.sideDishNaviPage),
            getCookingMethod(_currentRecommendConditionSummary),
            SizedBox(height: 5),
            // 烹饪方法
            getItemCountTitleWidget("药膳",r.Router.sideDishNaviPage),
            getMedicalHistory(_currentRecommendConditionSummary),
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
    if (title == null) {
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
  Widget getSubScrollImage(CurrentRecommendation _currentRecommendation) {
    if (_currentRecommendation.dish == null || _currentRecommendation.dish.length == 0) {
      return Container();
    }
    double _height = 120.0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: _height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var d in _currentRecommendation.dish)
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
          type: "smallImage"
      ),
      onTap: () {
        r.Router.push(context, r.Router.detailItemPage, dish.dishId);
      },
    );
  }

  //食材列表
  Widget getIngredents(CurrentRecommendConditionSummary _currentCondition) {
    List<Condition> _validIngredents = _currentCondition
        .validIngredents;
    if (_validIngredents == null || _validIngredents.length == 0) {
      return Container();
    }
    return buildSuggestions(_validIngredents);
    //
    // return Padding(
    //   padding: EdgeInsets.all(1),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       SizedBox(height: 3),
    //       Wrap(
    //         spacing: 5.0, //两个widget之间横向的间隔
    //         direction: Axis.horizontal, //方向
    //         alignment: WrapAlignment.start, //内容排序方式
    //         children: List<Widget>.generate(
    //           _validIngredents.length,
    //               (int index) {
    //             return ActionChip(
    //               //标签文字
    //               label: Text(
    //                 _validIngredents[index].conditionName + "  " +
    //                     _validIngredents[index].conditionValue.toString(),
    //                 style: TextStyle(
    //                   fontSize: 16,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               //点击事件
    //               onPressed: () async {
    //
    //               },
    //               elevation: 3,
    //               backgroundColor: Color.fromARGB(
    //                 180,
    //                 Random().nextInt(255),
    //                 Random().nextInt(255),
    //                 Random().nextInt(255),
    //               ),
    //             );
    //           },
    //         ).toList(),
    //       ),
    //     ],
    //   ),
    // );
  }

  //基础配菜列表
  Widget getSideDishBases(CurrentRecommendConditionSummary _currentCondition) {
    List<Condition> nPersonWithBadTeeth = _currentCondition.nPersonWithBadTeeth;
    List<Condition> nKids = _currentCondition.nKids;
    List<Condition> nDishs = _currentCondition.nDishs;
    List<Condition> nPerson = _currentCondition.nPerson;
    List<Condition> cookingTime = _currentCondition.cookingTime;
    List<Condition> cost = _currentCondition.cost;

    return Column(
      children: <Widget>[
        getSideDishBase(nPersonWithBadTeeth),
        getSideDishBase(nKids),
        getSideDishBase(nDishs),
        getSideDishBase(nPerson),
        getSideDishBase(cookingTime),
        getSideDishBase(cost),
      ],
    );
  }
  Widget getSideDishBase(List<Condition> conditions){
    if (conditions == null || conditions.length == 0){
      return Container();
    } else {
      return
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 5),
              Text(conditions[0].conditionName + "  " + conditions[0].conditionValue.toString())
            ]
        );
    }
  }
// 想吃
Widget getFavoriteIngredients(CurrentRecommendConditionSummary _currentCondition) {
  List<Condition> _favoriteIngredients = _currentCondition.favoriteIngredients;
  if (_favoriteIngredients == null || _favoriteIngredients.length == 0) {
    return Container();
  }
  return buildSuggestions(_favoriteIngredients);
}
// 不想吃
  Widget getUnlikeIngredients(CurrentRecommendConditionSummary _currentCondition) {
    List<Condition> unlikeIngredients = _currentCondition.unlikeIngredients;
    if (unlikeIngredients == null || unlikeIngredients.length == 0) {
      return Container();
    }
    return buildSuggestions(unlikeIngredients);
  }
  // 最喜欢的
  Widget getFavoriteFlavor(CurrentRecommendConditionSummary _currentCondition) {
    List<Condition> favoriteFlavor = _currentCondition.favoriteFlavor;
    if (favoriteFlavor == null || favoriteFlavor.length == 0) {
      return Container();
    }
    return buildSuggestions(favoriteFlavor);
  }

  // 烹饪方法
  Widget getCookingMethod(CurrentRecommendConditionSummary _currentCondition) {
    List<Condition> cookingMethod = _currentCondition.cookingMethod;
    if (cookingMethod == null || cookingMethod.length == 0) {
      return Container();
    }
    return buildSuggestions(cookingMethod);
  }
  // 药膳
  Widget getMedicalHistory(CurrentRecommendConditionSummary _currentCondition) {
    List<Condition> medicalHistory = _currentCondition.medicalHistory;
    if (medicalHistory == null || medicalHistory.length == 0) {
      return Container();
    }
    return buildSuggestions(medicalHistory);
  }

@override
Widget buildSuggestions(List<Condition> conditions) {
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
            conditions.length,
                (int index) {
              return ActionChip(
                //标签文字
                label: Text(
                  conditions[index].conditionName + "  " +
                      conditions[index].conditionValue.toString(),
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