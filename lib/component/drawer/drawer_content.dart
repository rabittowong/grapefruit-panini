import 'package:flutter/material.dart';

import '../../model/profile_model.dart';
import 'drawer_profile_tile.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({Key? key, required this.profile}) : super(key: key);

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerProfileTile(profile: profile),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 5),
                children: const [
                  ListTile(
                    leading: Icon(Icons.person_rounded),
                    title: Text('管理帳號'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings_rounded),
                    title: Text('設定'),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_rounded),
                    title: Text('登出'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
