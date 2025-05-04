import 'package:get/get.dart';

import '../../data/models/task_count_model/task_count_list.dart';
import '../../data/models/task_count_model/task_count_model.dart';
import '../../data/services/network_client.dart';
import '../../data/utils/urls/urls.dart';

class TaskCountController extends GetxController {
  bool _taskstatusCountInproressInd = false;
  List<TaskCountModel> _taskcountlist = [];
  String? _errorMassage;
  bool get taskCPIndicator => _taskstatusCountInproressInd;
  List<TaskCountModel> get taskCModel => _taskcountlist;
  String? get errorMassage => _errorMassage;

  Future<bool> taskcountstatus() async {
    bool isSuccess = false;
    _taskstatusCountInproressInd = true;
    update();
    NetworkRespons respons =
        await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
    if (respons.isSuccess) {
      TaskCountList taskCountList = TaskCountList.fromJson(respons.data!);
      _taskcountlist = taskCountList.statusCountList;
      _errorMassage = null;
      isSuccess = true;
    } else {
      _errorMassage = respons.errorMassage;
    }
    _taskstatusCountInproressInd = false;
    update();
    return isSuccess;
  }
}
