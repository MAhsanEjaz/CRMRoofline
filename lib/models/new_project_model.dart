class ProjectModel {
  bool? status;
  List<ProjectData>? projectData;

  ProjectModel({this.status, this.projectData});

  ProjectModel.fromJson(Map<String, dynamic> json) {
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
    data['status'] = status;
    if (projectData != null) {
      data['projectData'] = projectData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectData {
  String? sId;
  String? userId;
  String? name;
  String? departmentRe;
  String? departmentMe;
  String? consultName;
  String? consultPhone;
  String? ownerMe;
  String? ownerName;
  String? ownerContact;
  String? status;
  String? title;
  String? description;
  String? projectManager;
  String? duration;
  String? workForce;
  String? budget;
  String? company;
  String? tentativeCode;
  String? location;
  String? notes;
  String? personName;
  String? personContacts;
  String? projectPriority;
  String? contractorName;
  String? contractorREName;
  String? contractorREPhone;
  String? contractorMEName;
  String? contractorMEPhone;
  String? clientName;
  String? consultantName;
  String? consultantREName;
  String? consultantREPhone;
  String? consultantMEName;
  String? consultantMEPhone;
  String? precourmentName;
  String? precourmentPhone;
  String? accountOfficerName;
  String? accountOfficerPhone;
  String? priceValue;
  List<WorkScope>? workScope;
  String? filePath;
  int? iV;

  ProjectData(
      {this.sId,
      this.userId,
      this.name,
      this.departmentRe,
      this.departmentMe,
      this.consultName,
      this.consultPhone,
      this.ownerMe,
      this.ownerName,
      this.ownerContact,
      this.status,
      this.title,
      this.description,
      this.projectManager,
      this.duration,
      this.workForce,
      this.budget,
      this.company,
      this.tentativeCode,
      this.location,
      this.notes,
      this.personName,
      this.personContacts,
      this.projectPriority,
      this.contractorName,
      this.contractorREName,
      this.contractorREPhone,
      this.contractorMEName,
      this.contractorMEPhone,
      this.clientName,
      this.consultantName,
      this.consultantREName,
      this.consultantREPhone,
      this.consultantMEName,
      this.consultantMEPhone,
      this.precourmentName,
      this.precourmentPhone,
      this.accountOfficerName,
      this.accountOfficerPhone,
      this.priceValue,
      this.workScope,
      this.filePath,
      this.iV});

  ProjectData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    departmentRe = json['departmentRe'];
    departmentMe = json['departmentMe'];
    consultName = json['consultName'];
    consultPhone = json['consultPhone'];
    ownerMe = json['ownerMe'];
    ownerName = json['ownerName'];
    ownerContact = json['ownerContact'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    projectManager = json['projectManager'];
    duration = json['duration'];
    workForce = json['workForce'];
    budget = json['budget'];
    company = json['company'];
    tentativeCode = json['tentativeCode'];
    location = json['location'];
    notes = json['notes'];
    personName = json['personName'];
    personContacts = json['personContacts'];
    projectPriority = json['projectPriority'];
    contractorName = json['contractorName'];
    contractorREName = json['contractorREName'];
    contractorREPhone = json['contractorREPhone'];
    contractorMEName = json['contractorMEName'];
    contractorMEPhone = json['contractorMEPhone'];
    clientName = json['clientName'];
    consultantName = json['consultantName'];
    consultantREName = json['consultantREName'];
    consultantREPhone = json['consultantREPhone'];
    consultantMEName = json['consultantMEName'];
    consultantMEPhone = json['consultantMEPhone'];
    precourmentName = json['precourmentName'];
    precourmentPhone = json['precourmentPhone'];
    accountOfficerName = json['accountOfficerName'];
    accountOfficerPhone = json['accountOfficerPhone'];
    priceValue = json['priceValue'];
    if (json['workScope'] != null) {
      workScope = <WorkScope>[];
      json['workScope'].forEach((v) {
        workScope!.add(new WorkScope.fromJson(v));
      });
    }
    filePath = json['filePath'] ?? '';
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['userId'] = userId;
    data['name'] = name;
    data['departmentRe'] = departmentRe;
    data['departmentMe'] = departmentMe;
    data['consultName'] = consultName;
    data['consultPhone'] = consultPhone;
    data['ownerMe'] = ownerMe;
    data['ownerName'] = ownerName;
    data['ownerContact'] = ownerContact;
    data['status'] = status;
    data['title'] = title;
    data['description'] = description;
    data['projectManager'] = projectManager;
    data['duration'] = duration;
    data['workForce'] = workForce;
    data['budget'] = budget;
    data['company'] = company;
    data['tentativeCode'] = tentativeCode;
    data['location'] = location;
    data['notes'] = notes;
    data['personName'] = personName;
    data['personContacts'] = personContacts;
    data['projectPriority'] = projectPriority;
    data['contractorName'] = contractorName;
    data['contractorREName'] = contractorREName;
    data['contractorREPhone'] = contractorREPhone;
    data['contractorMEName'] = contractorMEName;
    data['contractorMEPhone'] = contractorMEPhone;
    data['clientName'] = clientName;
    data['consultantName'] = consultantName;
    data['consultantREName'] = consultantREName;
    data['consultantREPhone'] = consultantREPhone;
    data['consultantMEName'] = consultantMEName;
    data['consultantMEPhone'] = consultantMEPhone;
    data['precourmentName'] = precourmentName;
    data['precourmentPhone'] = precourmentPhone;
    data['accountOfficerName'] = accountOfficerName;
    data['accountOfficerPhone'] = accountOfficerPhone;
    data['priceValue'] = priceValue;
    if (workScope != null) {
      data['workScope'] = workScope!.map((v) => v.toJson()).toList();
    }
    data['filePath'] = filePath;
    data['__v'] = iV;
    return data;
  }
}

class WorkScope {
  String? name;
  String? sId;

  WorkScope({this.name, this.sId});

  WorkScope.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['_id'] = sId;
    return data;
  }
}
