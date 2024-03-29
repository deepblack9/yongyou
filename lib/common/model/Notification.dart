import 'package:yongyou/common/model/NotificationSubject.dart';
//import 'package:yongyou/model/Repository.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by guoshuyu
 * Date: 2018-07-31
 */

part 'package:yongyou/common/model/Notification.g.dart';

@JsonSerializable()
class Notification {
  String id;
  bool unread;
  String reason;
  @JsonKey(name: "updated_at")
  DateTime updateAt;
  @JsonKey(name: "last_read_at")
  DateTime lastReadAt;
//  Repository repository;
  NotificationSubject subject;

//  Notification(this.id, this.unread, this.reason, this.updateAt, this.lastReadAt, this.repository, this.subject);
  Notification(this.id, this.unread, this.reason, this.updateAt, this.lastReadAt, this.subject);

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
