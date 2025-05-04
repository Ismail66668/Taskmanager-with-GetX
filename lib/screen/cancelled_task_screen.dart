import 'package:flutter/material.dart';
import 'package:mytaskmanager/data/models/task_model/task_list_model.dart';
import 'package:mytaskmanager/data/models/task_model/task_model.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';

import '../widgets/task_status_card.dart';

class CancelledTasked extends StatefulWidget {
  const CancelledTasked({super.key});

  @override
  State<CancelledTasked> createState() => _CancelledTaskedState();
}

class _CancelledTaskedState extends State<CancelledTasked> {
  final bool _cancleCPIndicator = false;
  List<TaskModel> _cancleTaslist = [];
  @override
  void initState() {
    super.initState();
    _getAllCancleTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Expanded(
        child: ListView.builder(
          itemCount: _cancleTaslist.length,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            return TaskStatusCard(
              status: "Cancelled",
              color: Colors.red,
              taskModel: _cancleTaslist[index],
              refreshlist: _getAllCancleTask,
            );
          },
        ),
      )),
    );
  }

  Future<void> _getAllCancleTask() async {
    _cancleCPIndicator == true;
    setState(() {});
    NetworkRespons respons =
        await NetworkClient.getRequest(url: Urls.cancelledTaskListUrl);
    if (respons.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(respons.data!);
      _cancleTaslist = taskListModel.tasklist;
    } else {}
    _cancleCPIndicator == false;
    setState(() {});
  }
}
