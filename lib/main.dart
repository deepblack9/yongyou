import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
//import 'package:flutter_just_toast/flutter_just_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:yongyou/common/event/http_error_event.dart';
import 'package:yongyou/common/event/index.dart';
import 'package:yongyou/common/redux/app_state.dart';
import 'package:yongyou/common/model/User.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:yongyou/common/utils/common_utils.dart';
import 'package:yongyou/common/net/code.dart';
import 'package:yongyou/common/utils/navigator_utils.dart';
import 'package:yongyou/common/localization/app_localizations_delegate.dart';
import 'package:yongyou/page/home_page.dart';
import 'package:yongyou/page/login_page.dart';
import 'package:yongyou/page/welcome_page.dart';

void main() {
  runZoned(() {
    runApp(FlutterReduxApp());
    PaintingBinding.instance.imageCache.maximumSize = 100;
  }, onError: (Object obj, StackTrace stack) {
    print(obj);
    print(stack);
  });
}

class FlutterReduxApp extends StatelessWidget {
  /// 创建Store，引用 APPState 中的 appReducer 实现 Reducer 方法
  /// initialState 初始化 State
  final store = new Store<APPState>(
    appReducer,
    middleware: middleware,

    ///初始化数据
    initialState: new APPState(
        userInfo: User.empty(),
        themeData: CommonUtils.getThemeData(APPColors.primarySwatch),
        locale: Locale('zh', 'CH')),
  );

  FlutterReduxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 通过 StoreProvider 应用 store
    return new StoreProvider(
      store: store,
      child: new StoreBuilder<APPState>(builder: (context, store) {
        return new MaterialApp(

          ///多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              APPLocalizationsDelegate.delegate,
            ],
            locale: store.state.locale,
            supportedLocales: [store.state.locale],
            theme: store.state.themeData,
            routes: {
              WelcomePage.sName: (context) {
                store.state.platformLocale = Localizations.localeOf(context);
                return WelcomePage();
              },
              HomePage.sName: (context) {
                ///通过 Localizations.override 包裹一层，
                return new APPLocalizations(
                    child: NavigatorUtils.pageContainer(new HomePage()));
              },
              LoginPage.sName: (context) {
                return new APPLocalizations(
                    child: NavigatorUtils.pageContainer(new LoginPage()));
              },
            });
      }),
    );
  }
}

class APPLocalizations extends StatefulWidget {
  final Widget child;

  APPLocalizations({Key key, this.child}) : super(key: key);

  @override
  State<APPLocalizations> createState() {
    return new _APPLocalizations();
  }
}

class _APPLocalizations extends State<APPLocalizations> {
  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<APPState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return new Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    ///Stream演示event bus
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  ///网络错误提醒
  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
//        Toast.show(message: CommonUtils.getLocale(context).network_error,duration: Delay.SHORT);
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error);
        break;
      case 401:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_401,duration: Delay.SHORT);
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_401);
        break;
      case 403:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_403,duration: Delay.SHORT);
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_403);
        break;
      case 404:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_404,duration: Delay.SHORT);
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_404);
        break;
      case Code.NETWORK_TIMEOUT:
      //超时
//        Toast.show(message: CommonUtils.getLocale(context).network_error_timeout,duration: Delay.SHORT);
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_timeout);
        break;
      default:
//        Toast.show(message: CommonUtils.getLocale(context).network_error_unknown + " " + message,duration: Delay.SHORT);
        Fluttertoast.showToast(msg: CommonUtils.getLocale(context).network_error_unknown +
            " " +
            message);
        break;
    }
  }
}
