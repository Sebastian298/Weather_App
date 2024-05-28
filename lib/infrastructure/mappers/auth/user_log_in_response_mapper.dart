import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_project/domain/entities/user_log_in_response.dart';

class UserLogInResponseMapper {
  static UserLogInResponse? castToEntity(User? user) {
    if (user == null) return null;
    return UserLogInResponse(
      id: user.uid,
      email: user.email,
      name: user.displayName,
      photoUrl: user.photoURL,
    );
  }
}
