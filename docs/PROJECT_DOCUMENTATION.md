# 📚 Flutter Project — Architecture Documentation

> هذا الملف للـ AI Agent.
> في بداية كل محادثة جديدة، ابعت للـ Agent هذا الملف كامل وقوله:
> "هذا هو مشروعي — اقرأ الـ documentation قبل أي تعديل."

---

## 🏗️ Architecture Overview

```
Feature-first + Clean Architecture (mixed)
```

كل feature مستقلة تماماً وتحتوي على 3 layers:

```
feature/
  data/         ← API + Local + Models + DTOs + Mappers + Repository Impl
  domain/       ← Entities + Repository Interface + UseCases
  presentation/ ← Cubit + State + Pages + Widgets
```

---

## 🔄 Data Flow (STRICT — never skip layers)

```
UI (Page)
  ↓ calls
Cubit
  ↓ calls
UseCase
  ↓ calls
Repository (abstract)
  ↓ implemented by
RepositoryImpl
  ↓ calls
DataSource (Remote / Local)
  ↓
API (Dio/Retrofit) OR Local (Hive/SharedPreferences)

← Error path:
Exception → safeCall → Left(Failure) → Cubit → State.error → UI
← Success path:
Response → Model → Mapper → Entity → Right(Entity) → Cubit → State.success → UI
```

---

## 📦 Tech Stack

| Concern | Package | Notes |
|---|---|---|
| State Management | flutter_bloc (Cubit) | NO Bloc events — Cubit only |
| Error Handling | fpdart | Either<Failure, T> always |
| Networking | dio + retrofit | Shared DioClient |
| Local DB | hive + hive_flutter | Feature-specific boxes |
| Preferences | shared_preferences | Simple key-value |
| Secure Storage | flutter_secure_storage | Tokens only |
| Routing | go_router | Centralized with guards |
| DI | get_it | Manual registration |
| Code Gen | freezed + json_serializable | Run build_runner after changes |
| UI Responsive | flutter_screenutil | Always use .w / .h / .sp |
| Localization | easy_localization | JSON files in assets/translations/ |
| Logging | logger (via LoggerService) | Never use print() |
| Connectivity | connectivity_plus | Via NetworkInfo abstraction |
| Loading UI | skeletonizer | Wrap lists/cards |
| Lint | very_good_analysis | Strict — fix all warnings |

---

## 📁 Full Folder Structure

```
project_root/
│
assets/
  images/
  icons/
  lottie/
  translations/
    en.json
    ar.json
│
lib/
  core/
    config/
      app_config.dart          ← baseUrl, timeouts, app settings
    network/
      dio_client.dart          ← Dio singleton with all interceptors
      api_response.dart        ← Generic ApiResponse<T> wrapper
      endpoint_builder.dart    ← Static endpoint string builders
      interceptors/
        auth_interceptor.dart  ← Auto-injects Bearer token
        logging_interceptor.dart
        error_interceptor.dart ← Maps HTTP errors → Failure types
    error/
      failure.dart             ← Sealed class + all Failure subtypes
      exceptions.dart          ← ServerException, CacheException, etc.
      error_handler.dart       ← Maps Exception → Failure
    utils/
      safe_call.dart           ← safeCall<T>() — wraps async safely
      typedefs.dart            ← EitherFailure<T> type alias
      helpers.dart
      extensions/
        context_extensions.dart
        string_extensions.dart
        navigation_extensions.dart
    services/
      auth_service.dart        ← saveToken/getToken/clearToken/isLoggedIn
      secure_storage_service.dart
      local_storage_service.dart
      cache_service.dart       ← Global cache layer
      logger_service.dart      ← d/i/w/e wrappers
      connectivity_service.dart ← Real-time connectivity stream
    connection/
      network_info.dart        ← Abstract + impl (isConnected)
    usecase/
      base_usecase.dart        ← Abstract UseCase<Type, Params>
      no_params.dart           ← NoParams extends Equatable
    cubit/
      base_cubit.dart          ← Abstract BaseCubit with helpers
    mixins/
      validation_mixin.dart    ← Form validators
      logger_mixin.dart        ← Logging mixin
    pagination/
      paginated_response.dart
      pagination_params.dart
    observers/
      bloc_observer.dart       ← AppBlocObserver — logs all transitions
    constants/
      app_constants.dart
      endpoints.dart
    theme/
      app_colors.dart
      app_text_styles.dart
      app_spacing.dart
      app_radius.dart
      app_shadows.dart
      app_animations.dart
      app_breakpoints.dart
      light_theme.dart
      dark_theme.dart
      app_theme.dart
    di/
      injection_container.dart ← Registers ALL core dependencies

  config/
    router/
      app_router.dart          ← GoRouter instance
      route_names.dart         ← All route path constants
      route_guard.dart         ← Auth + onboarding redirect logic
    localization/
      locale_keys.dart         ← Key constants (generated)
      locale_manager.dart      ← changeLocale / getSavedLocale

  features/
    splash/
      presentation/
        bloc/
          splash_cubit.dart
          splash_state.dart
        pages/
          splash_page.dart

    onboarding/
      presentation/
        bloc/
          onboarding_cubit.dart
          onboarding_state.dart
        pages/
          onboarding_page.dart
        widgets/
          onboarding_item.dart
          onboarding_indicator.dart

    auth/
      auth_injection.dart      ← Feature-specific DI
      data/
        models/
          user_model.dart
          token_model.dart
          login_request_dto.dart
          register_request_dto.dart
        datasource/
          auth_remote_datasource.dart
          auth_local_datasource.dart
        mappers/
          user_mapper.dart
          token_mapper.dart
        repository/
          auth_repository_impl.dart
      domain/
        entities/
          user_entity.dart
          token_entity.dart
        repository/
          auth_repository.dart
        usecases/
          login_usecase.dart
          register_usecase.dart
          logout_usecase.dart
          get_cached_user_usecase.dart
      presentation/
        bloc/
          auth_cubit.dart
          auth_state.dart
        pages/
          login_page.dart
          register_page.dart
        widgets/
          login_form.dart
          register_form.dart

  shared/
    widgets/
      loading_widget.dart
      error_widget.dart
      empty_widget.dart
      state_renderer.dart      ← Maps state → correct widget
      network_image_widget.dart
    components/
      app_button.dart
      app_text_field.dart
      app_appbar.dart
      app_dialog.dart
      app_bottom_sheet.dart
      app_snackbar.dart

  app.dart                     ← MaterialApp.router setup
  main.dart                    ← App entry point + initialization
```

---

## 🧩 Key Patterns & Code Contracts

### 1. Failure Types
```dart
sealed class Failure extends Equatable {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure { ... }
class NetworkFailure extends Failure { ... }
class CacheFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
class UnknownFailure extends Failure { ... }
```

### 2. UseCase Contract
```dart
abstract class UseCase<Type, Params> {
  EitherFailure<Type> call(Params params);
}
// EitherFailure<T> = Future<Either<Failure, T>>
```

### 3. safeCall Pattern (used in ALL repositories)
```dart
Future<Either<Failure, T>> safeCall<T>(
  Future<T> Function() call,
) async {
  try {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure('No internet connection'));
    }
    return Right(await call());
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } on CacheException catch (e) {
    return Left(CacheFailure(e.message));
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}
```

### 4. Freezed State Pattern (ALL cubits use this)
```dart
@freezed
class FeatureState with _$FeatureState {
  const factory FeatureState.initial() = _Initial;
  const factory FeatureState.loading() = _Loading;
  const factory FeatureState.success(EntityType data) = _Success;
  const factory FeatureState.error(String message) = _Error;
}
```

### 5. Cubit Pattern
```dart
class FeatureCubit extends BaseCubit<FeatureState> {
  final FeatureUseCase _useCase;

  FeatureCubit(this._useCase) : super(const FeatureState.initial());

  Future<void> doAction(Params params) async {
    safeEmit(const FeatureState.loading());
    final result = await _useCase(params);
    result.fold(
      (failure) => safeEmit(FeatureState.error(failure.message)),
      (data) => safeEmit(FeatureState.success(data)),
    );
  }
}
```

### 6. Repository Impl Pattern
```dart
class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureRemoteDataSource _remote;
  final FeatureLocalDataSource _local;
  final NetworkInfo _networkInfo;
  final FeatureMapper _mapper;

  @override
  EitherFailure<EntityType> getFeature(Params params) async {
    return safeCall(() async {
      if (!await _networkInfo.isConnected) {
        final cached = await _local.getCached();
        return _mapper.toEntity(cached);
      }
      final model = await _remote.fetch(params);
      await _local.cache(model);
      return _mapper.toEntity(model);
    });
  }
}
```

### 7. Mapper Pattern
```dart
class FeatureMapper {
  EntityType toEntity(FeatureModel model) {
    return EntityType(
      id: model.id,
      name: model.name,
      // ... map all fields
    );
  }

  FeatureModel toModel(EntityType entity) {
    return FeatureModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
```

### 8. Feature Injection Pattern
```dart
// feature_name_injection.dart
void initFeatureInjection() {
  // DataSources
  getIt.registerLazySingleton<FeatureRemoteDataSource>(
    () => FeatureRemoteDataSourceImpl(getIt()),
  );
  // Repository
  getIt.registerLazySingleton<FeatureRepository>(
    () => FeatureRepositoryImpl(getIt(), getIt(), getIt(), getIt()),
  );
  // UseCases
  getIt.registerFactory(() => FeatureUseCase(getIt()));
  // Cubit
  getIt.registerFactory(() => FeatureCubit(getIt()));
}
```

---

## 🚦 Routing Logic

```dart
// route_guard.dart
redirect: (context, state) {
  final isLoggedIn = getIt<AuthService>().isLoggedIn;
  final hasSeenOnboarding = getIt<LocalStorageService>()
      .get(AppConstants.hasSeenOnboardingKey) ?? false;

  if (!hasSeenOnboarding) return RouteNames.onboarding;
  if (!isLoggedIn) return RouteNames.login;
  return null; // no redirect
}
```

### Route Names
```dart
class RouteNames {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
}
```

---

## 🌍 Localization

JSON key structure:
```json
{
  "common": { "loading": "...", "error": "...", "retry": "..." },
  "auth": { "login": "...", "email": "..." },
  "onboarding": { "skip": "...", "next": "..." }
}
```

Usage in code:
```dart
Text(LocaleKeys.auth_login.tr())
```

Supported locales: `en`, `ar`
RTL: supported via `Directionality` in MaterialApp

---

## 📏 UI Guidelines

- Always use `ScreenUtil`: `16.w`, `16.h`, `14.sp`
- Spacing: use `AppSpacing.md` (16), `AppSpacing.sm` (8), etc.
- Colors: use `AppColors.primary`, never hardcode hex
- Text: use `AppTextStyles.bodyMedium`, never hardcode fontSize
- Loading: use `skeletonizer` or `LoadingWidget`
- Empty states: use `EmptyWidget` with lottie
- Errors: use `ErrorWidget` with retry callback
- Dialogs: use `showAppDialog()` helper
- Snackbars: use `showSuccess()` / `showError()` helpers
- Images from network: always use `NetworkImageWidget`

---

## ⚠️ Rules — NEVER Violate

```
❌ Cubit calls DataSource directly
❌ Cubit calls Repository directly
❌ UI contains business logic
❌ Model used instead of Entity in domain/presentation
❌ getIt<X>() called inside non-injection files
❌ print() used instead of LoggerService
❌ try/catch in Cubit (use safeCall in Repository)
❌ Token passed manually (use AuthInterceptor)
❌ Hardcoded colors/sizes in UI
❌ Skipping NetworkInfo check before remote calls
❌ Two features sharing a DataSource
```

---

## ✅ Checklist — Adding a New Feature

```
[ ] Create folder: features/feature_name/
[ ] Create: data/models/feature_model.dart (@JsonSerializable)
[ ] Create: data/models/feature_request_dto.dart (if POST/PUT)
[ ] Create: data/datasource/feature_remote_datasource.dart (abstract + impl)
[ ] Create: data/datasource/feature_local_datasource.dart (abstract + impl)
[ ] Create: data/mappers/feature_mapper.dart
[ ] Create: data/repository/feature_repository_impl.dart (uses safeCall)
[ ] Create: domain/entities/feature_entity.dart (extends Equatable)
[ ] Create: domain/repository/feature_repository.dart (abstract)
[ ] Create: domain/usecases/*.dart (one file per action)
[ ] Create: presentation/bloc/feature_state.dart (@freezed union)
[ ] Create: presentation/bloc/feature_cubit.dart (extends BaseCubit)
[ ] Create: presentation/pages/feature_page.dart
[ ] Create: presentation/widgets/*.dart (as needed)
[ ] Create: feature_injection.dart (register all dependencies)
[ ] Update: di/injection_container.dart (call feature injection)
[ ] Update: config/router/app_router.dart (add route)
[ ] Update: config/router/route_names.dart (add route name)
[ ] Update: assets/translations/en.json + ar.json (add keys)
[ ] Run: flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🔧 Commands Reference

```bash
# Generate code (freezed, json, retrofit)
flutter pub run build_runner build --delete-conflicting-outputs

# Run app
flutter run

# Analyze code
flutter analyze

# Run tests
flutter test
```

---

## 📝 Notes for AI Agent

When modifying this project:

1. **Always read this document first** before writing any code.
2. **Never skip architecture layers** — every flow must go UI → Cubit → UseCase → Repository → DataSource.
3. **Always use safeCall** in Repository implementations.
4. **Always separate Model and Entity** — use Mapper to convert.
5. **Always use Freezed** for states — no manual copyWith.
6. **Always register in DI** — never instantiate classes manually outside injection files.
7. **Always add translations** to both en.json and ar.json.
8. **Always use AppColors, AppTextStyles, AppSpacing** — never hardcode values.
9. **Run build_runner** after any changes to freezed or json_serializable files.
10. **Check very_good_analysis warnings** — fix all of them.
