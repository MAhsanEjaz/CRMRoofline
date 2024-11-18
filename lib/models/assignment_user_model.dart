class AssingmentUserModel {
  bool? status;
  List<AssignmentData>? data;

  AssingmentUserModel({this.status, this.data});

  AssingmentUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AssignmentData>[];
      json['data'].forEach((v) {
        data!.add(new AssignmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssignmentData {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? role;
  String? fcmToken;
  String? status;
  String? company;
  String? region;
  String? createdDate;
  int? iV;

  AssignmentData(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.fcmToken,
      this.role,
      this.status,
      this.company,
      this.region,
      this.createdDate,
      this.iV});

  AssignmentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    fcmToken = json['fcmToken'];
    password = json['password'];
    role = json['role'];
    status = json['status'];
    company = json['company'];
    region = json['region'];
    createdDate = json['createdDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['fcmToken'] = fcmToken;
    data['status'] = status;
    data['company'] = company;
    data['region'] = region;
    data['createdDate'] = createdDate;
    data['__v'] = iV;
    return data;
  }
}
