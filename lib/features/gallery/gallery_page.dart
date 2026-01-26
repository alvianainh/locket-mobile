// gallery_page.dart
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../models/photo.dart';
import '../../core/storage/secure_storage.dart';
import 'gallery_service.dart';
import 'photo_card.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Photo> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    try {
      final token = await SecureStorage.getToken();

      debugPrint('TOKEN: $token');

      if (token == null) {
        debugPrint('TOKEN NULL');
        setState(() => isLoading = false);
        return;
      }

      final result = await PhotoService.fetchPhotos(token);

      debugPrint('TOTAL PHOTO: ${result.length}'); // 🔥

      setState(() {
        photos = result;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Fetch photos error: $e');
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
          child: Column(
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.lock, size: 32, color: Color(0xFFD76C82)),
                        SizedBox(width: 8),
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
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                    ),
                  ],
                ),
              ),

              // CONTENT
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : photos.isEmpty
                        ? _EmptyState()
                        : GridView.builder(
                            padding: const EdgeInsets.all(12),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: photos.length,
                            itemBuilder: (context, index) {
                              return PhotoCard(
                                photo: photos[index],
                                allPhotos: photos,
                                initialIndex: index,
                              );
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
          fetchPhotos();
        },
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }

  Widget _EmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.photo_library_outlined,
            size: 80,
            color: Color(0xFFD76C82),
          ),
          SizedBox(height: 12),
          Text(
            'Belum ada foto',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xFF5F8B4C),
            ),
          ),
        ],
      ),
    );
  }
}




