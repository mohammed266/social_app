class MessageModel{
  String senderId;
  String receivedId;
  String text;
  String dateTime;


  MessageModel({this.text,this.dateTime,this.receivedId,this.senderId});

  MessageModel.fromJason(Map<String,dynamic> json){
    text = json['text'];
    dateTime = json['dateTime'];
    receivedId = json['receivedId'];
    senderId = json['senderId'];

  }

  Map<String,dynamic> toMap() {
    return {
      'senderId' : senderId,
      'receivedId' : receivedId,
      'dateTime' : dateTime,
      'text' : text,
    };
  }
}