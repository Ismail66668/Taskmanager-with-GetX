import 'package:get/get.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';

import '../../data/models/task_model/task_list_model.dart';
import '../../data/models/task_model/task_model.dart';

class NewTaskController extends GetxController {
  final bool _newTaskProgressInd = true;
  List<TaskModel> _newTasklist = [];
  String? _errorMassage;
  bool get taskProgress => _newTaskProgressInd;
  List get newTaskList => _newTasklist;
  String? get errorMassage => _errorMassage;

  Future<bool> getAllTaskList() async {
    bool isSuccess = true;
    _newTaskProgressInd == true;
    update();
    NetworkRespons respons =
        await NetworkClient.getRequest(url: Urls.newTasklistUrl);
    if (respons.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(respons.data!);
      _newTasklist = taskListModel.tasklist;
      _errorMassage = null;
    } else {
      _errorMassage = respons.errorMassage;
    }
    _newTaskProgressInd == false;
    update();
    return isSuccess;
  }
}
