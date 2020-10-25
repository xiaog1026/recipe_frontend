import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovekitchen/models/home_model.dart';
import 'package:lovekitchen/components/dashed_line.dart';
import 'package:lovekitchen/components/star_rating.dart';
import 'package:lovekitchen/widgets/item_count_title.dart';
import 'package:lovekitchen/widgets/top_item_widget.dart';
import 'package:lovekitchen/router.dart';
import 'package:lovekitchen/widgets/video_item_widget.dart';
import 'package:lovekitchen/constant/color_constant.dart';
import 'package:lovekitchen/constant/text_size_constant.dart';
import 'package:lovekitchen/models/home_detail_item_model.dart';
import 'package:lovekitchen/network/mock_request.dart';

import 'package:cached_network_image/cached_network_image.dart';

class DetailItemPage extends StatelessWidget {

  final subjectId;
  BuildContext context;
  DetailItemPage(this.subjectId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext lcontext) {

    context = lcontext;
    return Scaffold(
      appBar: AppBar(
        title: Text("详细"),
      ),
      body: DetailItemHomePage(),
    );
  }
}
class DetailItemHomePage extends StatefulWidget {
  @override
  _DetailItemHomePage createState() => _DetailItemHomePage();
}

class _DetailItemHomePage extends State<DetailItemHomePage> {

  // 首页详细信息
  HomeDetailItem homeDetailItem = new HomeDetailItem();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // HttpRequest.request("https://flutter.cn/docs/development/ui/layout#1-select-a-layout-widget").then((res){
    //   print(res);
    // });
    MockRequest.mockHomeDetailItem().then((res){
      //print(res);
      // 状态改变
      setState(() {
        this.homeDetailItem = HomeDetailItem.fromJson(res);
      });
    });
  }
  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("dddsds");
    // print(this.homeDetailItem.dishId);
    // print(this.homeDetailItem.level);
    if(this.homeDetailItem.dishId == null){
      return Scaffold(
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
          child:Container(
            padding:EdgeInsets.all(10),
            decoration:BoxDecoration(
                border:
                Border(bottom:BorderSide(width:10,color:Color(0xffe2e2e2)))),
            child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisSize:MainAxisSize.max,
              children:<Widget>[
                //视频图片
                getImageByVideo(),
                SizedBox(height:5),
                //评价星星
                getRatingWidget(),
                Divider(height:10.0,indent:0.0,color:Colors.grey,),
                //标题显示评价
                getItemCountTitleWidget("评价"),
                SizedBox(height:5),
                getScrollWidgetType2(),
                Divider(height:10.0,indent:0.0,color:Colors.grey,),
                //标题显示难易度
                getItemCountTitleWidget("难易度："+this.homeDetailItem.level),
                SizedBox(height:5),
                Divider(height:10.0,indent:0.0,color:Colors.grey,),
                //标题显示食材
                getItemCountTitleWidget("食材："),
                getIngredents(),
                SizedBox(height:5),
                Divider(height:10.0,indent:0.0,color:Colors.grey,),
                //标题显示道具
                getItemCountTitleWidget("道具："),
                getTool(),
                SizedBox(height:5),
                Divider(height:10.0,indent:0.0,color:Colors.grey,),
                //标题显示营养素
                getItemCountTitleWidget("营养素："),
                getScrollWidgetNutrition(),
                SizedBox(height:5),
                Divider(height:10.0,indent:0.0,color:Colors.grey,),
                //标题显示烹饪步骤
                getItemCountTitleWidget("烹饪步骤："),
                getCookingSteps(),
                // 拍照组件
                getCamera(),
                SizedBox(height:1),
                //Divider(height:10.0,indent:0.0,color:Colors.grey,),
              ],
            ),
          )
      ),
    );
  }

  // 标题组件
  Widget getItemCountTitleWidget(var title) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: TextSizeConstant.BookAudioPartTabBar,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.colorDefaultTitle),
                )),
          ],
        ),
      ),
    );
  }
// 模块1获取显示的图片组件
  Widget getImageByVideo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 250.0,
      child: GestureDetector(
        child: VideoItemWidget(
            title: this.homeDetailItem.dishName,
            url: this.homeDetailItem.dishImageLink,
            type: "type1"
        ),
        onTap: () {
          Router.push(context, Router.videoPage, "1");
        },
      ),
    );
  }

// 评价星星组件
  Widget getRatingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StarRating(rating: 9, size: 18,),
        SizedBox(width: 5),
        Text("9")
      ],
    );
  }

  //食材列表
  Widget getIngredents() {
    return Column(
      children: <Widget>[
        Text(
            '1人数',
            textAlign : TextAlign.start
        ),
        //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
        for (var item in this.homeDetailItem.ingredents)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 5),
            Text(item.ingredentName + "  " + item.ingredentWeight)
          ],
        )
      ],
    );
  }

  // 道具名称
  Widget getTool() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 5),
        Text(this.homeDetailItem.tool)
      ],
    );
  }


  // 横向滚动小图  模块2组件
  Widget getScrollWidgetType2() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          getImageByType2(0),
          getImageByType2(1),
          getImageByType2(2),
          getImageByType2(3),
          getImageByType2(4)
        ],
      ),
    );
  }

  // 模块1获取显示的图片组件
  Widget getImageByType2(int index) {
    // List<String> _foodReviewImages=[
    //   "https://res1.hoto.cn/595b6009d637550fb408d4a0.jpg!w580",
    //   "https://res1.hoto.cn/0304f57559633f0df444eb88.jpg!default",
    //   "https://res1.hoto.cn/030efca659633f0df444eb88.jpg!default",
    //   "https://res1.hoto.cn/030e1e5759633f0df444eb88.jpg!default",
    //   "https://res1.hoto.cn/02fbc05259633f0df444eb88.jpg!default",
    //   "https://i3.meishichina.com/attachment/recipe/2020/10/08/2020100816021565823108197577.jpg?x-oss-process=style/c320",
    //   "https://i3.meishichina.com/attachment/recipe/2020/10/05/2020100516018763727048197577.jpg?x-oss-process=style/c320",
    //   "https://i3.meishichina.com/attachment/recipe/2020/10/06/2020100616019692622831958079.jpg?x-oss-process=style/c320",
    //   "https://i3.meishichina.com/attachment/recipe/2020/10/06/2020100616019715788221958079.jpg?x-oss-process=style/c320"];
    return GestureDetector(
      child: TopItemWidget(
          title: "",
          url: this.homeDetailItem.foodReviewImages[index],
          type: "type2"
      ),
      onTap: () {
        Router.push(context, Router.viewImg,  this.homeDetailItem.foodReviewImages[index]);
      },
    );
  }

  // 横向滚动营养组件
  Widget getScrollWidgetNutrition() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          getNutrition(100,"卡路里","1354"),
          getNutrition(200,"蛋白质","56克"),
          getNutrition(300,"脂肪","73克"),
          getNutrition(500,"碳水化物","118克"),
          getNutrition(400,"水","288克")
        ],
      ),
    );
  }

  // 营养图片子组件
  Widget getNutrition(int index, var name,var value) {
    return Stack(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors:[Colors.white,Colors.blue[index]]
            ), //背景渐变
            boxShadow: [ //阴影
              BoxShadow(
                  color:Colors.black54,
                  offset: Offset(2.0,2.0),
                  blurRadius: 4.0
              )
            ],
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
            shape: BoxShape.circle,
          ),
          child: Container(
            height: 120,
            width: 120,
          ),
        ),
        Positioned(
          top: 30,
          left: 40,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 40,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );

  }

  // 烹饪步骤
  Widget getCookingSteps() {
    int _count = 1;
    String _length = this.homeDetailItem.steps.length.toString();
    return Column(
      children: <Widget>[
        //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
        //for (var item in this.homeDetailItem.steps)
        for (int i = 0 ; i < this.homeDetailItem.steps.length ; i++)
    Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border:
          Border(bottom: BorderSide(width: 10, color: Color(0xffe2e2e2)))),
      child:
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "烹饪步骤  " + (i+1).toString() + "/" + _length,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 5),
                    Expanded(child:Text(this.homeDetailItem.steps[i].stepDescription)),
                  ],
                ),
                CachedNetworkImage(
                  width: 400,
                  height: 300,
                  fit: BoxFit.cover,
                  imageUrl: this.homeDetailItem.steps[i].stepImage,
                )
              ]
          )
    )
      ],
    );
  }



  // 拍照组件
  Widget getCamera() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 250.0,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 300,
                  child: _image == null
                      ? Text('咔嚓一下，分享你的美食')
                      : Image.file(_image)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlineButton.icon(
                  icon: Icon(Icons.add_a_photo),
                  label: Text("拍照"),
                  onPressed: getImageFromCamera,
                ),
                OutlineButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text("选择一张照片"),
                  onPressed: getImageFromGallery,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}