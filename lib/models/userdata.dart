import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name;
  String emailid;
  String profilepic;

  UserData(this.emailid, this.name, this.profilepic);

  factory UserData.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserData(
      data['name'],
      data['emailid'],
      data['profilepic'],
    );
  }
}
