//app_routes.dart
import 'package:flutter/material.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/gallery/gallery_page.dart';
import '../features/camera/camera_page.dart';
import '../features/camera/caption_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const gallery = '/gallery';
  static const camera = '/camera';
  static const caption = '/caption';

  static final Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    gallery: (_) => const GalleryPage(),
    camera: (_) => const CameraPage(),
    caption: (_) => const CaptionPage(),
  };
}
