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

    // ambil path foto dari args
    final String? imagePath = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Caption')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (imagePath != null)
              Image.file(
                File(imagePath),
                height: 250,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            TextField(
              controller: captionCtrl,
              decoration: const InputDecoration(
                hintText: 'Tulis caption...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (imagePath != null) {
                  PhotoStore.addPhoto(
                    imageUrl: imagePath, // pakai path lokal
                    caption: captionCtrl.text,
                  );

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.gallery,
                    (route) => false,
                  );
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
