import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/legacy.dart';

enum NetworkStatus { online, offline }

class ConnectivityNotifier extends StateNotifier<NetworkStatus> {
  ConnectivityNotifier() : super(NetworkStatus.online) {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        state = NetworkStatus.offline;
      } else {
        state = NetworkStatus.online;
      }
    });
  }
}

final connectivityProvider = StateNotifierProvider<ConnectivityNotifier, NetworkStatus>((ref) {
  return ConnectivityNotifier();
});