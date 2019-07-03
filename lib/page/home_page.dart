import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yongyou/common/localization/default_localizations.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:yongyou/common/utils/common_utils.dart';
import 'package:yongyou/common/utils/navigator_utils.dart';
import 'package:yongyou/page/sales_list_page.dart';
import 'package:yongyou/widget/app_tabbar_widget.dart';
import 'package:yongyou/widget/app_title_bar.dart';
import 'package:yongyou/widget/home_drawer.dart';

import 'dispatch_list_page.dart';
import 'my_page.dart';

/**
 * 主页
 * Created by guoshuyu
 * Date: 2018-07-16
 */

class HomePage extends StatefulWidget {
  static final String sName = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//class HomePage extends StatelessWidget {
//  static final String sName = "home";
  String _content = 'Undefined';
  String _qrBase64Content = 'Undefined';
  Image _qrImg;

  TextEditingController _qrTextEditingController = TextEditingController();

  String _error;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
//    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
//
//    var initializationSettingsAndroid =
//    new AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = new IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
//    var initializationSettings = new InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: onSelectNotification);
  }

//  Future onDidRecieveLocalNotification(
//      int id, String title, String body, String payload) async {
//    // 展示通知内容的 dialog.
//    showDialog(
//      context: context,
//      builder: (BuildContext context) => new CupertinoAlertDialog(
//        title: new Text(title),
//        content: new Text(body),
//        actions: [
//          CupertinoDialogAction(
//            isDefaultAction: true,
//            child: new Text('Ok'),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                new MaterialPageRoute(
////                  builder: (context) => new ScanView(),
//                ),
//              );
//            },
//          )
//        ],
//      ),
//    );
//  }

//  Future onSelectNotification(String payload) async {
//    if (payload != null) {
//      debugPrint('notification payload: ' + payload);
//    }
////    await Navigator.push(
////      context,
////      new MaterialPageRoute(builder: (context) => new ScanView()),
////    );
//  }

//  Future<void> _showNotification(int id, String title, String content) async {
//    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
////    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
////        'your channel id', 'your channel name', 'your channel description',
////        importance: Importance.Max, priority: Priority.High);
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        '0', '00', '000',
//        importance: Importance.Max, priority: Priority.High);
//    //IOS的通知配置
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    //显示通知，其中 0 代表通知的 id，用于区分通知。
//    await flutterLocalNotificationsPlugin.show(
//        id, title, content, platformChannelSpecifics,
//        payload: 'complete');
//  }

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    ///如果是 android 回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }

    return Future.value(false);
  }

  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 24.0), new Text(text)],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(APPICons.MAIN_DT, CommonUtils.getLocale(context).home_sales),
      _renderTab(APPICons.MAIN_QS, CommonUtils.getLocale(context).home_dispatch),
      _renderTab(APPICons.MAIN_MY, CommonUtils.getLocale(context).home_my),
    ];
    ///增加返回按键监听
    return WillPopScope(
      onWillPop: () {
        return _dialogExitApp(context);
      },
      child: new APPTabBarWidget(
        drawer: new HomeDrawer(),
        type: APPTabBarWidget.BOTTOM_TAB,
        tabItems: tabs,
        tabViews: [
          new SalesListPage(),
          new DispatchListPage(),
          new MyPage(),
        ],
        backgroundColor: APPColors.primarySwatch,
        indicatorColor: Color(APPColors.white),
        title: APPTitleBar(
          APPLocalizations.of(context).currentLocalized.app_name,
          children: [
//            popMenu(context),
            _NomalPopMenu(),
          ],
        ),
      ),
    );
  }

  Widget _NomalPopMenu() {
    return new PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
            value: 'sales', child: new Text('新增销售订单'))
      ],
      onSelected: (String value) async {
        print(value);
        switch(value) {
          case 'sales': {
//            NavigatorUtils.goBaiduMap(context);
            NavigatorUtils.goNewSales(context);
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => NewSalesPage()));
          }
          break;
        }
//          setState(() { _bodyStr = value; });
      }
    );
  }
}
