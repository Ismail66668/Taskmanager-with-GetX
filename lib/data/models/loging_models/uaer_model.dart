// ignore_for_file: public_member_api_docs, sort_constructors_first
// class LogingModel {
//   late final String id;
//   late final String email;
//   late final String fastName;
//   late final String lastName;
//   late final String mobile;
//   late final String createDate;

//   LogingModel.fromJson(Map<String, dynamic> jsonData) {
//     id = jsonData['_id'] ?? '';
//     email = jsonData['email'] ?? '';
//     fastName = jsonData['fastName'] ?? '';
//     lastName = jsonData['lastName'] ?? '';
//     mobile = jsonData['phone'] ?? '';
//     createDate = jsonData['createDate'] ?? '';
//   }
// }

// class UserModel {
//   late final String id;
//   late final String email;
//   late final String fastName;
//   late final String lastName;
//   late final String mobile;
//   late final String createDate;
//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fastName,
//     required this.lastName,
//     required this.mobile,
//     required this.createDate,
//   });

//   UserModel.fromJson(Map<String, dynamic> jsonData) {
//     id = jsonData['_id'] ?? '';
//     email = jsonData['email'] ?? '';
//     fastName = jsonData['fastName'] ?? '';
//     lastName = jsonData['lastName'] ?? '';
//     mobile = jsonData['phone'] ?? '';
//     createDate = jsonData['createDate'] ?? '';
//   }

class UserModel {
  late final String id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String createdDate;
  late final String photo;

  // named constructor
  UserModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['_id'] ?? '';
    email = jsonData['email'] ?? '';
    firstName = jsonData['firstName'] ?? '';
    lastName = jsonData['lastName'] ?? '';
    mobile = jsonData['mobile'] ?? '';
    createdDate = jsonData['createdDate'] ?? '';
    photo = jsonData['photo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,
    };
  }

  String get fulName {
    return '$firstName $lastName';
  }
}
