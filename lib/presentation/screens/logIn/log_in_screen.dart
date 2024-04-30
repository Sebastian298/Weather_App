import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:weather_project/presentation/providers/location_permission_provider.dart';

class LogInScreen extends ConsumerStatefulWidget {
  static const String name = 'log_in';
  const LogInScreen({super.key});

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends ConsumerState<LogInScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    ref.read(locationPermissionNotifier.notifier).requestPermission();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final statusPermission = await Permission.location.status;
      if (statusPermission.isPermanentlyDenied) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            managePermantlyDeniedPermission(context);
          }
        });
      } else {
        final status = await Permission.location.status;
        if (status.isGranted) {
          ref.read(locationPermissionNotifier.notifier).changeIsGranted();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationPermissionNotifier);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Esse non consectetur et enim quis ea adipisicing aute dolore laboris deserunt nisi dsada dsadas dsadasaa.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo_logIn.jpg'),
                    fit: BoxFit.cover,
                    scale: 0.5,
                  ),
                ),
              ),
              Column(
                children: [
                  SignInButton(
                    Buttons.google,
                    onPressed: locationState.isGranted
                        ? () {
                            //TODO: Implement Google Sign In
                          }
                        : () {
                            if (locationState.isPermanentlyDenied) {
                              openAppSettings();
                            } else {
                              ref
                                  .read(locationPermissionNotifier.notifier)
                                  .requestPermission();
                            }
                          },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> managePermantlyDeniedPermission(BuildContext context) async {
  if (context.mounted) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text('Please enable location permission in settings'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
