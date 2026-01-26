//gallery_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/photo.dart';
import 'package:flutter/foundation.dart';

class PhotoService {
  static const String baseUrl = 'https://locket-backend-production.up.railway.app';

  static Future<List<Photo>> fetchPhotos(String token) async {
    final url = '$baseUrl/photos/';
    debugPrint('Fetching photos from: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint('STATUS CODE: ${response.statusCode}');
    debugPrint('RESPONSE LENGTH: ${response.body.length}');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) {
        final rawUrl = e['url'] ?? '';
        e['url'] = Uri.encodeFull(rawUrl);
        return Photo.fromJson(e);
      }).toList();
    } else {
      throw Exception('Gagal fetch photos (${response.statusCode})');
    }
  }
}