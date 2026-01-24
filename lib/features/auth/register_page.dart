//register_page.dart
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final usernameCtrl = TextEditingController();
    final fullNameCtrl = TextEditingController();
    final genderCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

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
                  Text(
                    'Daftar Akun',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD76C82),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Isi data untuk membuat akun',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF5F8B4C),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFE0F0).withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: usernameCtrl,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF5F8B4C),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFE0F0).withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: fullNameCtrl,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF5F8B4C),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFE0F0).withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: genderCtrl,
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF5F8B4C),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFE0F0).withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: passwordCtrl,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF5F8B4C),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFE0F0).withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD76C82),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Akun berhasil dibuat!')),
                                );
                                Navigator.pushReplacementNamed(context, AppRoutes.login);
                              },
                              child: const Text(
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
                  // Footer
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
                          Navigator.pushReplacementNamed(context, AppRoutes.login);
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
