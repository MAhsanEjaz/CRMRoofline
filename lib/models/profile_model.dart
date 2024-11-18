class ProfileModel {
  bool? status;
  ProfileData? data;

  ProfileModel({this.status, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? sId;
  String? name;
  String? fcmToken;
  String? email;
  String? password;
  String? role;
  String? status;
  String? phone;
  String? createdDate;
  int? iV;

  ProfileData(
      {this.sId,
        this.name,
        this.fcmToken,
        this.email,
        this.password,
        this.role,
        this.status,
        this.phone,
        this.createdDate,
        this.iV});

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    fcmToken = json['fcmToken'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    status = json['status'];
    phone = json['phone'];
    createdDate = json['createdDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['fcmToken'] = this.fcmToken;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['createdDate'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}
