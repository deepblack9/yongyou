import 'package:flutter/material.dart';
import 'package:yongyou/common/style/app_style.dart';

/**
 * Card Widget
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class APPCardItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final Color color;
  final RoundedRectangleBorder shape;
  final double elevation;


  APPCardItem({@required this.child, this.margin, this.color, this.shape, this.elevation = 5.0});

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    RoundedRectangleBorder shape = this.shape;
    Color color = this.color;
    margin ??= EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0);
    shape ??= new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)));
    color ??= new Color(APPColors.cardWhite);
    return new Card(elevation: elevation, shape: shape, color: color, margin: margin, child: child);
  }
}
