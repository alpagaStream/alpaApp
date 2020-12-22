import 'package:alpaga/models/user.dart';

enum LiveStreamType {
  host,
  guest,
}

class LiveStream {

  User user;
  DateTime startDate;
  DateTime endDate;
  int time;
  LiveStreamType type;
  bool selected = false;
  save() {
    print('saving user using a web service');
  }

  LiveStream(this.user, this.startDate, this.endDate, this.time, this.type);


  LiveStream.fromJson(Map<String, dynamic> json) {
    user = json['username'];
  }


}
