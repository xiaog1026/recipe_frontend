import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lovekitchen/views/home/detail_item_page.dart';
import 'package:lovekitchen/views/home/videoPlayer/video_player.dart';
import 'package:lovekitchen/views/home/ viewImg/view_img.dart';

///https://www.jianshu.com/p/b9d6ec92926f

class Router {
  static const homePage = 'app://';
  static const detailPage = 'app://DetailPage';
  static const detailItemPage = 'app://DetailItemPage';
  static const videoPage = 'app://VideoPage';
  static const viewImg = 'app://ViewImg';


  static const playListPage = 'app://VideosPlayPage';
  static const searchPage = 'app://SearchPage';
  static const photoHero = 'app://PhotoHero';
  static const personDetailPage = 'app://PersonDetailPage';

//  Widget _router(String url, dynamic params) {
//    String pageId = _pageIdMap[url];
//    return _getPage(pageId, params);
//  }
//
//  Map<String, dynamic> _pageIdMap = <String, dynamic>{
//    'app/': 'ContainerPageWidget',
//    detailPage: 'DetailPage',
//  };

  Widget _getPage(String url, dynamic params) {
      switch (url) {
        case detailItemPage:
          return DetailItemPage(params);
        case videoPage:
          return VideoPage(params);
        case viewImg:
          //return ViewImg(pimg:params['img'],pimgs:params['imgs'],pwidth:params['width']);
          return ViewImg();
      }
    // if (url.startsWith('https://') || url.startsWith('http://')) {
    //   return WebViewPage(url, params: params);
    // } else {
    //   switch (url) {
    //     case detailPage:
    //       return DetailPage(params);
    //     case homePage:
    //       return ContainerPage();
    //     case playListPage:
    //       return VideoPlayPage(params);
    //     case searchPage:
    //       return SearchPage(searchHintContent: params);
    //     case photoHero:
    //       return PhotoHeroPage(
    //           photoUrl: params['photoUrl'], width: params['width']);
    //     case personDetailPage:
    //       return PersonDetailPage(params['personImgUrl'], params['id']);
    //   }
    // }
    return null;
  }

  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
