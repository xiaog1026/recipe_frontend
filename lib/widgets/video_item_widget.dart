import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

///
class VideoItemWidget extends StatelessWidget {
//  _TopItemWidgetState state;
  final String title;
  final String url;
  final String type;

//  var _imgSize;

  VideoItemWidget({
    Key key,
    @required this.title,
    @required this.url,
    @required this.type,
  }) : super(key: key);

//  @override
//  State<StatefulWidget> createState() {
//    state = _TopItemWidgetState();
//    return state;
//  }
  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return Container();
    }
//    if (_imgSize == null) {
    var _imgSize = MediaQuery.of(context).size.width / 5 * 3;
//    }
    var fontColor = Colors.white;
    _imgSize = _imgSize + 200;

    return Container(
      width: _imgSize,
      height: _imgSize,
      padding: EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            CachedNetworkImage(
              width: _imgSize,
              height: _imgSize,
              fit: BoxFit.cover,
              imageUrl: url,
            ),
            // Positioned(
            //   left: _imgSize / 2,
            //   child: Image.asset(
            //     'assets/images/home/video_icon.png',
            //     width: 30.0,
            //     height: 30.0,
            //   ),
            // )
          ],
        ),
      ),
    );

//  setState() {
//    state.update();
//  }
  }
}

