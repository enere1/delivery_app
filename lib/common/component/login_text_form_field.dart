import 'package:delivery_app/common/const/colors/colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginTextFormField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final FocusNode? focusNode;

  const LoginTextFormField({
    required this.label,
    required this.isPassword,
    this.focusNode,
    Key? key,
  }) : super(key: key);

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  bool _isObscure = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.isPassword ? null : _validateMail,
      obscureText: widget.isPassword ? _isObscure : false,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 2.0,
            color: PRIMARY_COLOR,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red, // 에러 시 테두리 색상
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 2.0,
            color: Colors.red,
          ),
        ),
        labelStyle: TextStyle(
          fontSize: 16,
          color: _hasError ? Colors.red : PRIMARY_COLOR,
        ),
        errorStyle: TextStyle(
          fontSize: 12,
          color: Colors.red,
        ),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(
          fontSize: 20,
          color: _hasError ? Colors.red : PRIMARY_COLOR,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: PRIMARY_COLOR,
            width: 1.0,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    print(_isObscure);
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }

  String? _validateMail(String? value) {
    print(value);
    if (value == null || value.isEmpty) {
      setState(() {
        _hasError = true;
      });
      return '入力してください';
    }

    final isEmail = EmailValidator.validate(value);
    if (!isEmail) {
      setState(() {
        _hasError = true;
      });
      return 'メールフォマットではありません。';
    }

    setState(() {
      _hasError = false;
    });
    return null;
  }
}
