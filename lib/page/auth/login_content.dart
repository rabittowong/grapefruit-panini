import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../component/auth/login_header.dart';
import '../../component/form/form_elevated_button.dart';
import '../../component/form/form_input.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  LoginContentState createState() => LoginContentState();
}

class LoginContentState extends State<LoginContent> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      debugPrint('logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginHeader(),
      body: Column(
        children: [
          GFCard(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            content: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    '登入',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  FormInput(
                    inputController: _email,
                    label: '電郵',
                    icon: const Icon(Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null) {
                        return '電郵不能為空';
                      }
                      return null;
                    },
                  ),
                  FormInput(
                    inputController: _password,
                    label: '密碼',
                    icon: const Icon(Icons.key_outlined),
                    obscureText: true,
                    validator: (value) {
                      if (value == null) {
                        return '密碼不能為空';
                      }
                      return null;
                    },
                  ),
                  FormElevatedButton(
                    text: '登入',
                    onPressed: _onSubmit,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
