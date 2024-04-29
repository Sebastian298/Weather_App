import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod/riverpod.dart';

final locationPermissionNotifier =
    StateNotifierProvider<LocationPermissionNotifier, LocationPermissionState>(
        (ref) => LocationPermissionNotifier());

class LocationPermissionNotifier
    extends StateNotifier<LocationPermissionState> {
  LocationPermissionNotifier() : super(LocationPermissionState.initial());

  Future<void> requestPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      state = state.copyWith(isGranted: true);
    } else if (status.isDenied) {
      final result = await Permission.location.request();
      if (result.isGranted) {
        state = state.copyWith(isGranted: true);
      } else if (result.isPermanentlyDenied) {
        state = state.copyWith(isPermanentlyDenied: true);
      }
    } else if (status.isPermanentlyDenied) {
      state = state.copyWith(isPermanentlyDenied: true);
    }
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
      isGranted: isGranted ?? this.isGranted,
      isDenied: isDenied ?? this.isDenied,
      isPermanentlyDenied: isPermanentlyDenied ?? this.isPermanentlyDenied,
    );
  }
}
