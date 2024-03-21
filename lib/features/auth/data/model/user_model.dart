import 'package:advance_login_mock/core/utils/typedefs.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.totalFollowers,
    required super.totalFollowing,
    required super.totalPosts,
    super.followers,
    super.following,
    super.profilePic,
    super.bio,
  });

  const LocalUserModel.empty() : super.empty();

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          fullName: map['fullName'] as String,
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
          totalFollowers: (map['totalFollowers'] as num).toInt(),
          totalFollowing: (map['totalFollowing'] as num).toInt(),
          totalPosts: (map['totalPosts'] as num).toInt(),
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
        );

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    List<String>? followers,
    List<String>? following,
    int? totalFollowers,
    int? totalFollowing,
    int? totalPosts,
    String? profilePic,
    String? bio,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      totalFollowers: totalFollowers ?? this.totalFollowers,
      totalFollowing: totalFollowing ?? this.totalFollowing,
      totalPosts: totalPosts ?? this.totalPosts,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'followers': followers,
      'following': following,
      'totalFollowers': totalFollowers,
      'totalFollowing': totalFollowing,
      'totalPosts': totalPosts,
      'profilePic': profilePic,
      'bio': bio,
    };
  }

  factory LocalUserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return LocalUserModel(
      uid: snapshot["uid"],
      email: snapshot["email"],
      fullName: snapshot["fullName"],
      followers: List.from(snap.get("followers")),
      following: List.from(snap.get("following")),
      totalFollowers: snapshot["totalFollowers"],
      totalFollowing: snapshot["totalFollowing"],
      totalPosts: snapshot["totalPosts"],
      profilePic: snapshot["profilePic"],
      bio: snapshot["bio"],
    );
  }
}
