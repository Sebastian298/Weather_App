import 'package:weather_project/domain/entities/user_log_in_response.dart';

abstract class AuthenticationRepository {
  Future<UserLogInResponse?> logIn();
  Future<void> logOut();
}
