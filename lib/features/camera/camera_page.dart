// camera_page.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../routes/app_routes.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final ImagePicker _picker = ImagePicker();
  File? _photoFile;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _photoFile = File(photo.path);
      });

      Navigator.pushNamed(
        context,
        AppRoutes.caption,
        arguments: _photoFile!.path, 
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EC),
      appBar: AppBar(
        title: const Text(
          'Ambil Foto',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFFF8F4EC),
          ),
        ),
        backgroundColor: const Color(0xFFD76C82),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_photoFile != null)
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFD76C82), width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    _photoFile!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _takePhoto,
              icon: const Icon(
                Icons.camera_alt,
                color: Color(0xFFF8F4EC),
              ),
              label: const Text(
                'Ambil Foto',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFFF8F4EC),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD76C82),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
