import 'package:weather_project/domain/entities/user_log_in_response.dart';

abstract class AuthenticationDataSource {
  Future<UserLogInResponse?> logIn();
  Future<void> logOut();
}
