//caption_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../data/photo_store.dart';

class CaptionPage extends StatelessWidget {
  const CaptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final captionCtrl = TextEditingController();

    final String? imagePath = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambahkan Caption',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFFD76C82),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFD76C82)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath),
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 24),
              Card(
                color: Colors.white.withOpacity(0.9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: captionCtrl,
                    decoration: InputDecoration(
                      hintText: 'Tulis caption...',
                      hintStyle: const TextStyle(
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
                    maxLines: 3,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (imagePath != null) {
                      PhotoStore.addPhoto(
                        imageUrl: imagePath,
                        caption: captionCtrl.text,
                      );

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.gallery,
                        (route) => false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD76C82),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFFF8F4EC),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
