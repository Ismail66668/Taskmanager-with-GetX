import 'package:mytaskmanager/data/models/task_count_model/task_count_model.dart';

class TaskCountList {
  late final String status;
  late final List<TaskCountModel> statusCountList;

  TaskCountList.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    if (jsonData['data'] != null) {
      List<TaskCountModel> list = [];
      for (Map<String, dynamic> data in jsonData['data']) {
        list.add(TaskCountModel.fromJson(data));
      }
      statusCountList = list;
    } else {
      statusCountList = [];
    }
  }
}
  // late final String status;
  // late final List<TaskCountModel> taskcountListModel;
  // TaskCountList.fromJson(Map<String, dynamic> jsonData) {
  //   status = jsonData['status'];
  //   if (jsonData['data'] != null) {
  //     List<TaskCountModel> list = [];

  //     for (Map<String, dynamic> data in jsonData['data']) {
  //       list.add(TaskCountModel.fromJson(data));
  //     }
  //     taskcountListModel = list;
  //   } else {
  //     taskcountListModel = [];
  //   }
  // }

