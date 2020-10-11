import 'package:flutter/material.dart';
import 'package:lovekitchen/models/home_model.dart';
import 'package:lovekitchen/components/dashed_line.dart';
import 'package:lovekitchen/components/star_rating.dart';

class ListItem extends StatelessWidget {

  final Item item;

  ListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
    border: Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    // 1.排名
    getRankWidget(),
    SizedBox(height: 12),
    // 2.内容
    getContentWidget(),
    SizedBox(height: 12),
    // 3.简介
    getIntroduceWidget(),
    SizedBox(height: 12,)
    ],
    ),
    );
  }

  // 电影排名
  Widget getRankWidget() {
    return Container(
        padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Color.fromARGB(255, 238, 205, 144)
        ),
        child: Text(
          "No.${item.rank}",
          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36)),
        )
    );
  }

  // 具体内容
  Widget getContentWidget() {
    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getContentImage(),
          getContentDesc(),
          getDashLine(),
          getContentWish()
        ],
      ),
    );
  }

  // 2.1.获取显示的图片
  Widget getContentImage() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(item.imageURL)
    );
  }

  Widget getContentDesc() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTitleWidget(),
            SizedBox(height: 3,),
            getRatingWidget(),
            SizedBox(height: 3,),
            getInfoWidget()
          ],
        ),
      ),
    );
  }

  Widget getDashLine() {
    return Container(
      width: 1,
      height: 100,
      child: DashedLine(
        axis: Axis.vertical,
        dashedHeight: 6,
        dashedWidth: .5,
        count: 12,
      ),
    );
  }

  Widget getTitleWidget() {
    return Stack(
      children: <Widget>[
        Icon(Icons.play_circle_outline, color: Colors.redAccent,),
        Text.rich(
          TextSpan(
              children: [
                TextSpan(
                    text: "     " + item.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),
                TextSpan(
                  text: "(${item.playDate})",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54
                  ),
                )
              ]
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget getRatingWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        StarRating(rating: item.rating, size: 18,),
        SizedBox(width: 5),
        Text("${item.rating}")
      ],
    );
  }

  Widget getInfoWidget() {
    // 1.获取种类字符串
    final genres = item.genres.join(" ");
    final director = item.director.name;
    var castString = "";
    for (final cast in item.casts) {
      castString += cast.name + " ";
    }

    // 2.创建Widget
    return Text(
      "$genres / $director / $castString",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16),
    );
  }

  // 2.4.获取想看的Widget
  Widget getContentWish() {
    return Container(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          Image.asset("assets/images/home/wish.png", width: 30,),
          SizedBox(height: 5,),
          Text(
            "想看",
            style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 235, 170, 60)),
          )
        ],
      ),
    );
  }

  // 简介（原生名称）
  Widget getIntroduceWidget() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(5)
      ),
      child: Text(item.originalTitle, style: TextStyle(fontSize: 18, color: Colors.black54),),
    );
  }
}