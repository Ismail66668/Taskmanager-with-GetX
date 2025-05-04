import 'package:flutter/material.dart';
import 'package:mytaskmanager/data/models/task_model/task_list_model.dart';
import 'package:mytaskmanager/data/models/task_model/task_model.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';

import '../widgets/task_status_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  // ignore: unused_field
  final bool _completTaskCPInd = false;
  List<TaskModel> _progressTasklist = [];
  @override
  void initState() {
    super.initState();
    _getAllProgessTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: Expanded(
        child: Visibility(
          visible: _completTaskCPInd == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: _progressTasklist.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return TaskStatusCard(
                status: "Progress",
                color: Colors.purple,
                taskModel: _progressTasklist[index],
                refreshlist: _getAllProgessTask,
              );
            },
          ),
        ),
      )),
    );
  }

  Future<void> _getAllProgessTask() async {
    _completTaskCPInd == true;
    setState(() {});
    NetworkRespons respons =
        await NetworkClient.getRequest(url: Urls.progressTaskListUrl);
    if (respons.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(respons.data!);
      _progressTasklist = taskListModel.tasklist;
    } else {}
    _completTaskCPInd == false;
    setState(() {});
  }
}
