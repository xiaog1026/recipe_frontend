import 'package:flutter/material.dart';
import 'package:lovekitchen/models/home_model.dart';
import 'package:lovekitchen/components/dashed_line.dart';
import 'package:lovekitchen/components/star_rating.dart';
import 'package:lovekitchen/widgets/item_count_title.dart';
import 'package:lovekitchen/widgets/top_item_widget.dart';
import 'package:lovekitchen/router.dart';
import 'package:lovekitchen/widgets/video_item_widget.dart';

import 'package:cached_network_image/cached_network_image.dart';

class DetailItemPage extends StatelessWidget {
  final subjectId;
  BuildContext context;
  DetailItemPage(this.subjectId, {Key key}) : super(key: key);

  // 横向滚动图片大小
  var scrollimgSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详细"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 标题显示 首页模块1
            getImageByType1(1),
            // 横向滚动LIST(首页模块1，今日特辑 )

            SizedBox(height: 5),
            // 标题显示 首页模块2

            // 横向滚动LIST(首页模块2，新品推荐 )

            SizedBox(height: 5),
            // 标题显示 首页模块3


            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }



// 模块1获取显示的图片组件
Widget getImageByType1(int index) {
  return GestureDetector(
    child: VideoItemWidget(
        title: "大碗宽面",
        url: "https://cp1.douguo.com/upload/caiku/4/1/d/220_41fce42b881f9d46e6648160c528a72d.jpeg",
        type: "type1"
    ),
    onTap: () {
      Router.push(context, Router.videoPage, "1");
    },
  );
}
}