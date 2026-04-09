import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Exposes connectivity as a stream for UI or guards.
class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;

  Future<List<ConnectivityResult>> checkConnectivity() =>
      _connectivity.checkConnectivity();
}
