import 'package:flutter/material.dart';
import 'package:mytaskmanager/data/models/task_model/task_list_model.dart';
import 'package:mytaskmanager/data/models/task_model/task_model.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';

import '../widgets/screen_background.dart';
import '../widgets/task_status_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final bool _completTaskCPInd = false;
  List<TaskModel> _completeTasklist = [];
  @override
  void initState() {
    super.initState();
    _getAllCompletdeTask();
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
            itemCount: _completeTasklist.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return TaskStatusCard(
                  status: "Completed",
                  color: Colors.green,
                  taskModel: _completeTasklist[index],
                  refreshlist: _getAllCompletdeTask);
            },
          ),
        ),
      )),
    );
  }

  Future<void> _getAllCompletdeTask() async {
    _completTaskCPInd == true;
    setState(() {});
    NetworkRespons respons =
        await NetworkClient.getRequest(url: Urls.completedTaskListUrl);
    if (respons.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(respons.data!);
      _completeTasklist = taskListModel.tasklist;
    } else {}
    _completTaskCPInd == false;
    setState(() {});
  }
}
