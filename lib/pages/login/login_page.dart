import 'package:bewolf/pages/home/home_page.dart';
import 'package:bewolf/utils/alert.dart';
import 'package:bewolf/utils/api_response.dart';
import 'package:bewolf/utils/nav.dart';
import 'package:bewolf/widgets/app_button.dart';
import 'package:bewolf/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tLogin = TextEditingController();
  final tPass = TextEditingController();
  final _focusPass = FocusNode();
  final _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bewolf"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: (s) => _validateLogin(s),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusPass,
            ),
            SizedBox(height: 10),
            AppText(
              "Senha",
              "Digite a senha",
              controller: tPass,
              password: true,
              validator: _validatePass,
              keyboardType: TextInputType.number,
              focusNode: _focusPass,
            ),
            SizedBox(height: 20),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              initialData: false,
              builder: (context, snapshot) {
                return AppButton(
                  "Login",
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validatePass(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }

  void _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String pass = tPass.text;

    print("Login: $login, Senha: $pass");

    ApiResponse response = await _bloc.login(login, pass);

    if (response.ok) {
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }
  }
}
