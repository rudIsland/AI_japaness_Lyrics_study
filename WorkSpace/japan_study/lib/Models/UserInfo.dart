import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final DateTime? lastLogin;

  UserInfo({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.lastLogin,
  });

  // Firestore 데이터 변환용
  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      lastLogin: (map['lastLogin'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'lastLogin': lastLogin != null
          ? Timestamp.fromDate(lastLogin!)
          : FieldValue.serverTimestamp(),
    };
  }
}
