// ignore_for_file: prefer_initializing_formals, empty_constructor_bodies, unnecessary_this

class MessageModel {
  String text, sender, date, reciever, time;
  //MessageModel();
  MessageModel.data(
      {this.sender, this.reciever, this.date, this.text, this.time});

  // ignore: non_constant_identifier_names
  MessageModel.get_data(Map<String, dynamic> json) {
    text = json['text'];
    sender = json['sender'];
    reciever = json['reciever'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'date': date,
      'time': time,
      'sender': sender,
      'reciever': reciever,
    };
  }
}
