import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yongyou/common/style/app_string_base.dart';
import 'package:yongyou/common/style/app_string_en.dart';
import 'package:yongyou/common/style/app_string_zh.dart';

///自定义多语言实现
class APPLocalizations {
  final Locale locale;

  APPLocalizations(this.locale);

  ///根据不同 locale.languageCode 加载不同语言对应
  ///APPStringEn和APPStringZh都继承了APPStringBase
  static Map<String, APPStringBase> _localizedValues = {
    'en': new APPStringEn(),
    'zh': new APPStringZh(),
  };

  APPStringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  ///通过 Localizations 加载当前的 APPLocalizations
  ///获取对应的 APPStringBase
  static APPLocalizations of(BuildContext context) {
    return Localizations.of(context, APPLocalizations);
  }
}
