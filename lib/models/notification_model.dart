class NotificationModel {
  bool? status;
  List<NotificationData>? data;

  NotificationModel({this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? sId;
  String? senderId;
  String? projectId;
  String? semderFcmToken;
  String? recieverId;
  String? comment;
  String? createdDate;
  int? iV;
  String? senderName;
  String? recieverName;

  NotificationData(
      {this.sId,
      this.senderId,
      this.projectId,
      this.recieverId,
      this.semderFcmToken,
      this.createdDate,
      this.comment,
      this.recieverName,
      this.iV,
      this.senderName});

  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'];
    projectId = json['projectId'];
    recieverId = json['recieverId'];
    recieverName = json['recieverName'];
    createdDate = json['createdDate'];
    semderFcmToken = json['semderFcmToken'];
    comment = json['comment'];
    iV = json['__v'];
    senderName = json['senderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['senderId'] = senderId;
    data['projectId'] = projectId;
    data['recieverId'] = recieverId;
    data['createdDate'] = createdDate;
    data['semderFcmToken'] = semderFcmToken;
    data['recieverName'] = recieverName;
    data['comment'] = comment;
    data['__v'] = iV;
    data['senderName'] = senderName;
    return data;
  }
}
