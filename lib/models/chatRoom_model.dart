

class ChatRoomModel
{

  List<dynamic> users;
  String chatRoomId;
  String lastMessageSend;
  String urlImage;
  ChatRoomModel({required this.chatRoomId,
  required this.users,
  required this.lastMessageSend,
  required this.urlImage});

  Map<String, dynamic> toMap() {
    return {
      'users': users,
      'chatRoomId': chatRoomId,
      'lastMessageSend' : lastMessageSend,
      'urlImage' : urlImage
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      users: map['users'] as List<dynamic>,
      chatRoomId: map['chatRoomId'] as String,
      lastMessageSend: map['lastMessageSend'] as String,
      urlImage: map['urlImage'] as String
    );
  }
}