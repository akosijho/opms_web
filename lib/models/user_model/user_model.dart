class UserModel {
  String userId;
  String firstName;
  String lastName;
  String phoneNum;
  String email;
  String image;
  String position;
  String dateOfBirth;
  String gender;
  String active_status;
  List<String> appointments;
  List<String> searchIndex;
  List<dynamic> fcmToken;

  UserModel(
    this.userId, {
    required this.active_status,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.position,
    required this.dateOfBirth,
    required this.gender,
    required this.appointments,
    required this.fcmToken,
    required this.searchIndex,
    required this.phoneNum,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      position: json['position'],
      appointments:
          json['appointments'] != null ? List.from(json['appointments']) : [],
      fcmToken: json['fcmToken'] != null ? List.from(json['fcmToken']) : [],
      searchIndex: [],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      active_status: json['active_status'],
      phoneNum: json['phoneNum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'position': position,
      'appointments': appointments,
      'fcmToken': fcmToken,
      'searchIndex': searchIndex,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'active_status': active_status,
      'phoneNum': phoneNum,
    };
  }

  String get fullName => firstName + ' ' + lastName;
}
