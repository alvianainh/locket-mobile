//register_page.dart
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../core/config/api_config.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final fullNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String? selectedGender;
  bool isLoading = false;

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Color(0xFF5F8B4C),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: const Color(0xFFFFE0F0).withOpacity(0.3),
    );
  }

  TextStyle inputTextStyle = const TextStyle(
    fontFamily: 'Poppins',
    color: Color(0xFF5F8B4C),
  );

  Future<void> register() async {
    if (emailCtrl.text.isEmpty ||
        usernameCtrl.text.isEmpty ||
        fullNameCtrl.text.isEmpty ||
        passwordCtrl.text.isEmpty ||
        selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua field wajib diisi')),
      );
      return;
    }

    final baseUrl = ApiConfig.baseUrl;

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: jsonEncode({
          "email": emailCtrl.text.trim(),
          "username": usernameCtrl.text.trim(),
          "full_name": fullNameCtrl.text.trim(),
          "gender": selectedGender,
          "password": passwordCtrl.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun berhasil dibuat!')),
        );

        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error['detail'] ?? 'Register gagal'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0F0), Color(0xFFDFFFE0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD76C82),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Daftar Akun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD76C82),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Isi data untuk membuat akun',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xFF5F8B4C),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            style: inputTextStyle,
                            decoration: inputDecoration('Email'),
                          ),
                          const SizedBox(height: 16),

                          TextField(
                            controller: usernameCtrl,
                            style: inputTextStyle,
                            decoration: inputDecoration('Username'),
                          ),
                          const SizedBox(height: 16),

                          TextField(
                            controller: fullNameCtrl,
                            style: inputTextStyle,
                            decoration: inputDecoration('Full Name'),
                          ),
                          const SizedBox(height: 16),

                          DropdownButtonFormField<String>(
                            value: selectedGender,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            style: inputTextStyle,
                            dropdownColor: Colors.white,
                            decoration: inputDecoration('Gender'),

                            items: const [
                              DropdownMenuItem(
                                value: 'female',
                                child: Text(
                                  'Princess',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'male',
                                child: Text(
                                  'Male',
                                  style: TextStyle(fontFamily: 'Poppins'),
                                ),
                              ),
                            ],

                            onChanged: (value) {
                              setState(() => selectedGender = value);
                            },
                          ),
                          const SizedBox(height: 16),

                          TextField(
                            controller: passwordCtrl,
                            obscureText: true,
                            style: inputTextStyle,
                            decoration: inputDecoration('Password'),
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD76C82),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: isLoading ? null : register,
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      'Daftar',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFFF5F2),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// FOOTER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun? ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF5F8B4C),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.login,
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD76C82),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
