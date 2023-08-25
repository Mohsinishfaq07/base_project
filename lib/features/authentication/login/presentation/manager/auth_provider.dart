import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sb_myreports/features/authentication/login/data/modals/login_request_model.dart';
import 'package:sb_myreports/features/authentication/login/domain/usecases/login_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/globals/snack_bar.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._loginUsecase);

  //usecases
  LoginUsecase _loginUsecase;

  //valuenotifiers

  ValueNotifier<bool> loginLoading = ValueNotifier(false);

  //usecases calls
  Future<void> loginUser() async {
    loginLoading.value = false;
    final params = LoginRequestModel(clientId: 1);
    var loginEither = await _loginUsecase(params);
    if (loginEither.isLeft()) {
      handleError(loginEither);
      loginLoading.value = false;
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, previous) async {
        loginLoading.value = false;
      });
    }
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }
}
