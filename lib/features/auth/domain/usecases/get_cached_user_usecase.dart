import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../../core/utils/typedefs.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class GetCachedUserUseCase implements UseCase<UserEntity?, NoParams> {
  GetCachedUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  EitherFailure<UserEntity?> call(NoParams params) =>
      _repository.getCachedUser();
}
