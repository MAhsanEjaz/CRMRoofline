import 'package:leadmanagementsystem/models/new_project_model.dart';

class ProjectUpdateModel {
  bool? status;
  ProjectData? updateProjectData;

  ProjectUpdateModel({this.status, this.updateProjectData});

  ProjectUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    updateProjectData = json['projectData'] != null
        ? ProjectData.fromJson(json[
            'projectData']) // Fixed: changed `projectData.fromJson` to `ProjectData.fromJson`
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.updateProjectData != null) {
      data['projectData'] = this.updateProjectData!.toJson();
    }
    return data;
  }
}
