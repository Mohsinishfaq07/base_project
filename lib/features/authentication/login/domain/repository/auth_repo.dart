import 'package:dartz/dartz.dart';
import 'package:sb_myreports/features/authentication/login/data/modals/login_request_model.dart';
import 'package:sb_myreports/features/authentication/login/data/modals/login_response_modal.dart';

import '../../../../../core/error/failures.dart';

abstract class AuthRepository {

  Future<Either<Failure, LoginResponseModel>> loginUser(LoginRequestModel params);


}
