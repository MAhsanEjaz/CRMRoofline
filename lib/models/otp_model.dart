class OtpModel {
  bool? status;
  String? message;
  int? otp;

  OtpModel({this.status, this.message, this.otp});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}
