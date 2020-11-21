class ApiConstant {
 static const String BASE_URL = 'http://153.246.128.73:1991';
 static const TIMOUT = 5000;

 // 餐桌的显示数据
 static const String TABLE_USERID = "/table/user_id";
 //注册
 static const String REGISTER=BASE_URL+'/auth/register';
 //登录
 static const String LOGIN=BASE_URL+'/auth/login';
 //游客登录
 static const String VISITOR_LOGIN=BASE_URL+'/user/register';
 //退出登录
 static const String LOGIN_OUT=BASE_URL+"/auth/logout";

 // static const String BASE_URL_1 = "https://www.wanandroid.com/";
 //
 // static const String TEST_URL = "https://api.hencoder.com/author";

 //首页banner
 static const String BANNER = "banner/json";

 //体系数据
 static const String TREE = "tree/json";

 //导航数据
 static const String NAVI = "navi/json";

 //项目分类
 static const String PROJECT = "project/tree/json";

 //项目列表数据
 static const String PROJECT_LIST = "project/list/";

 //退出登录
 static const String LOGOUT = "user/logout/json";

 //搜索热词
 static const String HOT_KEY = "hotkey/json";

 //搜索
 static const String QUERY = "article/query/0/json";


}