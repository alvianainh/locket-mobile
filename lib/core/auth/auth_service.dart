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






// class AuthService {
//   Future<void> login(String email, String password) async {
//     await Future.delayed(const Duration(milliseconds: 500));
//   }

//   Future<void> logout() async {
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/secure_storage.dart';
import '../config/api_config.dart';

class AuthService {
  static Future<String> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/login');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final token = data['access_token'];

      await SecureStorage.saveToken(token);

      final saved = await SecureStorage.getToken();
      print('TOKEN SAVED: $saved');

      return token;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['detail'] ?? 'Login gagal');
    }
  }
}


