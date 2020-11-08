import 'package:flutter/material.dart';
import 'package:recipe_frontend/constant/text_size_constant.dart';
import 'package:recipe_frontend/constant/color_constant.dart';

typedef OnClick = void Function();

class ItemCountTitle extends StatelessWidget {
//  final state = _ItemCountTitleState();
  final count;
  final OnClick onClick;
  final String title;
  final double fontSize;

  ItemCountTitle(this.title, {Key key, this.onClick, this.count, this.fontSize})
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
            '全部 ${count == null ? 0 : count} > ',
            style: TextStyle(
                fontSize: 18, color: Colors.grey, ),
          )
        ],
      ),
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
    );
  }
}