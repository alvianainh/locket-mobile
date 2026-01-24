import '../network/api_client.dart';
import '../storage/secure_storage.dart';

// class AuthService {
//   final api = ApiClient();

//   Future<void> login(String email, String password) async {
//     final res = await api.dio.post(
//       '/auth/login',
//       data: {
//         'email': email,
//         'password': password,
//       },
//     );

//     final token = res.data['access_token'];
//     await SecureStorage.saveToken(token);
//     api.setToken(token);
//   }

//   Future<void> logout() async {
//     await SecureStorage.deleteToken();
//     api.clearToken();
//   }
// }

class AuthService {
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // pura-pura login sukses
  }

  Future<void> logout() async {
    // kosong dulu
  }
}
