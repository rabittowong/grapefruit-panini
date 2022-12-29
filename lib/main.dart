import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'auth/auth_loading.dart';
import 'model/profile_model.dart';
import 'page/auth/login_content.dart';
import 'page/router_content.dart';
import 'service/profile_service.dart';
import 'theme_color.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Auth(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '柚子記事簿',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xfffd6b42, ThemeColor.swatch),
      ),
      home: Consumer<Auth>(
        builder: (context, auth, _) {
          return StreamBuilder<ProfileModel>(
            stream: ProfileService.getProfileByUid(auth.getCurrentUid() ?? ''),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AuthLoading();
              } else if (snapshot.hasData) {
                return RouterContent(profile: snapshot.data!);
              } else {
                return const LoginContent();
              }
            },
          );
        },
      ),
    );
  }
}
