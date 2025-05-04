class TaskCountModel {
  late final String status;
  late final int count;

  TaskCountModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['_id'];
    count = jsonData['sum'];
  }
}
