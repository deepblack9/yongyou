import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:yongyou/common/model/Sales.dart';
import 'package:yongyou/common/redux/app_state.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:yongyou/common/utils/common_utils.dart';
import 'package:yongyou/widget/app_card_item.dart';

class NewSalesPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NewSalesPage> {
  final _formKey = GlobalKey<FormState>();

  String	businessType; /// 业务类型
  String	typeCode; /// 销售类型编码
  String	custCode;	/// 客户编码
  String	deptCode;	/// 部门编码
  String	inventoryCode;	/// 存货编码
  int     quantity; /// 数量
  int	    bgift;	/// 是否赠品(0=非赠品;1=赠品)
  int	    rowno;	/// 行号

  var value;
  FocusNode _focusNode = FocusNode();

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

  _renderItem(
      IconData leftIcon, String title, String value, VoidCallback onPressed) {
    return new APPCardItem(
      child: new RawMaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(15.0),
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: new Row(
          children: <Widget>[
            new Icon(leftIcon),
            new Container(
              width: 10.0,
            ),
            new Text(title, style: APPConstant.normalSubText),
            new Container(
              width: 10.0,
            ),
            new Expanded(child: new Text(value, style: APPConstant.normalText)),
            new Container(
              width: 10.0,
            ),
            new Icon(APPICons.REPOS_ITEM_NEXT, size: 12.0),
          ],
        ),
      ),
    );
  }

  List<Widget> _renderList(Sales salesInfo, Store store) {
    return [
      _renderItem(Icons.info, CommonUtils.getLocale(context).businessType,
          "", () {
            shwoSelectModal();
          }),
      _renderItem(
          Icons.email,
          CommonUtils.getLocale(context).typeCode,
          "", () {
//        _showEditDialog(CommonUtils.getLocale(context).user_profile_email,
//            userInfo.email, "email", store);
      }),
      _renderItem(Icons.link, CommonUtils.getLocale(context).custCode,
          "", () {
//            _showEditDialog(CommonUtils.getLocale(context).user_profile_link,
//                userInfo.blog, "blog", store);
          }),
      _renderItem(Icons.group, CommonUtils.getLocale(context).deptCode,
          "", () {
//            _showEditDialog(CommonUtils.getLocale(context).user_profile_org,
//                userInfo.company, "company", store);
          }),
      _renderItem(
          Icons.location_on,
          CommonUtils.getLocale(context).inventoryCode,
          "", () {
//        _showEditDialog(CommonUtils.getLocale(context).user_profile_location,
//            userInfo.location, "location", store);
      }),
      _renderItem(
          Icons.message,
          CommonUtils.getLocale(context).quantity,
          "", () {
//        _showEditDialog(CommonUtils.getLocale(context).user_profile_info,
//            userInfo.bio, "bio", store);
      }),
      _renderItem(
          Icons.message,
          CommonUtils.getLocale(context).bgift,
          "", () {
//        _showEditDialog(CommonUtils.getLocale(context).user_profile_info,
//            userInfo.bio, "bio", store);
      }),
      _renderItem(
          Icons.message,
          CommonUtils.getLocale(context).rowno,
          "", () {
//        _showEditDialog(CommonUtils.getLocale(context).user_profile_info,
//            userInfo.bio, "bio", store);
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
                Navigator.pop(context);
              },
            ),
            new ListTile(
              leading: new Icon(Icons.photo_library),
              title: new Text("Gallery"),
              onTap: () async {
                // imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
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
                if (_formKey.currentState.validate()) {
                  // Process data.
                }
              },
            ),
          ],
        ),
        body: new Container(
          color: Color(APPColors.white),
          child: new SingleChildScrollView(
            child: new Column(
              children: _renderList(null, store),
            ),
          ),
        ),
      );
    });
  }
  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
      child:new Text('1'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
      child:new Text('2'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
      child:new Text('3'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
      child:new Text('4'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5=new DropdownMenuItem(
      child:new Text('5'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6=new DropdownMenuItem(
      child:new Text('6'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7=new DropdownMenuItem(
      child:new Text('7'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8=new DropdownMenuItem(
      child:new Text('8'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9=new DropdownMenuItem(
      child:new Text('9'),
      value: '9',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10=new DropdownMenuItem(
      child:new Text('10'),
      value: '10',
    );
    items.add(dropdownMenuItem10);
    return items;
  }

//  @override
//  requestRefresh() async {
//    return await _getDataLogic(this.searchText);
//  }
}
