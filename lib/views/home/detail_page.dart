import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lovekitchen/widgets/item_count_title.dart';
import 'package:lovekitchen/router.dart';
import 'package:lovekitchen/widgets/video_item_widget.dart';

///详情页面
class DetailPage extends StatelessWidget {
  final subjectId;
  //
  BuildContext context;
  DetailPage(this.subjectId, {Key key}) : super(key: key);
  var scrollimgSize;
  @override
  Widget build(BuildContext lcontext) {
    context = lcontext;
    // 横向滚动图片大小
    scrollimgSize = MediaQuery.of(context).size.width / 5 * 3;
    return Container(
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题显示 首页模块1
          //getItemCountTitleWidget('今日特辑', 5),
          // 横向滚动LIST(首页模块1，今日特辑 )

          SizedBox(height: 5),
          // 标题显示 首页模块2
          //getItemCountTitleWidget('新品推荐', 5),
          // 横向滚动LIST(首页模块2，新品推荐 )

          SizedBox(height: 5),
          // 标题显示 首页模块3
          //getItemCountTitleWidget('我们都在看', 9),

          SizedBox(height: 5),
        ],
      ),
    );
  }
  // 标题组件
  // Widget getItemCountTitleWidget(var title, int count) {
  //   return Container(
  //     child: Padding(
  //       padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
  //       child: ItemCountTitle(
  //         title,
  //         count: count,
  //       ),
  //     ),
  //   );
  // }

  // 模块1获取显示的图片组件
  // Widget getImageByType1(int index) {
  //   return GestureDetector(
  //     child: VideoItemWidget(
  //         title: "大碗宽面",
  //         url: "https://cp1.douguo.com/upload/caiku/4/1/d/220_41fce42b881f9d46e6648160c528a72d.jpeg",
  //         type: "type1"
  //     ),
  //     onTap: () {
  //       Router.push(context, Router.videoPage, "1");
  //     },
  //   );
  // }

  // @override
  // State<StatefulWidget> createState() {
  //   return _DetailPageState(subjectId);
  // }

}
