class AssignProjectModel {
  bool? status;
  ProjectAssign? data;

  AssignProjectModel({this.status, this.data});

  AssignProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? ProjectAssign.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProjectAssign {
  String? sId;
  String? projectId;
  int? iV;
  String? recieverName;
  String? reciverUserId;
  String? senderName;
  String? senderUserId;
  bool? assignStatus;

  ProjectAssign(
      {this.sId,
        this.projectId,
        this.iV,
        this.recieverName,
        this.reciverUserId,
        this.senderName,
        this.senderUserId,
        this.assignStatus});

  ProjectAssign.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    projectId = json['projectId'];
    iV = json['__v'];
    recieverName = json['recieverName'];
    reciverUserId = json['reciverUserId'];
    senderName = json['senderName'];
    senderUserId = json['senderUserId'];
    assignStatus = json['assignStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['projectId'] = projectId;
    data['__v'] = iV;
    data['recieverName'] = recieverName;
    data['reciverUserId'] = reciverUserId;
    data['senderName'] = senderName;
    data['senderUserId'] = senderUserId;
    data['assignStatus'] = assignStatus;
    return data;
  }
}
