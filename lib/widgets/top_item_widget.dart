import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

///
class TopItemWidget extends StatelessWidget {
//  _TopItemWidgetState state;
  final String title;
  final String url;
  final String type;

//  var _imgSize;

  TopItemWidget({
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
    if ("bigImage" == type){
      _imgSize = _imgSize + 100;
      fontColor = Colors.red;
    } else if ("smallImage" == type){
      _imgSize = _imgSize/2;
    } else {
      _imgSize = _imgSize/3;
    }

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
            Positioned(
              top: _imgSize / 2 + 40.0,
              left: 1.0,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  color: fontColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Positioned(
            //   top: _imgSize / 2,
            //   child: Container(
            //     height: _imgSize / 2,
            //     width: _imgSize,
            //     color: Colors.brown,
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

