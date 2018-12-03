import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class RegisterScreen extends StatefulWidget {
  final RegisterBloc registerBloc;

  const RegisterScreen({Key key, @required this.registerBloc})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: body(),
      ),
    );
  }

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        textFormField(hintText: "Họ tên"),
        textFormField(hintText: "Tên tài khoản"),
        textFormField(hintText: "Địa chỉ Email"),
        textFormField(hintText: "Mật khẩu"),
        textFormField(hintText: "Xác nhận mật khẩu"),
      ],
    );
  }

  Widget textFormField({String hintText = ""}) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
    );
  }
}