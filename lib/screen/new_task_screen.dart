import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytaskmanager/ui/auth_controller/task_count_controller.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';

import '../ui/auth_controller/new_task_controller.dart';
import '../widgets/task_status_card.dart';
import '../widgets/task_summary_count.dart';
import 'add_new_task.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final bool _newTaskProgressInd = false;

  TaskCountController taskcountController = Get.find<TaskCountController>();
  NewTaskController newTaskController = Get.find<NewTaskController>();
  @override
  void initState() {
    super.initState();
    _gettaskcountstatus();
    _getAllTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
          child: Column(
            children: [
              GetBuilder<TaskCountController>(builder: (controller) {
                return Visibility(
                  visible: controller.taskCPIndicator == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.taskCModel.length,
                      itemBuilder: (context, index) {
                        return SummaryCountCard(
                          name: controller.taskCModel[index].status,
                          count: controller.taskCModel[index].count,
                        );
                      },
                    ),
                  ),
                );
              }),
              GetBuilder<NewTaskController>(builder: (controller) {
                return Visibility(
                  visible: _newTaskProgressInd == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: controller.newTaskList.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return TaskStatusCard(
                          status: "New",
                          color: Colors.blue,
                          taskModel: controller.newTaskList[index],
                          refreshlist: _getAllTaskList,
                        );
                      },
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: _onTapAddTask,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )));
  }

  void _onTapAddTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTask(),
      ),
    );
  }

  Future<void> _gettaskcountstatus() async {
    final bool iSsuccess = await taskcountController.taskcountstatus();
    if (!iSsuccess) {
      taskcountController.errorMassage;
      true;
    }
  }

  // Future<void> _taskcountstatus() async {
  //   _taskstatusCountInproressInd = true;
  //   setState(() {});
  //   NetworkRespons respons =
  //       await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);
  //   if (respons.isSuccess) {
  //     TaskCountList taskCountList = TaskCountList.fromJson(respons.data!);
  //     _taskcountlist = taskCountList.statusCountList;
  //   } else {
  //     snackBarMassage(context, 'fail !', true);
  //   }
  //   _taskstatusCountInproressInd == false;
  //   setState(() {});
  // }

  Future<void> _getAllTaskList() async {
    final bool isSuccess = await Get.find<NewTaskController>().getAllTaskList();
    if (!isSuccess) {
      Get.find<NewTaskController>().errorMassage;
    }
  }

  // Future<void> _getAllTaskList() async {
  //   _newTaskProgressInd == true;
  //   setState(() {});
  //   NetworkRespons respons =
  //       await NetworkClient.getRequest(url: Urls.newTasklistUrl);
  //   if (respons.isSuccess) {
  //     TaskListModel taskListModel = TaskListModel.fromJson(respons.data!);
  //     _newTasklist = taskListModel.tasklist;
  //   } else {}
  //   _newTaskProgressInd == false;
  //   setState(() {});
  // }
}
