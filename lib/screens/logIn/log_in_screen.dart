import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LogInScreen extends StatelessWidget {
  static const String name = 'log_in';
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Column(
                children: [
                  _SignInGoogleButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SignInGoogleButton extends StatelessWidget {
  const _SignInGoogleButton();

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.google,
      onPressed: () {},
    );
  }
}
