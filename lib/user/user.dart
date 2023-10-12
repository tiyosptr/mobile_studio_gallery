import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? email;
  String? namapengguna;

  UserModel({this.uid, this.email, this.namapengguna});

  //Receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      namapengguna: map['nama pengguna'],
    );
  }

  //Sending data to your server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nama pengguna': namapengguna,
    };
  }
}
