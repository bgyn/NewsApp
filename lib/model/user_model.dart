
import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String userName;
  final String fullName;
  final String email;
  int? phoneNumber;
  String? profilePic;
  String? bio;
  final List<String> followers;
  final List<String> following;
  UserModel({
    required this.uid,
    required this.userName,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.profilePic,
    this.bio,
    required this.followers,
    required this.following,
  });

  UserModel copyWith({
    String? uid,
    String? userName,
    String? fullName,
    String? email,
    int? phoneNumber,
    String? profilePic,
    String? bio,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePic': profilePic,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        uid: map['uid'] as String,
        userName: map['userName'] as String,
        fullName: map['fullName'] as String,
        email: map['email'] as String,
        phoneNumber:
            map['phoneNumber'] != null ? map['phoneNumber'] as int : null,
        profilePic:
            map['profilePic'] != null ? map['profilePic'] as String : null,
        bio: map['bio'] != null ? map['bio'] as String : null,
        followers: List<String>.from((map['followers'] as List<String>)),
        following: List<String>.from(
          (map['following'] as List<String>),
        ));
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, profilePic: $profilePic, bio: $bio, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.fullName == fullName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profilePic == profilePic &&
        other.bio == bio &&
        listEquals(other.followers, followers) &&
        listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profilePic.hashCode ^
        bio.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
