import '../network/endpoint_builder.dart';

/// API path constants; prefer [EndpointBuilder] for composition.
class Endpoints {
  Endpoints._();

  static String get login => EndpointBuilder.auth('login');
  static String get register => EndpointBuilder.auth('register');
  static String get refresh => EndpointBuilder.auth('refresh');
}
