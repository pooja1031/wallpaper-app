import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaperapp/services.dart';
import 'package:wallpaperapp/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhotosProvider(),
      child: MaterialApp(
        title: 'Wallpaper App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}