import 'package:flutter/material.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:yongyou/common/utils/common_utils.dart';

/**
 * 搜索输入框
 * Created by guoshuyu
 * Date: 2018-07-20
 */
class APPSearchInputWidget extends StatelessWidget {
  ValueChanged<String> onChanged;

  ValueChanged<String> onSubmitted;

  VoidCallback onSubmitPressed;

  APPSearchInputWidget(this.onChanged, this.onSubmitted, this.onSubmitPressed);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: kToolbarHeight,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(0.0), bottomLeft: Radius.circular(0.0)),
          color:  Color(APPColors.white),
          border: new Border.all(color: Theme.of(context).primaryColor, width: 0.3),
          boxShadow: [BoxShadow(color: Theme.of(context).primaryColorDark,  blurRadius: 4.0)]),
      padding: new EdgeInsets.only(left: 20.0, top: 12.0, right: 20.0, bottom: 12.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new TextField(
                  autofocus: false,
                  decoration: new InputDecoration.collapsed(
                    hintText: CommonUtils.getLocale(context).repos_issue_search,
                    hintStyle: APPConstant.middleSubText,
                  ),
                  style: APPConstant.middleText,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted)),
          new RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.only(right: 5.0, left: 10.0),
              constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              child: new Icon(APPICons.SEARCH, size: 15.0, color: Theme.of(context).primaryColorDark,),
              onPressed: onSubmitPressed)
        ],
      ),
    );
  }
}