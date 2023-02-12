import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'auth/auth_loading.dart';
import 'model/profile_model.dart';
import 'page/auth/login_content.dart';
import 'page/router_content.dart';
import 'service/profile_service.dart';
import 'slide_leftwards_page_transition_builder.dart';
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
      title: '點點滴滴',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xfffd6b42, ThemeColor.swatch),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          labelStyle: const TextStyle(fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColor.primary[500]!, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColor.danger[500]!, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColor.danger[500]!, width: 1),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: ThemeColor.primary[500],
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: SlideLeftwardsPageTransitionBuilder(),
          TargetPlatform.windows: SlideLeftwardsPageTransitionBuilder(),
        }),
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
