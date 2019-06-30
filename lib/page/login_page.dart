import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yongyou/common/config/config.dart';
import 'package:yongyou/common/dao/user_dao.dart';
import 'package:yongyou/common/local/local_storage.dart';
import 'package:yongyou/common/redux/app_state.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:yongyou/common/utils/common_utils.dart';
import 'package:yongyou/common/utils/navigator_utils.dart';
import 'package:yongyou/widget/app_flex_button.dart';
import 'package:yongyou/widget/app_input_widget.dart';

/**
 * 登录页
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var _userName = "";

  var _password = "";

  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  _LoginPageState() : super();

  @override
  void initState() {
    super.initState();
    initParams();
  }

  initParams() async {
    _userName = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  @override
  Widget build(BuildContext context) {
    ///共享 store
    return new StoreBuilder<APPState>(builder: (context, store) {
      /// 触摸收起键盘
      return new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: new Container(
            color: Theme.of(context).primaryColor,
            child: new Center(
              ///防止overFlow的现象
              child: SafeArea(
                ///同时弹出键盘不遮挡
                child: SingleChildScrollView(
                  child: new Card(
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: Color(APPColors.cardWhite),
                    margin: const EdgeInsets.only(left:30.0, right: 30.0),
                    child: new Padding(
                      padding: new EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0, bottom: 0.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Image(image: new AssetImage(APPICons.DEFAULT_USER_ICON), width: 90.0, height: 90.0),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new APPInputWidget(
                            hintText: CommonUtils.getLocale(context).login_username_hint_text,
                            iconData: APPICons.LOGIN_USER,
                            onChanged: (String value) {
                              _userName = value;
                            },
                            controller: userController,
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new APPInputWidget(
                            hintText: CommonUtils.getLocale(context).login_password_hint_text,
                            iconData: APPICons.LOGIN_PW,
                            obscureText: true,
                            onChanged: (String value) {
                              _password = value;
                            },
                            controller: pwController,
                          ),
                          new Padding(padding: new EdgeInsets.all(30.0)),
                          new APPFlexButton(
                            text: CommonUtils.getLocale(context).login_text,
                            color: Theme.of(context).primaryColor,
                            textColor: Color(APPColors.textWhite),
                            onPress: () {
//                              if (_userName == null || _userName.length == 0) {
//                                return;
//                              }
//                              if (_password == null || _password.length == 0) {
//                                return;
//                              }
//                              CommonUtils.showLoadingDialog(context);

                              Navigator.pop(context);
                              NavigatorUtils.goHome(context);

//                              new Future.delayed(const Duration(seconds: 1), () {
//                                NavigatorUtils.goHome(context);
//                                return true;
//                              });

                              UserDao.login(_userName.trim(), _password.trim(), store).then((res) {
                                Navigator.pop(context);
                                if (res != null && res.result) {
                                  new Future.delayed(const Duration(milliseconds: 100), () {
                                    NavigatorUtils.goHome(context);
                                    return true;
                                  });
                                }
                              });
                            },
                          ),
                          new Padding(padding: new EdgeInsets.all(30.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
