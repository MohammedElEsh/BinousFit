/// Builds endpoint path strings from segments.
class EndpointBuilder {
  EndpointBuilder._();

  static String auth(String action) => '/auth/$action';
}
