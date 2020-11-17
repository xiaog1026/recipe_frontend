import 'package:flutter/material.dart';
import 'package:recipe_frontend/models/home_model.dart';
import 'package:recipe_frontend/models/home_list_model.dart';
import 'package:recipe_frontend/network/http_request.dart';
import 'package:recipe_frontend/network/mock_request.dart';
import 'package:recipe_frontend/views/home/home_list_page.dart';
import 'dart:async';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:recipe_frontend/network/http_config.dart';

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
  EasyRefreshController _controller;
  List<Cards> cardsList = [];
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
  }

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
              //dataRefreshByMock();
              dataLoadByHttp();
              _controller.resetLoadState();
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(seconds: 2), () {
              print('onLoad');
              //dataLoadByMock();
              dataLoadByHttp();
              _controller.finishLoad(noMore: this.cardsList.length >= 10);
            });
          },
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Container(
                    child: Center(
                      child: HomeListPage(cardsList[index]),
                    )
                  );
                },
                childCount: this.cardsList.length,
              ),
            ),
          ],
        );
  }

  void dataRefreshByHttp(){
    HttpRequest.request(ApiConstant.BASE_URL + "/card/card_page="+1.toString() + "/n_cards=6/n_dishs=6").then((res){
      final subjects = res["cards"];
      //print(subjects);
      List<Cards> subItems = [];
      for(var sub in subjects){
        subItems.add(Cards.fromJson(sub));
      }
      // 状态改变
      setState(() {
        this.cardsList = subItems;
      });
      //print(this.cardsList.length);
    });
  }

  void dataLoadByHttp(){
    pageIndex++;
    HttpRequest.request(ApiConstant.BASE_URL + "/card/card_page=" + pageIndex.toString() + "/n_cards=6/n_dishs=6").then((res){

      final subjects = res["cards"];
      //print(subjects);
      List<Cards> subItems = [];
      for(var sub in subjects){
        subItems.add(Cards.fromJson(sub));
      }
      // 状态改变
      setState(() {
        this.cardsList.addAll(subItems);
      });
      //print(pageIndex);
    });
  }

  void dataRefreshByMock(){
    MockRequest.mockHome().then((res){
      final subjects = res["cards"];
      List<Cards> subItems = [];
      for(var sub in subjects){
        subItems.add(Cards.fromJson(sub));
      }
      // 状态改变
      setState(() {
        this.cardsList = subItems;
      });
    });
  }

  void dataLoadByMock(){
    MockRequest.mockHome().then((res){
      final subjects = res["cards"];
      List<Cards> subItems = [];
      for(var sub in subjects){
        subItems.add(Cards.fromJson(sub));
      }
      // 状态改变
      setState(() {
        this.cardsList.addAll(subItems);
      });
    });
  }
}