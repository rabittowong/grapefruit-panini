import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/riv/bounce_rabbit.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
