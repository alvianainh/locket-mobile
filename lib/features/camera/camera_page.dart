//camera_page.dart
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

      // Langsung ke caption page
      Navigator.pushNamed(
        context,
        AppRoutes.caption,
        arguments: _photoFile!.path, // kirim path ke caption
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take Photo')),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.camera),
          label: const Text('Ambil Foto'),
          onPressed: _takePhoto,
        ),
      ),
    );
  }
}
