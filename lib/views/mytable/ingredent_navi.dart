import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_frontend/models/my_table_ingredent_navi.dart';
import 'package:recipe_frontend/widgets/article_detail.dart';
import 'package:recipe_frontend/constant/color_constant.dart';
import 'package:recipe_frontend/network/http_request.dart';
import 'package:recipe_frontend/network/httpUtil.dart';
import 'package:recipe_frontend/network/http_config.dart';
import 'package:recipe_frontend/network/mock_request.dart';

class NaviPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("我的可用食材");
    return Scaffold(
      appBar: AppBar(
        title: Text("我的可用食材"),
      ),
      body: NaviPageBody(),
    );
  }
}

class NaviPageBody extends StatefulWidget {
  @override
  _NaviPageBodyState createState() => _NaviPageBodyState();
}

class _NaviPageBodyState extends State<NaviPageBody> {
  List<NaviData> _datas = new List(); //一级分类集合
  List<NaviDataArticle> articles = new List(); //二级分类集合
  int index; //一级分类下标

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
      MockRequest.mockIngredent().then((res){
        Map userMap = json.decode(res.toString());
        var naviEntity = new NaviEntity.fromJson(userMap);
        /// 初始化
        setState(() {
          _datas = naviEntity.data;
          index = 0;
        });
      });
      // var response = await HttpUtil().get(Constant.NAVI);
      // Map userMap = json.decode(response.toString());
      // var naviEntity = NaviEntity.fromJson(userMap);
      // /// 初始化
      // setState(() {
      //   _datas = naviEntity.data;
      //   index = 0;
      // });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WillPopScope(
          onWillPop: () async => showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(title: Text('确定保存设置?'), actions: <Widget>[
                    RaisedButton(
                        child: Text('保存返回'),
                        onPressed: () => Navigator.of(context).pop(true)),
                    RaisedButton(
                        child: Text('放弃'),
                        onPressed: () => Navigator.of(context).pop(true)),
                    RaisedButton(
                        child: Text('再想想'),
                        onPressed: () => Navigator.of(context).pop(false)),
                  ])),
          child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Expanded(
                flex: 2,
                child: Container(
                color: ColorConstant.color_fff,
                child: new ListView.builder(
                    itemCount: _datas.length,
                    itemBuilder: (BuildContext context, int position) {
                      return getRow(position);
                    }),
                )
            ),
            new Expanded(
                flex: 5,
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(10),
                      color: ColorConstant.color_F9F9F9,
                      child: getChip(index), //传入一级分类下标
                    ),
                  ],
                )
            ),
          ],))
    );
  }

  Color textColor = ColorConstant.colorPrimary; //字体颜色

  Widget getRow(int i) {
    return new GestureDetector(
      child: new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        color: index == i ? ColorConstant.color_F9F9F9 : Colors.white,
        child: new Text(_datas[i].name,
            style: TextStyle(
                color: index == i ? textColor : ColorConstant.color_666,
                fontWeight: index == i ? FontWeight.w600 : FontWeight.w400,
                fontSize: 16)),
      ),
      onTap: () {
        setState(() {
          index = i; //记录选中的下标
          textColor = ColorConstant.colorPrimary;
        });
      },
    );
  }

  Widget getChip(int i) {
    //更新对应下标数据
    _updateArticles(i);
    return Wrap(
      spacing: 10.0, //两个widget之间横向的间隔
      direction: Axis.horizontal, //方向
      alignment: WrapAlignment.start, //内容排序方式
      children: List<Widget>.generate(
        articles.length,
            (int index) {
          return ActionChip(
            //标签文字
            label: Text(articles[index].title,
                style: TextStyle(fontSize: 16, color: ColorConstant.color_666)),
            //点击事件
            onPressed: () {
              // Navigator.push(
              //   context,
              //   new MaterialPageRoute(
              //       builder: (context) => new ArticleDetail(
              //           title: articles[index].title,
              //           url: articles[index].link)),
              // );
            },
            elevation: 3,
            backgroundColor: Colors.grey.shade200,
          );
        },
      ).toList(),
    );
  }

  ///
  /// 根据一级分类下标更新二级分类集合
  ///
  List<NaviDataArticle> _updateArticles(int i) {
    setState(() {
      if (_datas.length != 0) articles = _datas[i].articles;
    });
    return articles;
  }
}