import 'dart:async';

import 'package:bewolf/models/user.dart';
import 'package:bewolf/utils/api_response.dart';
import 'package:bewolf/utils/simple_bloc.dart';

import 'login_api.dart';

class LoginBloc extends BooleanBloc {
  Future<ApiResponse<User>> login(String login, String password) async {
    add(true);

    ApiResponse response = (await LoginApi.login(login, password)) as ApiResponse;

    add(false);

    return response;
  }
}
