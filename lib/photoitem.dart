import 'package:flutter/material.dart';
import 'package:wallpaperapp/photodetail.dart';
import 'package:wallpaperapp/photomodel.dart';


class PhotoItem extends StatelessWidget {
  final Photo photo;

  const PhotoItem({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoDetailScreen(photo: photo),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            photo.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}