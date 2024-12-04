import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallpaperapp/photomodel.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({super.key, required this.photo});

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(photo.downloadUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final result = await ImageGallerySaver.saveImage(
          bytes,
          name: '${photo.id}.jpg',
        );
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Image saved to gallery'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save image to gallery'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to download image'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Detail'),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            photo.url,
            fit: BoxFit.contain,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () => _downloadImage(context),
            icon: const Icon(Icons.download),
            label: const Text('Download'),
          ),
        ),
      ),
    );
  }
}