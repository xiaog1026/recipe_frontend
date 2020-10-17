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
          'https://vplay.douguo.com/lrcm5DQPxgomOgWoVMnwyJNY_j7A_DgUO__640x362.mp4',
          title: '示例视频',
        ),
      ),
    );
  }
}
