import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/connectivity_service.dart';

/// Whether the device has a usable network connection.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._connectivityService);

  final ConnectivityService _connectivityService;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivityService.checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
}
