import 'package:flutter/material.dart';
import 'package:yongyou/common/bean/SelectedItemBean.dart';
import 'package:yongyou/common/style/app_style.dart';
import 'package:yongyou/widget/app_card_item.dart';
import 'package:yongyou/widget/app_flex_button.dart';
import 'package:yongyou/widget/app_list_item.dart';
import 'package:yongyou/widget/app_search_input_widget.dart';

class InventoryListPage extends StatefulWidget {
  static final String sName = "inventoryList";

  @override
  _State createState() => _State();
}

class _State extends State<InventoryListPage> {
  List<SelectedItemBean> headerList = [];


  @override
  void initState() {
    headerList.add(new SelectedItemBean('1', "存货1"));
    headerList.add(new SelectedItemBean('2', "存货2"));
    headerList.add(new SelectedItemBean('3', "存货3"));
    headerList.add(new SelectedItemBean('4', "存货4"));
    headerList.add(new SelectedItemBean('5', "存货5"));
    headerList.add(new SelectedItemBean('6', "存货6"));
  }

  @override
  Widget build(BuildContext context) {
    /// 企业信息
    Widget buildComponyRow(SelectedItemBean item) {
      return new APPListItem(
        child: ExpansionTile(
//            key: new PageStorageKey<Entry>(root),
          title: new Text(item.value),
          children: [
            RaisedButton(
              onPressed: () { Navigator.pop(context, item); },
              child: const Text(
                  '选择',
                  style: TextStyle(fontSize: 20)
              ),
            ),
            new Image.network('http://pic-bucket.ws.126.net/photo/0001/2019-07-02/EJ2QQ22300AO0001NOS.jpg'),
          ]
        ),
      );
    }

    _onChanged() {

    }
    _onSubmitted() {

    }
    _onSubmitPressed() {

    }

    return Scaffold(
      appBar: AppBar(
        title: Text("选择存货"),
//        actions: <Widget>[
//          new IconButton( // action button
//            icon: new Icon(Icons.search),
//            onPressed: () async {
//
//            },
//          ),
//        ],
      ),
      body: Column(
        children: <Widget>[
          APPSearchInputWidget(_onChanged(), _onSubmitted(), _onSubmitPressed()),
          Expanded(
            child: Container(
              child: new ListView.builder(
//        scrollDirection: Axis.horizontal,
                itemCount: headerList.length,
                itemBuilder: (context, index) {
                  return buildComponyRow(headerList[index]);
//                  return new APPCardItem(
//                    margin: EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
//                    child: buildComponyRow('${headerList[index]}'),
//                  );
                },
              ),
            ),
          )
        ],
      )
//      Column(
//        children: <Widget>[
//          Expanded(
//            child: FittedBox(
//              fit: BoxFit.contain, // otherwise the logo will be tiny
//              child: Container(
//                margin: new EdgeInsets.only(left: 3.0, right: 3.0),
//                child: new ListView.builder(
////        scrollDirection: Axis.horizontal,
//                  itemCount: headerList.length,
//                  itemBuilder: (context, index) {
//                    return new Container(
//                        padding: const EdgeInsets.all(5.0),
//                        child: Card(
//                          elevation: 15.0, //设置阴影
//                          child: buildComponyRow('${headerList[index]}'),
//                        )
//                    );
//                  },
//                ),
//              ),
//            ),
//          ),
//        ],
//      )
    );
  }
}
