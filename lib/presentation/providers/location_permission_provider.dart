import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final locationPermissionNotifier =
    StateNotifierProvider<LocationPermissionNotifier, LocationPermissionState>(
        (ref) => LocationPermissionNotifier());

class LocationPermissionNotifier
    extends StateNotifier<LocationPermissionState> {
  LocationPermissionNotifier() : super(LocationPermissionState.initial());

  Future<void> requestPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      state = state.copyWith(
          isGranted: status.isGranted,
          isDenied: status.isDenied,
          isPermanentlyDenied: status.isPermanentlyDenied);
    } else if (status.isDenied) {
      final result = await Permission.location.request();
      state = state.copyWith(
        isGranted: result.isGranted,
        isDenied: result.isDenied,
        isPermanentlyDenied: result.isPermanentlyDenied,
      );
    } else if (status.isPermanentlyDenied) {
      state = state.copyWith(
        isPermanentlyDenied: true,
        isDenied: false,
        isGranted: false,
      );
    }
  }

  Future<void> changeIsGranted() async {
    state = state.copyWith(
      isGranted: true,
      isDenied: false,
      isPermanentlyDenied: false,
    );
  }
}

class LocationPermissionState {
  final bool isGranted;
  final bool isDenied;
  final bool isPermanentlyDenied;

  LocationPermissionState({
    required this.isGranted,
    required this.isDenied,
    required this.isPermanentlyDenied,
  });

  factory LocationPermissionState.initial() {
    return LocationPermissionState(
      isGranted: false,
      isDenied: false,
      isPermanentlyDenied: false,
    );
  }

  LocationPermissionState copyWith({
    bool? isGranted,
    bool? isDenied,
    bool? isPermanentlyDenied,
  }) {
    return LocationPermissionState(
      isGranted: isGranted ?? false,
      isDenied: isDenied ?? false,
      isPermanentlyDenied: isPermanentlyDenied ?? false,
    );
  }
}
