import 'package:get/get.dart';
import 'package:mytaskmanager/ui/auth_controller/new_task_controller.dart';
import 'package:mytaskmanager/ui/auth_controller/regsteer_controller.dart';
import 'package:mytaskmanager/ui/auth_controller/task_count_controller.dart';
import 'package:mytaskmanager/ui/login_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(TaskCountController());
    Get.put(NewTaskController());
    Get.put(RegsteerController());
  }
}
