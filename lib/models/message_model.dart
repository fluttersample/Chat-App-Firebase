

class MessageModel{

  String message;
  String sendBy;
  String time;
  MessageModel({required this.message,
  required this.sendBy
  ,required this.time});



  Map<String,dynamic> toMap() =>{
    'message' :message,
    'sendBy' : sendBy,
    'time' : time
  };


  factory MessageModel.fromMap(Map<String,dynamic> json)
  {
    return MessageModel(
      message: json['message'],
      sendBy: json['sendBy'],
      time: json['time']
    );
  }
}