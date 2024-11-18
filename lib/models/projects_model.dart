class Project {
  final String title;
  final String description;
  final String projectManager;
  String? duration;
  final String workForce;
  final num budget;
  final num tentativeCost;
  final String location;
  String? notes;
  String? personName;
  final String personContact;
  String projectPriority;
  String? file;
  final DateTime createdDate;

  Project({
    required this.title,
    required this.description,
    required this.projectManager,
    required this.duration,
    required this.workForce,
    required this.budget,
    required this.tentativeCost,
    required this.location,
    required this.notes,
    required this.personName,
    required this.personContact,
    required this.projectPriority,
    required this.file,
    required this.createdDate,
  });
}
