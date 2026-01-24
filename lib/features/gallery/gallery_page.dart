// gallery_page.dart
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../data/photo_store.dart';
import 'photo_card.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    final photos = PhotoStore.photos;

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
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lock, size: 32, color: Color(0xFFD76C82)),
                        const SizedBox(width: 8),
                        Text(
                          'My Locket',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD76C82),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Color(0xFF5F8B4C)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: photos.isEmpty
                    ? _EmptyState()
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          return PhotoCard(photo: photos[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFD76C82),
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.camera);
          setState(() {});
        },
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEF8DA8).withOpacity(0.2),
            ),
            child: const Icon(Icons.photo_camera_outlined, size: 80, color: Color(0xFFEF8DA8)),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada foto',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600, 
              color: Color(0xFFEF8DA8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ambil momen pertamamu',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5F8B4C),
            ),
          ),
        ],
      ),
    );
  }
}


