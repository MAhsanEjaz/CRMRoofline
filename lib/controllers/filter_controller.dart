import 'package:get/get.dart';
import 'package:leadmanagementsystem/main.dart';
import 'package:leadmanagementsystem/models/new_project_model.dart';

class FilterController extends GetxController {
  RxBool loading = false.obs;
  RxBool visible = false.obs;

  RxBool expand = false.obs;

  var projectData = <ProjectData>[].obs;

  getProjectsFilter(String? projectManager, String? status, String? budget,
      String? company) async {
    loading.value = true;

    var res = await getRequest.customGetRequest(
        apiPath:
            'filterProjects?projectManager=${projectManager ?? ''}&status=${status ?? ''}&budget=${budget ?? ''}&company=${company ?? ''}');

    if (res['status'] != false) {
      ProjectModel projectModel = ProjectModel.fromJson(res);
      loading.value = false;

      visible.value = true;

      projectData.value = projectModel.projectData ?? [];

      print('val--->${projectData.value}');
    } else {
      return false;
    }
  }
}
