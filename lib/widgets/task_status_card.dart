// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mytaskmanager/data/models/task_model/task_model.dart';
import 'package:mytaskmanager/data/services/network_client.dart';
import 'package:mytaskmanager/data/utils/urls/urls.dart';

class TaskStatusCard extends StatefulWidget {
  TaskStatusCard(
      {super.key,
      required this.status,
      required this.color,
      required this.taskModel,
      required this.refreshlist});
  String status;
  Color color;
  final TaskModel taskModel;
  final VoidCallback refreshlist;

  @override
  State<TaskStatusCard> createState() => _TaskStatusCardState();
}

class _TaskStatusCardState extends State<TaskStatusCard> {
  bool _statusTPIndcator = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.taskModel.description,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(
              height: 10,
            ),
            Text(widget.taskModel.createdDate,
                style: Theme.of(context).textTheme.bodySmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(widget.taskModel.status,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.white)),
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: _showeditDialog,
                        icon: const Icon(Icons.edit_note)),
                    IconButton(
                        onPressed: _deletTask,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showeditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _changeTaskStatus('New');
                  _popDialog();
                },
                title: const Text("New"),
                trailing: isSelected('New') ? const Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  _changeTaskStatus('Progress');
                  _popDialog();
                },
                title: const Text("Progress"),
                trailing:
                    isSelected('Progress') ? const Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  _changeTaskStatus('Completed');
                  _popDialog();
                },
                title: const Text("Completed"),
                trailing:
                    isSelected('Completed') ? const Icon(Icons.done) : null,
              ),
              ListTile(
                onTap: () {
                  _changeTaskStatus('Cancelled');
                  _popDialog();
                },
                title: const Text("Cancelled"),
                trailing:
                    isSelected('Cancelled') ? const Icon(Icons.done) : null,
              ),
            ],
          ),
        );
      },
    );
  }

  bool isSelected(String status) => widget.status == status;

  Future<void> _changeTaskStatus(String statuss) async {
    _statusTPIndcator = true;
    setState(() {});
    NetworkRespons respons = await NetworkClient.getRequest(
        url: Urls.updateTaskstatusUrl(widget.taskModel.id, statuss));
    _statusTPIndcator == false;

    if (respons.isSuccess) {
      widget.refreshlist();
    } else {}

    setState(() {});
  }

  void _popDialog() {
    Navigator.pop(context);
  }

  Future<void> _deletTask() async {
    _statusTPIndcator = true;
    setState(() {});
    NetworkRespons respons = await NetworkClient.getRequest(
        url: Urls.deletTaskUrl(widget.taskModel.id));
    _statusTPIndcator == false;

    if (respons.isSuccess) {
    } else {}
    setState(() {});
  }
}
