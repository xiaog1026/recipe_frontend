import 'package:flutter/material.dart';
import 'package:lovekitchen/views/add/add.dart';
import 'package:lovekitchen/views/category/category.dart';
import 'package:lovekitchen/views/home/home.dart';
import 'package:lovekitchen/views/profile/profile.dart';
import 'package:lovekitchen/views/shopping/shopping.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "lovekitchen",
      theme: ThemeData(
        primaryColor: Colors.green,
        //highlightColor: Colors.transparent,
        //splashColor: Colors.transparent
      ),
      home: MyStackPage(),
    );
  }
}


class MyStackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyStackPageState();
  }
}

class MyStackPageState extends State<MyStackPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("首页")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text("分类")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_to_photos),
              title: Text("上传")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              title: Text("购物")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("我的")
          )
        ],
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });

        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Home(),
          Category(),
          Add(),
          Shopping(),
          Profile()
        ],
      ),
    );
  }
}

BottomNavigationBarItem createItem(String iconName, String title) {
  return BottomNavigationBarItem(
      icon: Image.asset("assets/images/tabbar/$iconName.png", width: 30,),
      activeIcon: Image.asset("assets/images/tabbar/${iconName}_active.png", width: 30,),
      title: Text(title)
  );
}