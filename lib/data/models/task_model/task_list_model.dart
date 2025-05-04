import 'package:mytaskmanager/data/models/task_model/task_model.dart';

class TaskListModel {
  late final String status;
  late final List<TaskModel> tasklist;

  TaskListModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'] ?? '';
    if (jsonData['data'] != null) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> data in jsonData['data']) {
        list.add(TaskModel.fromJson(data));
      }
      tasklist = list;
    } else {
      tasklist = [];
    }
  }
}
