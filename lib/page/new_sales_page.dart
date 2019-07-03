import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:yongyou/common/bean/SelectedItemBean.dart';
import 'package:yongyou/common/config/config.dart';
import 'package:yongyou/common/local/local_storage.dart';
import 'package:yongyou/common/model/Sales.dart';
import 'package:yongyou/common/redux/app_state.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:yongyou/common/utils/common_utils.dart';
import 'package:yongyou/common/utils/navigator_utils.dart';
import 'package:yongyou/widget/app_card_item.dart';
import 'package:yongyou/widget/app_form_item.dart';
import 'package:yongyou/widget/tree/bean/organ.dart';

import 'inventory_list_page.dart';

class NewSalesPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NewSalesPage> {
  final _formKey = GlobalKey<FormState>();

  SelectedItemBean _businessType = new SelectedItemBean('', '');// 业务类型
//  String	_businessType = ''; /// 业务类型
  SelectedItemBean _type = new SelectedItemBean('', '');// 销售类型
//  String	_typeCode = ''; /// 销售类型编码
  SelectedItemBean _cust = new SelectedItemBean('', '');// 客户
//  String	_custCode = '';	/// 客户编码
  SelectedItemBean _dept = new SelectedItemBean('', '');// 部门
//  String	_deptCode = '';	// 部门编码
  SelectedItemBean _inventory = new SelectedItemBean('', '');// 存货
//  String	_inventoryCode = '';	// 存货编码
  int     _quantity = 0; // 数量
//  int	    _bgift = 0;	// 是否赠品(0=非赠品;1=赠品)
  SelectedItemBean _bgift = new SelectedItemBean('非赠品', '0');// 是否赠品(0=非赠品;1=赠品)
  int	    _rowno = 1;	// 行号

  var value;
  FocusNode _focusNode = FocusNode();

  List<SelectedItemBean> _typeList = [
    new SelectedItemBean('title1', 'value1'),
    new SelectedItemBean('title2', 'value2'),
    new SelectedItemBean('title3', 'value3'),
    new SelectedItemBean('title4', 'value4'),
    new SelectedItemBean('title5', 'value5'),
    new SelectedItemBean('title6', 'value6'),
    new SelectedItemBean('title7', 'value7'),
    new SelectedItemBean('title8', 'value8'),
    new SelectedItemBean('title9', 'value9'),
    new SelectedItemBean('title10', 'value10'),
  ];

  List<Member> memberList = [
    new Member('title1', 'value1'),
    new Member('title2', 'value2'),
    new Member('title3', 'value3'),
    new Member('title4', 'value4'),
    new Member('title5', 'value5'),
  ];

  List<Organ> subTreeList = [
    new Organ(null, [
      new Member('title1', 'value1'),
      new Member('title2', 'value2'),
      new Member('title3', 'value3'),
      new Member('title4', 'value4'),
      new Member('title5', 'value5'),
    ], "node11")
  ];
  List<Organ> treeList = [
    new Organ([
      new Organ(null, [
        new Member('title1', 'value1'),
        new Member('title2', 'value2'),
        new Member('title3', 'value3'),
        new Member('title4', 'value4'),
        new Member('title5', 'value5'),
      ], "node11")
    ], [
      new Member('title1', 'value1'),
      new Member('title2', 'value2'),
      new Member('title3', 'value3'),
      new Member('title4', 'value4'),
      new Member('title5', 'value5'),
    ], "node1")
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // TextField has lost focus
//        _showMessage();
      }
    });
  }

  List<Widget> _renderList() {
    return [
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).businessType,
          value: _businessType.title, onPressed: () {
            CommonUtils.showSelectOptionDialog(context, _typeList, (index) {
              setState(() { _businessType.title = _typeList[index].title; _businessType.value = _typeList[index].value; });
            });
          }),
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).typeCode,
          value: _type.title, onPressed: () {
            CommonUtils.showSelectOptionDialog(context, _typeList, (index) {
              setState(() { _type.title = _typeList[index].title; _type.value = _typeList[index].value; });
            });
          }),
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).custCode,
          value: _cust.title, onPressed: () {
            CommonUtils.showSelectOptionDialog(context, _typeList, (index) {
              setState(() { _cust.title = _typeList[index].title; _cust.value = _typeList[index].value; });
            });
          }),
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).deptCode,
          value: _dept.title, onPressed: () {
            CommonUtils.showTreeOptionDialog(context, treeList, (member) {
              setState(() { _dept.title = member.name; _cust.value = member.value; });
            });
          }),
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).inventoryCode,
          value: _inventory.title, onPressed: () {
            NavigatorUtils.goInventoryList(context).then((inventory) {
              setState(() {
                _inventory.title = inventory.title; _inventory.value = inventory.value;
              });
            });
          }),
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).quantity, value: '$_quantity',
          child: new TextField(
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 5.0, top: 0.0, right: 5.0, bottom: 0.0),
            ),
          ),
          onPressed: () {
//            shwoSelectModal();
          }),
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).bgift,
          value: _bgift.title, onPressed: () {
            shwoSelectModal();
          }),
      new APPFormItem(leftIcon: Icons.info, title: CommonUtils.getLocale(context).rowno,
          value: '$_rowno', onPressed: () {
            shwoSelectModal();
          }),
    ];
  }

  Future<BottomSheet> shwoSelectModal() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.photo_camera),
              title: new Text("Camera"),
              onTap: () async {
                // imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                setState(() { _businessType.title = 'Camera'; _businessType.value = '0'; });
                Navigator.pop(context);
              },
            ),
            new ListTile(
              leading: new Icon(Icons.photo_library),
              title: new Text("Gallery"),
              onTap: () async {
                // imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() { _businessType.title = 'Gallery'; _businessType.value = '1'; });
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<APPState>(builder: (context, store) {
      return Scaffold(
        appBar: AppBar(
          title: Text("新建销售订单"),
          actions: <Widget>[
            new IconButton( // action button
              icon: new Icon(Icons.save),
              onPressed: () async {
                Navigator.pop(context);
//                if (_formKey.currentState.validate()) {
//                  // Process data.
//                }
              },
            ),
          ],
        ),
        body: new Container(
          color: Color(APPColors.white),
          child: new SingleChildScrollView(
            child: new Column(
              children: _renderList(),
            ),
          ),
        ),
      );
    });
  }

//  @override
//  requestRefresh() async {
//    return await _getDataLogic(this.searchText);
//  }
}
