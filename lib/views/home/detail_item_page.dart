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
import 'package:lovekitchen/widgets/image_item_widget.dart';
import 'package:lovekitchen/constant/color_constant.dart';
import 'package:lovekitchen/constant/text_size_constant.dart';
import 'package:lovekitchen/models/home_detail_item_model.dart';
import 'package:lovekitchen/network/mock_request.dart';
import 'package:lovekitchen/network/http_request.dart';
import 'package:lovekitchen/network/http_config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailItemPage extends StatelessWidget {

  final int id;
  BuildContext context;
  DetailItemPage(this.id, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext lcontext) {

    context = lcontext;
    return Scaffold(
      appBar: AppBar(
        title: Text("详细"),
      ),
      body: DetailItemHomePage(id),
    );
  }
}
class DetailItemHomePage extends StatefulWidget {
  final int _id;
  DetailItemHomePage(this._id);

  @override
  _DetailItemHomePage createState() => _DetailItemHomePage(_id);
}

class _DetailItemHomePage extends State<DetailItemHomePage> {
  final int _dashId;
  _DetailItemHomePage(this._dashId);
  int _counter = 1;

  // 首页详细信息
  HomeDetailItem homeDetailItem = new HomeDetailItem();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpRequest.request(Constant.BASE_URL + "/dish/dish_id=" + this._dashId.toString()).then((res){
      setState(() {
        this.homeDetailItem = HomeDetailItem.fromJson(res);
      });
    });
    // MockRequest.mockHomeDetailItem().then((res){
    //   //print(res);
    //   // 状态改变
    //   setState(() {
    //     this.homeDetailItem = HomeDetailItem.fromJson(res);
    //   });
    // });
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

    if(this.homeDetailItem.id == null){
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
                getImage(),
                SizedBox(height:5),
                //评价星星
                getRatingWidget(),
                Divider(height:10.0,indent:0.0,color:Colors.grey,),
                //标题显示评价
                getItemCountTitleWidget("评价"),
                SizedBox(height:5),
                getReviewImages(),
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
// 显示的菜谱主图片组件
  Widget getImage() {
    if(this.homeDetailItem.dishVedioLink == ""){
      return getImageByImage();
    } else {
      return getImageByVideo();
    }
  }

// 显示的菜谱主图片组件(有视频时)
  Widget getImageByVideo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 250.0,
      child: GestureDetector(
        child: VideoItemWidget(
            title: this.homeDetailItem.dishname,
            url: this.homeDetailItem.dishImageLink,
            type: "type1"
        ),
        onTap: () {
          Router.push(context, Router.videoPage, this.homeDetailItem);
        },
      ),
    );
  }

  // 显示的菜谱主图片组件(无视频时)
  Widget getImageByImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 250.0,
      child: GestureDetector(
        child: ImageItemWidget(
            title: this.homeDetailItem.dishname,
            url: this.homeDetailItem.dishImageLink,
            type: "type1"
        ),
      ),
    );
  }

// 评价星星组件
  Widget getRatingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StarRating(rating: this.homeDetailItem.rating.average, size: 18,),
        SizedBox(width: 5),
        Text("9")
      ],
    );
  }

  //食材列表
  Widget getIngredents() {

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 5),
            Text(
              _counter.toString() +'人数',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  _counter--;
                });
                },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                _counter++;
              });
                },
            )
          ],
        ),
        SizedBox(width: 5),
        //for (var item in this.homeDetailItem.ingredents) Text(item.ingredentName + "  " + item.ingredentWeight),
        for (var item in this.homeDetailItem.ingredients)
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 5),
            Text(item.ingredentName + "  " + (item.ingredentWeight*_counter).toString() + item.ingredentUnit)
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


  // 横向滚动评价小图组件
  Widget getReviewImages() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for(Comments comment in this.homeDetailItem.comments)
            if (comment.image != "")
              getReviewImage(comment)

        ],
      ),
    );
  }

  // 显示的评价的小图片组件
  Widget getReviewImage(Comments comment) {
    return GestureDetector(
      child: TopItemWidget(
          title: "",
          url: comment.image,
          type: "type2"
      ),
      onTap: () {
        var paramMap = new Map();
        //paramMap.addAll("",)
        Router.push(context, Router.viewImg,  comment.image);
      },
    );
  }

  // 横向滚动营养组件
  Widget getScrollWidgetNutrition() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      height: 90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          //for (int i = 0 ; i < this.homeDetailItem.nutritions.length ; i++)
          for(Nutritions nutrition in this.homeDetailItem.nutritions)
          getNutrition(nutrition.nutritionName,nutrition.nutritionWeight)
        ],
      ),
    );
  }

  // 营养图片子组件
  Widget getNutrition(var name,double value) {
    return Stack(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors:[Colors.white,Colors.blue[100]]
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
            height: 100,
            width: 100,
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
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
          left: 10,
          child: Text(
            value.toString(),
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
                      ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "咔嚓一下，分享你的美食",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5)
                    ],
                  )
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