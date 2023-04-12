class UserModel {
  String? uid;
  String? email;
  String? FirstName;
  String? SecondName;

  UserModel({this.uid, this.email, this.FirstName, this.SecondName});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      FirstName: map['FirstName'],
      SecondName: map['SecondName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': FirstName,
      'secondName': SecondName,
    };
  }
}