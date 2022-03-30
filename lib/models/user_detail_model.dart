

class UserDetailModel{

  final String? displayName;
  final String? email;
  final String? photoUrl;



  const UserDetailModel({
    this.displayName,
    this.email,
    this.photoUrl,
  });


  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

}