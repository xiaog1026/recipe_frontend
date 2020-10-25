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
    //var _imgSize = MediaQuery.of(context).size.width / 5 * 3;
    var _imgSize = MediaQuery.of(context).size.width;
//    }
    var fontColor = Colors.white;
    //_imgSize = _imgSize + 100;

    return Container(
      width: _imgSize,
      height: _imgSize,
      //padding: EdgeInsets.only(top: 5.0, right: 10.0, bottom: 5.0),
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
            Positioned(
              top: _imgSize / 2 + 40.0,
              left: _imgSize / 2 - 40,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              left:  _imgSize / 2 - 40,
              top:  _imgSize / 2  - 90,
              child: Image.asset(
                'assets/images/home/video_icon.png',
                width: 60.0,
                height: 60.0,
              ),
            )
          ],
        ),
      ),
    );

//  setState() {
//    state.update();
//  }
  }
}

