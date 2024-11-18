class LoginModel {
  bool? status;
  String? message;
  String? token;
  UserData? userData;

  LoginModel({this.status, this.message, this.token, this.userData});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? role;
  String? status;
  String? company;
  String? fcmToken;
  String? region;
  String? createdDate;
  int? iV;

  UserData(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.role,
        this.status,
        this.fcmToken,
        this.company,
        this.region,
        this.createdDate,
        this.iV});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    fcmToken = json['fcmToken'];
    role = json['role'];
    status = json['status'];
    company = json['company'];
    region = json['region'];
    createdDate = json['createdDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['fcmToken'] = this.fcmToken;
    data['role'] = this.role;
    data['status'] = this.status;
    data['company'] = this.company;
    data['region'] = this.region;
    data['createdDate'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}
