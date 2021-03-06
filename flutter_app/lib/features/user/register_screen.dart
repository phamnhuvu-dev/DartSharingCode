import 'dart:async';

import 'package:core_app/core_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/buttons/button_theme.dart';
import 'package:flutter_app/widgets/buttons/rect_button.dart';
import 'package:flutter_app/widgets/dialogs/app_dialog.dart';
import 'package:flutter_app/widgets/dialogs/loading.dart';
import 'package:flutter_app/widgets/helper/scrollable_content_center.dart';
import 'package:flutter_app/widgets/oval_head_card.dart';
import 'package:flutter_app/widgets/scaffold/gradient_scaffold.dart';
import 'package:flutter_app/widgets/textfield/rect_textfield.dart';

class RegisterScreen extends StatefulWidget {
  final UserGlobalBloc userGlobalBloc;


  const RegisterScreen({
    Key key,@required this.userGlobalBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with ScrollableContentCenterHelper {
  TextEditingController usernameController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  StreamSubscription<User> streamSubscription;
  UserGlobalBloc userGlobalBloc;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: body(),
    );
  }

  @override
  void initState() {
    super.initState();
    userGlobalBloc = Injector.get();
    streamSubscription = userGlobalBloc.user.listen(
      (user) {
        streamSubscription.cancel();
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/main", (Route<dynamic> route) => false);
      },
    );
  }

  Widget body() {
    return SingleChildScrollView(
      key: bodyKey,
      child: ScrollableContentCenter(
        bodyKey: bodyKey,
        contentKey: contentKey,
        padding: EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Column(
          key: contentKey,
          children: <Widget>[
            OvalHeadCard(
              title: "Register",
              top: 20.0,
              child: Column(
                children: <Widget>[
                  streamRegister(),
                  RectButton(
                    text: "Register",
                    theme: DodgerBlueButtonTheme(),
                    onTap: () {
                      AppDialog.show(
                        context: context,
                        child: Loading(
                          message: "Registering",
                        ),
                        onWillPop: userGlobalBloc.cancelRequest,
                      );

                      userGlobalBloc.checkValidRegister(
                        username: usernameController.text,
                        accountName: accountNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: passwordController.text,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget streamRegister() {
    return StreamBuilder(
      stream: userGlobalBloc.validRegister,
      builder: (
        BuildContext context,
        AsyncSnapshot<Tuple5<String, String, String, String, String>> snapshot,
      ) {
        if (snapshot.data != null) {
          print(snapshot.data);
        }

        return Column(
          children: <Widget>[
            textfield(
              hintText: "Username",
              controller: usernameController,
            ),
            textfield(
              hintText: "Account name",
              controller: accountNameController,
            ),
            textfield(
              hintText: "Email",
              controller: emailController,
            ),
            textfield(
              hintText: "Password",
              controller: passwordController,
            ),
            textfield(
              hintText: "Confirm password",
              controller: confirmPasswordController,
            ),
          ],
        );
      },
    );
  }

  Widget textfield({String hintText, TextEditingController controller}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: RectTextField(
        controller: controller,
        hintText: hintText,
      ),
    );
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}
