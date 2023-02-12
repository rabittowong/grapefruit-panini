import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../component/dialog/dialog_confirm_logout.dart';
import '../../component/profile/profile_avatar.dart';
import '../../model/profile_model.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key, required this.profile}) : super(key: key);

  final ProfileModel profile;

  @override
  ProfileContentState createState() => ProfileContentState();
}

class ProfileContentState extends State<ProfileContent> {
  void _onLogoutPressed() {
    showDialog(
        context: context,
        builder: (context) => const DialogConfirmLogout()).then((value) {
      if (value != null && value) {
        debugPrint('logout');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('個人檔案'),
      ),
      body: Column(
        children: [
          GFCard(
            padding: const EdgeInsets.all(10),
            content: Column(
              children: [
                ProfileAvatar(
                  photoUrl: widget.profile.photoUrl,
                  width: 60,
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Text(
                  widget.profile.displayName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.only(top: 2)),
                Text(
                  widget.profile.email,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          GFCard(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            padding: EdgeInsets.zero,
            content: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              onTap: _onLogoutPressed,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Expanded(
                      child: SizedBox(height: 40),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('登出'),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.chevron_right_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
