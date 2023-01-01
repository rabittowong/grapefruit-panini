import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';

import '../../model/profile_model.dart';
import '../../theme_color.dart';

class DrawerProfileTile extends StatelessWidget {
  const DrawerProfileTile({Key? key, required this.profile}) : super(key: key);

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(0.7, 0),
          tileMode: TileMode.repeated,
          colors: [
            ThemeColor.secondary[700]!,
            ThemeColor.secondary[900]!,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (profile.photoUrl != null)
              GFAvatar(
                backgroundImage: NetworkImage(profile.photoUrl!),
              ),
            if (profile.photoUrl == null)
              const GFAvatar(
                backgroundImage: AssetImage('assets/img/avatar_anoymous.png'),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                profile.displayName,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                profile.email,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
