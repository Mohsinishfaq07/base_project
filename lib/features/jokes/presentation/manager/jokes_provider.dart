import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sb_myreports/core/router/app_state.dart';
import 'package:sb_myreports/core/router/models/page_config.dart';
import 'package:sb_myreports/core/usecases/usecase.dart';
import 'package:sb_myreports/features/authentication/login/data/modals/login_request_model.dart';
import 'package:sb_myreports/features/authentication/login/domain/usecases/login_usecase.dart';
import 'package:sb_myreports/features/jokes/data/models/get_query_jokes_request_model.dart';
import 'package:sb_myreports/features/jokes/data/models/get_query_jokes_response_model.dart';
import 'package:sb_myreports/features/jokes/data/models/get_random_joke_response_model.dart';
import 'package:sb_myreports/features/jokes/domain/use_cases/get_query_jokes.dart';
import 'package:sb_myreports/features/jokes/domain/use_cases/get_random_joke.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/globals/globals.dart';
import '../../../../../core/utils/globals/snack_bar.dart';

class JokesProvider extends ChangeNotifier {
  JokesProvider(this._getRandomJokeUsecase, this._getQueryJokesUsecase);

  //usecases
  GetRandomJokeUsecase _getRandomJokeUsecase;
  GetQueryJokesUsecase _getQueryJokesUsecase;

  //valuenotifiers

  ValueNotifier<bool> randomJokeLoading = ValueNotifier(false);
  ValueNotifier<bool> queryJokeLoading = ValueNotifier(false);

  //properties

  GetRandomJokeResponseModel? getRandomJokeResponseModel;
  GetQueryJokesResponseModel? getQueryJokesResponseModel;

  //usecases calls
  Future<void> getRandomJoke() async {
    randomJokeLoading.value = true;

    var loginEither = await _getRandomJokeUsecase(NoParams());
    if (loginEither.isLeft()) {
      handleError(loginEither);
      randomJokeLoading.value = false;
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, previous) async {
        getRandomJokeResponseModel = response;
        randomJokeLoading.value = false;
      });
    }
  }

  Future<void> getQueryJokes(String query) async {
    queryJokeLoading.value = true;
    final params = GetQueryJokesRequestModel(query: query);

    var loginEither = await _getQueryJokesUsecase(params);
    if (loginEither.isLeft()) {
      handleError(loginEither);
      queryJokeLoading.value = false;
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, previous) async {


        print(response.result.length);
        getQueryJokesResponseModel = response;

        queryJokeLoading.value = false;

        if(getQueryJokesResponseModel!.result.isEmpty){
          return ShowSnackBar.show('No joke found for this query');
        }else{
          AppState appState=sl();
          appState.goToNext(PageConfigs.jokeListPageConfig);
        }
      });
    }
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }
}
