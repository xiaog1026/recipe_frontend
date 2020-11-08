import 'package:flutter/material.dart';
import 'package:recipe_frontend/views/home/videoPlayer/video_player_UI.dart';
import 'package:recipe_frontend/models/home_detail_item_model.dart';

class VideoPage extends StatelessWidget {
  static final String routerName = '/VideoPage';
  final HomeDetailItem homeDetailItem;
  BuildContext context;
  VideoPage(this.homeDetailItem, {Key key}) : super(key: key);

//  Size get _window => MediaQueryData.fromWindow(window).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // 该组件宽高默认填充父控件，你也可以自己设置宽高
        child: VideoPlayerUI.network(
          url:homeDetailItem.dishVedioLink,
          title: homeDetailItem.dishname,
        ),
      ),
    );
  }
}
