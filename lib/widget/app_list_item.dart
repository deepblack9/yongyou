import 'package:flutter/material.dart';
import 'package:yongyou/common/style/app_style.dart';

/**
 * Form Item Widget
 * Created by wangdecheng
 * Date: 2019-07-1
 */
class APPListItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final Color color;
  final RoundedRectangleBorder shape;
  final double elevation;
  final IconData leftIcon;
  final VoidCallback onPressed;


  APPListItem({@required this.child, this.onPressed, this.leftIcon,
    this.margin, this.color, this.shape, this.elevation = 5.0});

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin;
    RoundedRectangleBorder shape = this.shape;
    Color color = this.color;
    margin ??= EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0, bottom: 5.0);
    shape ??= new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)));
    color ??= new Color(APPColors.cardWhite);
    return new Card(
      elevation: elevation,
      shape: shape,
      color: color,
      margin: margin,
      child: new RawMaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(15.0),
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: child
      ),
    );
  }
}
