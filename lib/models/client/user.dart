import 'http_instance.dart';

class User with HttpInstance {
  Future<dynamic> authenticate(Map<String, dynamic> values) {
    return post('/auth/v1/authenticate', body: values);
  }

  Future<dynamic> authenticateWithGoogle(Map<String, dynamic> values) {
    return post('/auth/v1/authenticate/google', body: values);
  }

  Future<dynamic> authenticateUserFromApple(Map<String, dynamic> values) {
    return post('/auth/v1/authenticate/apple', body: values);
  }

  Future<dynamic> getUser(String userId) {
    return get("/auth/v1/user/$userId}");
  }
}
