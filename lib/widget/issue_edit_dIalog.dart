import 'package:flutter/material.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:yongyou/common/utils/common_utils.dart';
import 'package:yongyou/widget/app_card_item.dart';
import 'package:yongyou/widget/app_input_widget.dart';

/**
 * issue 编辑输入框
 * Created by guoshuyu
 * on 2018/7/21.
 */
class IssueEditDialog extends StatefulWidget {
  final String dialogTitle;

  final ValueChanged<String> onTitleChanged;

  final ValueChanged<String> onContentChanged;

  final VoidCallback onPressed;

  final TextEditingController titleController;

  final TextEditingController valueController;

  final bool needTitle;

  IssueEditDialog(this.dialogTitle, this.onTitleChanged, this.onContentChanged, this.onPressed,
      {this.titleController, this.valueController, this.needTitle = true});

  @override
  _IssueEditDialogState createState() => _IssueEditDialogState();
}

class _IssueEditDialogState extends State<IssueEditDialog> {
  _IssueEditDialogState();

  ///标题输入框
  renderTitleInput() {
    return (widget.needTitle)
        ? new Padding(
            padding: new EdgeInsets.all(5.0),
            child: new APPInputWidget(
              onChanged: widget.onTitleChanged,
              controller: widget.titleController,
              hintText: CommonUtils.getLocale(context).issue_edit_issue_title_tip,
              obscureText: false,
            ))
        : new Container();
  }

  ///快速输入框
  _renderFastInputContainer() {
    ///因为是Column下包含了ListView，所以需要设置高度
    return new Container(
      height: 30.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return new RawMaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
              constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
              child: Icon(FAST_INPUT_LIST[index].iconData, size: 16.0),
              onPressed: () {
                String text = FAST_INPUT_LIST[index].content;
                String newText = "";
                if (widget.valueController.value != null) {
                  newText = widget.valueController.value.text;
                }
                newText = newText + text;
                setState(() {
                  widget.valueController.value = new TextEditingValue(text: newText);
                });
                widget.onContentChanged?.call(newText);
              });
        },
        itemCount: FAST_INPUT_LIST.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
              ///触摸收起键盘
              child: new GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: new Center(
                  child: new APPCardItem(
                    margin: EdgeInsets.only(left: 50.0, right: 50.0),
                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: new Padding(
                      padding: new EdgeInsets.all(12.0),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ///dialog标题
                          new Padding(
                              padding: new EdgeInsets.only(top: 5.0, bottom: 15.0),
                              child: new Center(
                                child: new Text(widget.dialogTitle, style: APPConstant.normalTextBold),
                              )),

                          ///标题输入框
                          renderTitleInput(),

                          ///内容输入框
                          new Container(
                            height: MediaQuery.of(context).size.width * 3 / 4,
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              color: Color(APPColors.white),
                              border: new Border.all(color: Color(APPColors.subTextColor), width: .3),
                            ),
                            padding: new EdgeInsets.only(left: 20.0, top: 12.0, right: 20.0, bottom: 12.0),
                            child: new Column(
                              children: <Widget>[
                                new Expanded(
                                  child: new TextField(
                                    autofocus: false,
                                    maxLines: 999,
                                    onChanged: widget.onContentChanged,
                                    controller: widget.valueController,
                                    decoration: new InputDecoration.collapsed(
                                      hintText: CommonUtils.getLocale(context).issue_edit_issue_title_tip,
                                      hintStyle: APPConstant.middleSubText,
                                    ),
                                    style: APPConstant.middleText,
                                  ),
                                ),

                                ///快速输入框
                                _renderFastInputContainer(),
                              ],
                            ),
                          ),
                          new Container(height: 10.0),
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ///取消
                              new Expanded(
                                  child: new RawMaterialButton(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      padding: EdgeInsets.all(4.0),
                                      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                                      child: new Text(CommonUtils.getLocale(context).app_cancel, style: APPConstant.normalSubText),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })),
                              new Container(width: 0.3, height: 25.0, color: Color(APPColors.subTextColor)),

                              ///确定
                              new Expanded(
                                  child: new RawMaterialButton(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      padding: EdgeInsets.all(4.0),
                                      constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                                      child: new Text(CommonUtils.getLocale(context).app_ok, style: APPConstant.normalTextBold),
                                      onPressed: widget.onPressed)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

var FAST_INPUT_LIST = [
  FastInputIconModel(APPICons.ISSUE_EDIT_H1, "\n# "),
  FastInputIconModel(APPICons.ISSUE_EDIT_H2, "\n## "),
  FastInputIconModel(APPICons.ISSUE_EDIT_H3, "\n### "),
  FastInputIconModel(APPICons.ISSUE_EDIT_BOLD, "****"),
  FastInputIconModel(APPICons.ISSUE_EDIT_ITALIC, "__"),
  FastInputIconModel(APPICons.ISSUE_EDIT_QUOTE, "` `"),
  FastInputIconModel(APPICons.ISSUE_EDIT_CODE, " \n``` \n\n``` \n"),
  FastInputIconModel(APPICons.ISSUE_EDIT_LINK, "[](url)"),
];

class FastInputIconModel {
  final IconData iconData;
  final String content;

  FastInputIconModel(this.iconData, this.content);
}
