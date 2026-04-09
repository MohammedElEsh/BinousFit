import 'package:flutter_bloc/flutter_bloc.dart';

import '../error/failure.dart';
import '../mixins/logger_mixin.dart';

/// Base cubit with safe emit and failure handling hooks.
abstract class BaseCubit<S> extends Cubit<S> with LoggerMixin {
  BaseCubit(super.initialState);

  void handleError(Failure failure) {
    logError(failure.message ?? failure.runtimeType.toString());
  }

  void safeEmit(S state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
