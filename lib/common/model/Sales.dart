import 'package:json_annotation/json_annotation.dart';

/**
 * Created by wangdecheng
 * Date: 2019-06-30
 */

part 'package:yongyou/common/model/Sales.g.dart';

@JsonSerializable()
class Sales {
  String id;
  String	businessType; /// 业务类型
  String	typeCode; /// 销售类型编码
  String	custCode;	/// 客户编码
  String	deptCode;	/// 部门编码
  String	inventoryCode;	/// 存货编码
  int     quantity; /// 数量
  int	    bgift;	/// 是否赠品(0=非赠品;1=赠品)
  int	    rowno;	/// 行号

  Sales(this.id, this.businessType, this.typeCode, this.custCode, this.deptCode, this.inventoryCode, this.quantity, this.bgift, this.rowno);

  factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);

  Map<String, dynamic> toJson() => _$SalesToJson(this);

  // 命名构造函数
  Sales.empty();
}
