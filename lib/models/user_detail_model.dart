

class UserDetailModel{

  final String? displayName;
  final String? email;
  final String? photoUrl;
  final String? token;


  const UserDetailModel({
    this.displayName,
    this.email,
    this.photoUrl,
    this.token
  });


  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'token' : token
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      token: map['token'] as String
    );
  }

}