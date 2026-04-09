import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../../core/utils/typedefs.dart';
import '../repository/auth_repository.dart';

class LogoutUseCase implements UseCase<Unit, NoParams> {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  EitherFailure<Unit> call(NoParams params) => _repository.logout();
}
