import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  final String uid;
  final String email;
  final String fullName;
  final List followers;
  final List following;
  final num totalFollowers;
  final num totalFollowing;
  final num totalPosts;
  final String? profilePic;
  final String? bio;

  const LocalUser({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.totalPosts,
    this.followers = const [],
    this.following = const [],
    this.profilePic,
    this.bio,
  });

  const LocalUser.empty()
      : this(
          uid: "",
          email: "",
          fullName: "",
          followers: const [],
          following: const [],
          totalFollowers: 0,
          totalFollowing: 0,
          totalPosts: 0,
          profilePic: "",
          bio: "",
        );

  @override
  List<Object?> get props => [
        uid,
        email,
        fullName,
        followers,
        following,
        totalFollowers,
        totalFollowing,
        totalPosts,
        profilePic,
        bio,
      ];

  @override
  bool get stringify => true;
}
