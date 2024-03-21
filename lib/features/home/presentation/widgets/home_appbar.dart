import 'package:advance_login_mock/core/res/media_res.dart';
import 'package:advance_login_mock/features/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final LocalUser currentUser;
  const HomeAppBar({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome back,",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            currentUser.fullName,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 22,
            backgroundImage: currentUser.profilePic != null
                ? NetworkImage(currentUser.profilePic!)
                : const AssetImage(MediaRes.user) as ImageProvider,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
