import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/photoitem.dart';
import 'package:wallpaperapp/services.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchMorePhotos();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !context.read<PhotosProvider>().isLoading) {
      _fetchMorePhotos();
    }
  }

  void _fetchMorePhotos() {
    context.read<PhotosProvider>().fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper App'),
      ),
      body: Consumer<PhotosProvider>(
        builder: (context, photosProvider, child) {
          return GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: photosProvider.photos.length,
            itemBuilder: (context, index) {
              final photo = photosProvider.photos[index];
              return PhotoItem(photo: photo);
            },
          );
        },
      ),
    );
  }
}