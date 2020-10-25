import 'package:flutter/material.dart';
import 'package:lovekitchen/views/home/videoPlayer/video_player_UI.dart';

class VideoPage extends StatelessWidget {
  static final String routerName = '/VideoPage';
  final subjectId;
  BuildContext context;
  VideoPage(this.subjectId, {Key key}) : super(key: key);

//  Size get _window => MediaQueryData.fromWindow(window).size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // 该组件宽高默认填充父控件，你也可以自己设置宽高
        child: VideoPlayerUI.network(
          url:
          'https://vplay.douguo.com/XMzY0NDQ3ODY0NA==_DouG__640x356.mp4',
          title: '麻辣小龙虾',
        ),
      ),
    );
  }
}
