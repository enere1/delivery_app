import 'package:delivery_app/common/component/login_text_form_field.dart';
import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/restaurant/view/restaurant_screen.dart';
import 'package:delivery_app/user/model/user_model.dart';
import 'package:delivery_app/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Login extends ConsumerStatefulWidget {
  static String get routeName => 'Login';
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final formKey = GlobalKey<FormState>(); // GlobalKey for Form
  final mailFocusNode = FocusNode();
  String id = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    mailFocusNode.addListener(() {
      if (!mailFocusNode.hasFocus) {
        if (formKey.currentState != null) {
          formKey.currentState!.validate();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: SafeArea(
        child: Form(
          key: formKey,
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
                  height: 280,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4.0,
                ),
                LoginTextFormField(
                  label: 'login',
                  isPassword: false,
                  focusNode: mailFocusNode,
                  onSaved: (String? val) {
                    setState(() {
                      id = val!;
                    });
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                LoginTextFormField(
                  label: 'password',
                  isPassword: true,
                  onSaved: (String? val) {
                    setState(() {
                      password = val!;
                    });
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.save();
                      ref
                          .read(userProvider.notifier)
                          .login(id: id, password: password);
                    },
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
