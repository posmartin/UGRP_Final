import 'package:firebase_database/firebase_database.dart';

class Userinfor {
  String id;
  String pw;
  String createTime;

  Userinfor(this.id, this.pw, this.createTime);

  Userinfor.fromSnapshot(DataSnapshot snapshot)
      :
        id = snapshot.value['id'],
        pw = snapshot.value['pw'],
        createTime = snapshot.value['createTime'];

  toJson() {
    return {
      'id': id,
      'pw': pw,
      'createTime': createTime,
    };
  }
}
