import 'package:leadmanagementsystem/models/new_project_model.dart';

class GetProjectByUserIdModel {
  bool? status;
  List<ProjectData>? projectData;

  GetProjectByUserIdModel({this.status, this.projectData});

  GetProjectByUserIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['projectData'] != null) {
      projectData = <ProjectData>[];
      json['projectData'].forEach((v) {
        projectData!.add(new ProjectData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.projectData != null) {
      data['projectData'] = this.projectData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
