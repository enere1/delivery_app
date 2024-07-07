import 'package:delivery_app/common/component/login_text_form_field.dart';
import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>(); // GlobalKey for Form
  final _mailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _mailFocusNode.addListener(() {
      if (!_mailFocusNode.hasFocus) {
        if (_formKey.currentState != null) {
          _formKey.currentState!.validate();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ようこそ！',
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.w500),
                        ),
                        Text(
                            'メールアドレスとパスワードを入力してログインしてください！\nお持ちでない方は会員登録をお願いします。',
                            style: TextStyle(
                                fontSize: 16.0, color: BODY_TEXT_COLOR)),
                      ]),
                ),
                Image.asset(
                  'asset/img/misc/logo.png',
                  height: 330,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4.0,
                ),
                LoginTextFormField(
                  label: 'login',
                  isPassword: false,
                  focusNode: _mailFocusNode,
                ),
                SizedBox(
                  height: 12.0,
                ),
                LoginTextFormField(
                  label: 'password',
                  isPassword: true,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('ログイン'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('新規登録'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
