import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mytaskmanager/screen/loging_screen.dart';
import 'package:mytaskmanager/screen/update_profile.dart';
import 'package:mytaskmanager/ui/auth_controller/auth_controller.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: InkWell(
        onTap: () {
          _onTapUpdateProfile(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: _showImage(AuthController.userModels!.photo)
                  ? MemoryImage(
                      base64Decode(AuthController.userModels?.photo ?? ''))
                  : null,
              maxRadius: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AuthController.userModels?.fulName ?? ' undifind',
                      style: Theme.of(context).textTheme.bodySmall),
                  Text(AuthController.userModels?.email ?? ' undifind',
                      style: Theme.of(context).textTheme.bodySmall)
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  _onTapLogout(context);
                },
                icon: const Icon(Icons.login_outlined))
          ],
        ),
      ),
    );
  }

  void _onTapLogout(BuildContext context) {
    AuthController.logOutUser();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LogingScreen(),
        ),
        (pad) => false);
  }

  void _onTapUpdateProfile(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UpdateProfile(),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  bool _showImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }
}
