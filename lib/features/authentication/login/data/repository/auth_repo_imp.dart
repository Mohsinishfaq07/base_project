import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:sb_myreports/features/authentication/login/data/modals/login_request_model.dart';
import 'package:sb_myreports/features/authentication/login/data/modals/login_response_modal.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/constants/app_messages.dart';
import '../../../../../core/utils/network/network_info.dart';
import '../../domain/repository/auth_repo.dart';
import '../data_sources/login_remote_data_source.dart';


class LoginRepoImp extends AuthRepository {
  final NetworkInfo networkInfo;

  final AuthRemoteDataSource remoteDataSource;

  LoginRepoImp({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.loginUser(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }




}
