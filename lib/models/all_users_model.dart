class AllUserModel {
  bool? status;
  List<AllUsersData>? data;

  AllUserModel({this.status, this.data});

  AllUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AllUsersData>[];
      json['data'].forEach((v) {
        data!.add(new AllUsersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllUsersData {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? role;
  String? status;
  String? phone;
  String? createdDate;
  int? iV;
  String? company;
  String? region;
  String? area;
  String? fcmToken;

  AllUsersData(
      {this.sId,
        this.name,
        this.email,
        this.password,
        this.role,
        this.status,
        this.phone,
        this.createdDate,
        this.iV,
        this.company,
        this.region,
        this.area,
        this.fcmToken});

  AllUsersData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    status = json['status'];
    phone = json['phone'];
    createdDate = json['createdDate'];
    iV = json['__v'];
    company = json['company'];
    region = json['region'];
    area = json['area'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['createdDate'] = this.createdDate;
    data['__v'] = this.iV;
    data['company'] = this.company;
    data['region'] = this.region;
    data['area'] = this.area;
    data['fcmToken'] = this.fcmToken;
    return data;
  }
}
