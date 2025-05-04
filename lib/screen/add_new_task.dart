import 'package:flutter/material.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';
import 'package:mytaskmanager/widgets/screen_background.dart';
import 'package:mytaskmanager/widgets/snackbar_massage.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _desTEController = TextEditingController();
  final GlobalKey<FormState> _fromKye = GlobalKey<FormState>();
  final bool _addtaskPrigressIndicator = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Form(
              key: _fromKye,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    maxLines: 2,
                    textInputAction: TextInputAction.next,
                    controller: _titleTEController,
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return 'task title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'title'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    maxLines: 6,
                    textInputAction: TextInputAction.done,
                    controller: _desTEController,
                    validator: (String? value) {
                      if (value!.trim().isEmpty) {
                        return 'task description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'des'),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Visibility(
                    visible: _addtaskPrigressIndicator == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: _onTapSubmit,
                        child: Text(
                          "Confrim",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmit() {
    if (_fromKye.currentState!.validate()) {
      _submitData();
    }
  }

  Future<void> _submitData() async {
    _addtaskPrigressIndicator == true;
    setState(() {});
    Map<String, dynamic> requestBady = {
      "title": _titleTEController.text.trim(),
      "description": _desTEController.text.trim(),
      "status": "New"
    };
    NetworkRespons respons = await NetworkClient.postRequest(
        url: Urls.createTaskUrl, body: requestBady);

    _addtaskPrigressIndicator == false;
    setState(() {});
    if (respons.isSuccess) {
      snackBarMassage(context, 'add new task');
      _clearTEController();
    } else {
      snackBarMassage(context, 'fail');
    }
  }

  void _clearTEController() {
    _titleTEController.clear();
    _desTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _desTEController.dispose();
    super.dispose();
  }
}
