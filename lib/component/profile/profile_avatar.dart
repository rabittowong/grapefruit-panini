import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required this.photoUrl,
    this.width,
  }) : super(key: key);

  final String? photoUrl;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (photoUrl != null)
          Container(
            width: width,
            height: width,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(photoUrl ?? ''),
                fit: BoxFit.fill,
              ),
            ),
          ),
        if (photoUrl == null)
          Container(
            width: width,
            height: width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/img/avatar_anonymous.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
      ],
    );
  }
}
