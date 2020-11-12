import 'package:flutter/material.dart';
import 'package:recipe_frontend/constant/text_size_constant.dart';
import 'package:recipe_frontend/constant/color_constant.dart';
import 'package:recipe_frontend/router.dart' as r;

typedef OnClick = void Function();

class ItemTitle extends StatelessWidget {
//  final state = _ItemCountTitleState();
  final url;
  final OnClick onClick;
  final String title;
  final double fontSize;

  ItemTitle(this.title, {Key key, this.onClick, this.url, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            title,
            style: TextStyle(
                fontSize: fontSize == null
                    ? TextSizeConstant.BookAudioPartTabBar
                    : fontSize,
                fontWeight: FontWeight.bold,
                color: ColorConstant.colorDefaultTitle),
          )),
          Text(
            '编辑> ',
            style: TextStyle(
                fontSize: 18, color: Colors.grey, ),
          )
        ],
      ),
      onTap: () {
        r.Router.push(context, url,null);
        // if (onClick != null) {
        //   //onClick();
        //   r.Router.push(context, r.Router.ingredentNaviPage,null);
        // }
      },
    );
  }
}