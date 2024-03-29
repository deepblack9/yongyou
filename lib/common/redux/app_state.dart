import 'package:flutter/material.dart';
import 'package:yongyou/common/model/User.dart';
import 'package:yongyou/common/redux/middleware/epic_middleware.dart';
import 'package:yongyou/common/redux/user_redux.dart';
import 'package:yongyou/common/redux/theme_redux.dart';
import 'package:yongyou/common/redux/locale_redux.dart';
import 'package:redux/redux.dart';

/**
 * Redux全局State
 * Created by guoshuyu
 * Date: 2018-07-16
 */

///全局Redux store 的对象，保存State数据
class APPState {
  ///用户信息
  User userInfo;

  ///主题数据
  ThemeData themeData;

  ///语言
  Locale locale;

  ///当前手机平台默认语言
  Locale platformLocale;

  ///构造方法
  APPState({this.userInfo, this.themeData, this.locale});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
APPState appReducer(APPState state, action) {
  return APPState(
    ///通过 UserReducer 将 APPState 内的 userInfo 和 action 关联在一起
    userInfo: UserReducer(state.userInfo, action),

    ///通过 ThemeDataReducer 将 APPState 内的 themeData 和 action 关联在一起
    themeData: ThemeDataReducer(state.themeData, action),

    ///通过 LocaleReducer 将 APPState 内的 locale 和 action 关联在一起
    locale: LocaleReducer(state.locale, action),
  );
}



final List<Middleware<APPState>> middleware = [
  EpicMiddleware<APPState>(UserInfoEpic()),
  UserInfoMiddleware(),
];