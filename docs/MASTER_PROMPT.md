# 🚀 Flutter Master Project Generation Prompt

## كيفية الاستخدام
انسخ الـ Prompt ده كامل وابعته للـ AI Agent (Claude / Cursor / Windsurf / ChatGPT).
الـ Agent هيولّد المشروع كامل بالـ structure المتفق عليه.

---

## 📋 PROMPT — PART 1: Project Structure Generator

```
You are a senior Flutter developer and architect.

Your task is to generate a complete Flutter project skeleton following this exact specification.
Generate ONLY file structure with minimal placeholder Dart code that compiles without errors.
Do NOT implement actual business logic. Focus on structure, imports, and class/abstract definitions only.

═══════════════════════════════════════════
TECH STACK (STRICT — do not deviate)
═══════════════════════════════════════════

State Management  : flutter_bloc (Cubit only — NO Bloc events)
Error Handling    : fpdart (Either<Failure, T> — Left=Failure, Right=Success)
Networking        : dio + retrofit + pretty_dio_logger
Local Storage     : hive + shared_preferences
Secure Storage    : flutter_secure_storage
Routing           : go_router (centralized + route guards)
DI                : get_it (manual registration — NO injectable)
Code Gen          : freezed + json_serializable + build_runner
UI                : flutter_screenutil + skeletonizer
Localization      : easy_localization + intl
Lint              : very_good_analysis
Logging           : logger
Connectivity      : connectivity_plus
Functional        : fpdart
Extra UI          : flutter_svg + lottie

═══════════════════════════════════════════
ARCHITECTURE RULES (STRICT)
═══════════════════════════════════════════

1. Feature-first + Clean Architecture (mixed)
2. Each feature has: data / domain / presentation layers
3. Model ≠ Entity (always separated — use mappers)
4. DTOs for API requests (separate from Models)
5. Repository: abstract interface in domain, implementation in data
6. UseCase: one action per class, returns Either<Failure, T>
7. Cubit: inside presentation/bloc/ folder — never calls API directly
8. State: Freezed union types inside presentation/bloc/ folder
9. Errors: typed Failures (ServerFailure / CacheFailure / NetworkFailure / AuthFailure / UnknownFailure)
10. Token: always injected via interceptor — never passed manually
11. Mapper: always in data/mappers/ — converts Model ↔ Entity
12. safeCall: always wraps async calls in repositories

═══════════════════════════════════════════
NAMING CONVENTION (STRICT)
═══════════════════════════════════════════

Files             : snake_case always
Classes           : PascalCase
Feature files     : {feature}_{type}.dart
  Examples:
    auth_cubit.dart
    auth_state.dart
    login_usecase.dart
    user_model.dart
    user_entity.dart
    user_mapper.dart
    auth_remote_datasource.dart
    auth_repository_impl.dart
    login_request_dto.dart

═══════════════════════════════════════════
EXACT FOLDER STRUCTURE TO GENERATE
═══════════════════════════════════════════

Generate ALL files listed below with placeholder Dart code:

─── assets/  (root level — outside lib/)
    ├── images/
    ├── icons/
    ├── lottie/
    └── translations/
        ├── en.json
        └── ar.json

─── lib/
    │
    ├── core/
    │   │
    │   ├── config/
    │   │   └── app_config.dart
    │   │       // class AppConfig { static const baseUrl = ''; static const connectTimeout = 30000; static const receiveTimeout = 30000; }
    │   │
    │   ├── network/
    │   │   ├── dio_client.dart
    │   │   │   // class DioClient — initializes Dio with interceptors + base options
    │   │   ├── api_response.dart
    │   │   │   // generic class ApiResponse<T> { final T? data; final String? message; final bool success; }
    │   │   ├── endpoint_builder.dart
    │   │   │   // class EndpointBuilder — static methods returning endpoint strings
    │   │   └── interceptors/
    │   │       ├── auth_interceptor.dart
    │   │       │   // injects Bearer token from AuthService into every request
    │   │       ├── logging_interceptor.dart
    │   │       │   // uses pretty_dio_logger
    │   │       └── error_interceptor.dart
    │   │           // maps HTTP errors to Failure types — handles 401/403/500
    │   │
    │   ├── error/
    │   │   ├── failure.dart
    │   │   │   // sealed class Failure — subtypes: ServerFailure, CacheFailure, NetworkFailure, AuthFailure, UnknownFailure
    │   │   ├── exceptions.dart
    │   │   │   // class ServerException, CacheException, NetworkException
    │   │   └── error_handler.dart
    │   │       // class ErrorHandler — maps exceptions to Failure
    │   │
    │   ├── utils/
    │   │   ├── safe_call.dart
    │   │   │   // safeCall<T>() — wraps async in try/catch, returns Either<Failure, T>
    │   │   ├── typedefs.dart
    │   │   │   // type EitherFailure<T> = Future<Either<Failure, T>>
    │   │   ├── helpers.dart
    │   │   └── extensions/
    │   │       ├── context_extensions.dart
    │   │       │   // theme, mediaQuery, navigator helpers on BuildContext
    │   │       ├── string_extensions.dart
    │   │       │   // capitalize, isEmail, isPhone helpers
    │   │       └── navigation_extensions.dart
    │   │           // go, push, pop helpers using GoRouter
    │   │
    │   ├── services/
    │   │   ├── auth_service.dart
    │   │   │   // saveToken / getToken / getRefreshToken / clearToken / isLoggedIn
    │   │   ├── secure_storage_service.dart
    │   │   │   // abstract + implementation using flutter_secure_storage
    │   │   ├── local_storage_service.dart
    │   │   │   // abstract + implementation using hive + shared_preferences
    │   │   ├── cache_service.dart
    │   │   │   // global cache: set / get / remove / clear
    │   │   ├── logger_service.dart
    │   │   │   // wrapper around logger package: d / i / w / e methods
    │   │   └── connectivity_service.dart
    │   │       // stream-based connectivity using connectivity_plus
    │   │
    │   ├── connection/
    │   │   └── network_info.dart
    │   │       // abstract NetworkInfo { Future<bool> get isConnected; }
    │   │       // NetworkInfoImpl using connectivity_plus
    │   │
    │   ├── usecase/
    │   │   ├── base_usecase.dart
    │   │   │   // abstract class UseCase<Type, Params> { EitherFailure<Type> call(Params params); }
    │   │   └── no_params.dart
    │   │       // class NoParams extends Equatable { ... }
    │   │
    │   ├── cubit/
    │   │   └── base_cubit.dart
    │   │       // abstract class BaseCubit<S> extends Cubit<S> with LoggerMixin
    │   │       // handleError(Failure) / safeEmit(S) / isClosed guard
    │   │
    │   ├── mixins/
    │   │   ├── validation_mixin.dart
    │   │   │   // validateEmail / validatePassword / validatePhone / validateRequired
    │   │   └── logger_mixin.dart
    │   │       // mixin LoggerMixin — log / logError / logWarning
    │   │
    │   ├── pagination/
    │   │   ├── paginated_response.dart
    │   │   │   // class PaginatedResponse<T> { final List<T> items; final int total; final int page; final bool hasMore; }
    │   │   └── pagination_params.dart
    │   │       // class PaginationParams { final int page; final int limit; }
    │   │
    │   ├── observers/
    │   │   └── bloc_observer.dart
    │   │       // class AppBlocObserver extends BlocObserver — logs onCreate/onError/onChange
    │   │
    │   ├── constants/
    │   │   ├── app_constants.dart
    │   │   │   // app name, version, storage keys constants
    │   │   └── endpoints.dart
    │   │       // API endpoint constants (use EndpointBuilder)
    │   │
    │   └── theme/
    │       ├── app_colors.dart
    │       │   // primary, secondary, background, surface, error + dark variants
    │       ├── app_text_styles.dart
    │       │   // headingLarge, headingMedium, bodyLarge, bodyMedium, caption, button
    │       ├── app_spacing.dart
    │       │   // xs=4, sm=8, md=16, lg=24, xl=32, xxl=48
    │       ├── app_radius.dart
    │       │   // sm=4, md=8, lg=12, xl=16, full=999
    │       ├── app_shadows.dart
    │       │   // small, medium, large BoxShadow lists
    │       ├── app_animations.dart
    │       │   // fast=150ms, normal=300ms, slow=500ms + standard Curves
    │       ├── app_breakpoints.dart
    │       │   // mobile=480, tablet=768, desktop=1024
    │       ├── light_theme.dart
    │       │   // ThemeData for light mode
    │       ├── dark_theme.dart
    │       │   // ThemeData for dark mode
    │       └── app_theme.dart
    │           // exports both themes — used in MaterialApp
    │
    ├── config/
    │   ├── router/
    │   │   ├── app_router.dart
    │   │   │   // GoRouter instance with all routes + redirect logic
    │   │   ├── route_names.dart
    │   │   │   // class RouteNames — static const strings for all route paths
    │   │   └── route_guard.dart
    │   │       // redirect: check isLoggedIn + hasSeenOnboarding → route accordingly
    │   │
    │   └── localization/
    │       ├── locale_keys.dart
    │       │   // generated key constants (AuthKeys.login, CommonKeys.loading, etc.)
    │       └── locale_manager.dart
    │           // changeLocale / getSavedLocale / supportedLocales
    │
    ├── features/
    │   │
    │   ├── splash/
    │   │   └── presentation/
    │   │       ├── bloc/
    │   │       │   ├── splash_cubit.dart
    │   │       │   │   // checkAuth() → navigate based on auth state
    │   │       │   └── splash_state.dart
    │   │       │       // @freezed: initial / navigateToOnboarding / navigateToHome / navigateToAuth
    │   │       └── pages/
    │   │           └── splash_page.dart
    │   │               // shows logo + animates → uses SplashCubit
    │   │
    │   ├── onboarding/
    │   │   └── presentation/
    │   │       ├── bloc/
    │   │       │   ├── onboarding_cubit.dart
    │   │       │   │   // nextPage / skip / complete
    │   │       │   └── onboarding_state.dart
    │   │       │       // @freezed: { int currentPage, bool isLastPage, bool isCompleted }
    │   │       ├── pages/
    │   │       │   └── onboarding_page.dart
    │   │       │       // PageView with 3 items, skip + next buttons
    │   │       └── widgets/
    │   │           ├── onboarding_item.dart
    │   │           │   // single page: lottie + title + description
    │   │           └── onboarding_indicator.dart
    │   │               // animated dots indicator
    │   │
    │   └── auth/
    │       ├── auth_injection.dart
    │       │   // registers all auth-specific dependencies into get_it
    │       │
    │       ├── data/
    │       │   ├── models/
    │       │   │   ├── user_model.dart
    │       │   │   │   // @JsonSerializable — fromJson / toJson
    │       │   │   ├── token_model.dart
    │       │   │   │   // @JsonSerializable — accessToken / refreshToken / expiresAt
    │       │   │   ├── login_request_dto.dart
    │       │   │   │   // email + password
    │       │   │   └── register_request_dto.dart
    │       │   │       // name + email + password + confirmPassword
    │       │   │
    │       │   ├── datasource/
    │       │   │   ├── auth_remote_datasource.dart
    │       │   │   │   // abstract + impl using Retrofit/Dio
    │       │   │   └── auth_local_datasource.dart
    │       │   │       // abstract + impl using AuthService / CacheService
    │       │   │
    │       │   ├── mappers/
    │       │   │   ├── user_mapper.dart
    │       │   │   │   // UserModel → UserEntity
    │       │   │   └── token_mapper.dart
    │       │   │       // TokenModel → TokenEntity
    │       │   │
    │       │   └── repository/
    │       │       └── auth_repository_impl.dart
    │       │           // implements AuthRepository using safeCall + NetworkInfo check
    │       │
    │       ├── domain/
    │       │   ├── entities/
    │       │   │   ├── user_entity.dart
    │       │   │   │   // extends Equatable — pure domain object
    │       │   │   └── token_entity.dart
    │       │   │       // extends Equatable
    │       │   │
    │       │   ├── repository/
    │       │   │   └── auth_repository.dart
    │       │   │       // abstract class AuthRepository — defines all auth contracts
    │       │   │
    │       │   └── usecases/
    │       │       ├── login_usecase.dart
    │       │       ├── register_usecase.dart
    │       │       ├── logout_usecase.dart
    │       │       └── get_cached_user_usecase.dart
    │       │
    │       └── presentation/
    │           ├── bloc/
    │           │   ├── auth_cubit.dart
    │           │   │   // login / register / logout — uses UseCases only
    │           │   └── auth_state.dart
    │           │       // @freezed: initial / loading / authenticated(UserEntity) / unauthenticated / error(String)
    │           ├── pages/
    │           │   ├── login_page.dart
    │           │   └── register_page.dart
    │           └── widgets/
    │               ├── login_form.dart
    │               └── register_form.dart
    │
    ├── shared/
    │   ├── widgets/
    │   │   ├── loading_widget.dart
    │   │   │   // centered CircularProgressIndicator with optional message
    │   │   ├── error_widget.dart
    │   │   │   // shows error message + retry button callback
    │   │   ├── empty_widget.dart
    │   │   │   // lottie animation + message for empty states
    │   │   ├── state_renderer.dart
    │   │   │   // StateRenderer widget: maps Cubit state → correct widget automatically
    │   │   └── network_image_widget.dart
    │   │       // CachedNetworkImage with loading + error placeholder
    │   │
    │   └── components/
    │       ├── app_button.dart
    │       │   // AppButton: primary / secondary / outline / text variants
    │       ├── app_text_field.dart
    │       │   // AppTextField: with label, hint, prefix, suffix, error, obscure toggle
    │       ├── app_appbar.dart
    │       │   // AppAppBar: custom AppBar with back button + actions
    │       ├── app_dialog.dart
    │       │   // showAppDialog helper: title + message + actions
    │       ├── app_bottom_sheet.dart
    │       │   // showAppBottomSheet helper: draggable + styled
    │       └── app_snackbar.dart
    │           // showSuccess / showError / showInfo snackbar helpers
    │
    ├── app.dart
    │   // MaterialApp.router with GoRouter, themes, localization, ScreenUtil init
    │
    └── main.dart
        // runApp — initializes: WidgetsFlutterBinding, ScreenUtil, EasyLocalization,
        //          get_it (injection_container), BlocObserver, then runs App()

═══════════════════════════════════════════
LOCALIZATION JSON STRUCTURE
═══════════════════════════════════════════

en.json:
{
  "common": {
    "loading": "Loading...",
    "error": "Something went wrong",
    "retry": "Retry",
    "empty": "No data found",
    "save": "Save",
    "cancel": "Cancel",
    "confirm": "Confirm",
    "back": "Back"
  },
  "auth": {
    "login": "Login",
    "register": "Register",
    "logout": "Logout",
    "email": "Email",
    "password": "Password",
    "name": "Full Name",
    "confirm_password": "Confirm Password",
    "login_success": "Logged in successfully",
    "register_success": "Registered successfully",
    "invalid_email": "Please enter a valid email",
    "invalid_password": "Password must be at least 8 characters"
  },
  "onboarding": {
    "skip": "Skip",
    "next": "Next",
    "get_started": "Get Started",
    "page1_title": "Welcome",
    "page1_desc": "Discover amazing features",
    "page2_title": "Easy to Use",
    "page2_desc": "Simple and intuitive design",
    "page3_title": "Get Started",
    "page3_desc": "Join us today"
  }
}

═══════════════════════════════════════════
PUBSPEC.YAML DEPENDENCIES TO INCLUDE
═══════════════════════════════════════════

dependencies:
  flutter_bloc: ^8.1.6
  bloc: ^8.1.4
  get_it: ^8.0.2
  fpdart: ^1.1.0
  equatable: ^2.0.5
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  dio: ^5.7.0
  retrofit: ^4.4.1
  pretty_dio_logger: ^1.4.0
  flutter_secure_storage: ^9.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.3.3
  easy_localization: ^3.0.7
  intl: ^0.19.0
  flutter_screenutil: ^5.9.3
  go_router: ^14.6.2
  skeletonizer: ^1.4.2
  flutter_svg: ^2.0.16
  lottie: ^3.1.3
  logger: ^2.5.0
  connectivity_plus: ^6.1.1
  jwt_decoder: ^2.0.1
  cached_network_image: ^3.4.1
  flutter_native_splash: ^2.4.3
  package_info_plus: ^8.1.2
  url_launcher: ^6.3.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  very_good_analysis: ^6.0.0
  build_runner: ^2.4.13
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  retrofit_generator: ^9.1.6

═══════════════════════════════════════════
OUTPUT INSTRUCTIONS
═══════════════════════════════════════════

For each file, output:
1. The full file path (relative to project root)
2. Complete Dart placeholder code that:
   - Has correct imports
   - Defines the class/abstract with correct signatures
   - Has empty method bodies that return correct types
   - Compiles without errors
   - Has a comment explaining the file's responsibility

Start with pubspec.yaml, then main.dart, then app.dart, then go layer by layer.
```

---

## 📋 PROMPT — PART 2: New Feature Generator

استخدم الـ Prompt ده لما تيجي تضيف feature جديدة لأي مشروع.

```
You are a senior Flutter developer.
You know this project's architecture (Feature-first + Clean Architecture).

Generate a complete feature named: [FEATURE_NAME]

The feature must include:

DATA LAYER:
- [FeatureName]Model (@JsonSerializable — matches API response)
- [ActionName]RequestDto (for each API action that sends data)
- [FeatureName]RemoteDataSource (abstract + impl using Dio/Retrofit)
- [FeatureName]LocalDataSource (abstract + impl using CacheService/Hive)
- [FeatureName]Mapper (Model → Entity converter)
- [FeatureName]RepositoryImpl (uses safeCall + NetworkInfo check)

DOMAIN LAYER:
- [FeatureName]Entity (extends Equatable — pure domain)
- [FeatureName]Repository (abstract interface)
- UseCases: one class per action (get / create / update / delete / etc.)
  Each returns: Future<Either<Failure, ReturnType>>

PRESENTATION LAYER:
- [FeatureName]State (@freezed union: initial / loading / success(data) / error(message))
- [FeatureName]Cubit (extends BaseCubit — uses UseCases only, never DataSource)
- [FeatureName]Page (BlocConsumer or BlocBuilder — handles all states)
- Widgets as needed

DI:
- [feature_name]_injection.dart (registers all dependencies for this feature)
- Add to injection_container.dart

ROUTER:
- Add route to app_router.dart
- Add route name to route_names.dart

RULES:
- Cubit never calls DataSource or Repository directly — always through UseCase
- Repository always uses safeCall() wrapper
- Repository always checks NetworkInfo before remote calls
- Model ≠ Entity — always use Mapper
- State uses freezed union types
- Cubit extends BaseCubit

Feature API description:
[DESCRIBE YOUR API ENDPOINTS HERE]

Example:
GET /api/products → returns list of products
POST /api/products → creates product (name, price, description)
DELETE /api/products/:id → deletes product
```

---

## 📋 PROMPT — PART 3: Fix / Modify Existing Code

```
You are a senior Flutter developer working on this project.

Project Architecture: Feature-first + Clean Architecture
State Management: Cubit + Freezed
Error Handling: fpdart Either<Failure, T>
DI: get_it (manual)
Router: go_router

STRICT RULES — never violate:
1. Cubit → UseCase → Repository → DataSource (never skip layers)
2. Model ≠ Entity (always use Mapper)
3. All async in Repository must use safeCall()
4. States are Freezed union types
5. DI via constructor injection (never getIt inside classes except injection files)
6. Failures are typed (ServerFailure / NetworkFailure / CacheFailure / AuthFailure)

Task: [DESCRIBE WHAT YOU WANT TO FIX OR MODIFY]

File(s) involved: [LIST THE FILES]

Current code: [PASTE CURRENT CODE]
```
