import 'package:flutter/material.dart';
import 'package:recipe_frontend/views/add/add.dart';
import 'package:recipe_frontend/views/mytable/my_table.dart';
import 'package:recipe_frontend/views/home/home.dart';
import 'package:recipe_frontend/views/profile/profile.dart';
import 'package:recipe_frontend/views/shopping/shopping.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "recipe_frontend",
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
              icon: Icon(Icons.fastfood),
              title: Text("餐桌")
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
          MyTable(),
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