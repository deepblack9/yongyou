import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yongyou/common/ab/sql_manager.dart';
import 'package:yongyou/common/config/config.dart';
import 'package:yongyou/common/dao/user_dao.dart';
import 'package:yongyou/common/local/local_storage.dart';
import 'package:yongyou/common/localization/default_localizations.dart';
import 'package:yongyou/common/model/User.dart';
import 'package:yongyou/common/redux/app_state.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:yongyou/common/utils/common_utils.dart';
import 'package:yongyou/common/utils/navigator_utils.dart';
import 'package:yongyou/widget/app_flex_button.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

/**
 * 主页drawer
 * Created by guoshuyu
 * Date: 2018-07-18
 */
class HomeDrawer extends StatelessWidget {
  showAboutDialog(BuildContext context, String versionName) {
    versionName ??= "Null";
    NavigatorUtils.showAPPDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
              applicationName: CommonUtils.getLocale(context).app_name,
              applicationVersion: CommonUtils.getLocale(context).app_version + ": " + versionName,
              applicationIcon: new Image(image: new AssetImage(APPICons.DEFAULT_USER_ICON), width: 50.0, height: 50.0),
              applicationLegalese: "http://github.com/CarGuo",
            ));
  }

  showThemeDialog(BuildContext context, Store store) {
    List<String> list = [
      CommonUtils.getLocale(context).home_theme_default,
      CommonUtils.getLocale(context).home_theme_1,
      CommonUtils.getLocale(context).home_theme_2,
      CommonUtils.getLocale(context).home_theme_3,
      CommonUtils.getLocale(context).home_theme_4,
      CommonUtils.getLocale(context).home_theme_5,
      CommonUtils.getLocale(context).home_theme_6,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.pushTheme(store, index);
      LocalStorage.save(Config.THEME_COLOR, index.toString());
    }, colorList: CommonUtils.getThemeListColor());
  }

  showLanguageDialog(BuildContext context, Store store) {
    List<String> list = [
      CommonUtils.getLocale(context).home_language_default,
      CommonUtils.getLocale(context).home_language_zh,
      CommonUtils.getLocale(context).home_language_en,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.changeLocale(store, index);
      LocalStorage.save(Config.LOCALE, index.toString());
    }, height: 150.0);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new StoreBuilder<APPState>(
        builder: (context, store) {
          User user = store.state.userInfo;
          return new Drawer(
            ///侧边栏按钮Drawer
            child: new Container(
              ///默认背景
              color: store.state.themeData.primaryColor,
              child: new SingleChildScrollView(
                ///item 背景
                child: Container(
                  constraints: new BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: new Material(
                    color: Color(APPColors.white),
                    child: new Column(
                      children: <Widget>[
                        new UserAccountsDrawerHeader(
                          //Material内置控件
                          accountName: new Text(
                            user.login ?? "---",
                            style: APPConstant.largeTextWhite,
                          ),
                          accountEmail: new Text(
                            user.email ?? user.name ?? "---",
                            style: APPConstant.normalTextLight,
                          ),
                          //用户名
                          //用户邮箱
                          currentAccountPicture: new GestureDetector(
                            //用户头像
                            onTap: () {},
                            child: new CircleAvatar(
                              //圆形图标控件
                              backgroundImage: new NetworkImage(user.avatar_url ?? APPICons.DEFAULT_USER_ICON),
                            ),
                          ),
                          decoration: new BoxDecoration(
                            //用一个BoxDecoration装饰器提供背景图片
                            color: store.state.themeData.primaryColor,
                          ),
                        ),
                        new ListTile(
                            title: new Hero(
                                tag: "home_user_info",
                                child: new Material(
                                    color: Colors.transparent,
                                    child: new Text(
                                      CommonUtils.getLocale(context).home_user_info,
                                      style: APPConstant.normalTextBold,
                                    ))),
                            onTap: () {
//                              NavigatorUtils.gotoUserProfileInfo(context);
                            }),
                        new ListTile(
                            title: new Text(
                              CommonUtils.getLocale(context).home_change_theme,
                              style: APPConstant.normalText,
                            ),
                            onTap: () {
                              showThemeDialog(context, store);
                            }),
                        new ListTile(
                            title: new Text(
                              APPLocalizations.of(context).currentLocalized.home_about,
                              style: APPConstant.normalText,
                            ),
                            onTap: () {
                              PackageInfo.fromPlatform().then((value) {
                                print(value);
                                showAboutDialog(context, value.version);
                              });
                            }),
                        new ListTile(
                            title: new APPFlexButton(
                              text: CommonUtils.getLocale(context).Login_out,
                              color: Colors.redAccent,
                              textColor: Color(APPColors.textWhite),
                              onPress: () {
                                UserDao.clearAll(store);
                                SqlManager.close();
//                                NavigatorUtils.goLogin(context);
                                new Future.delayed(const Duration(milliseconds: 100), () {
                                  NavigatorUtils.goLogin(context);
                                  return true;
                                });
                              },
                            ),
                            onTap: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
