class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';

  static const String registerUrl = '$_baseUrl/Registration';
  static const String loginUrl = '$_baseUrl/Login';
  static const String updateProfileUrl = '$_baseUrl/ProfileUpdate';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static const String newTasklistUrl = '$_baseUrl/listTaskByStatus/New';
  static const String progressTaskListUrl =
      '$_baseUrl/listTaskByStatus/Progress';
  static const String completedTaskListUrl =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String cancelledTaskListUrl =
      '$_baseUrl/listTaskByStatus/Cancelled';

  static String updateTaskstatusUrl(String taskId, String taskStatus) =>
      '$_baseUrl/updateTaskStatus/$taskId/$taskStatus';
  static String deletTaskUrl(String taskId) => '$_baseUrl/deleteTask/$taskId/';
  static String recoverEmailUrl(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email/';

  static String otp(String email, String otp) =>
      '$_baseUrl/RecoverVerifyOtp/$email/$otp';
}
