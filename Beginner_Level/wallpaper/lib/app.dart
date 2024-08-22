import 'package:flutter/material.dart';
import 'package:wallpaper/pages/bottomnav.dart';
import 'package:wallpaper/pages/home.dart';

class WallPaperApp extends StatelessWidget {
  const WallPaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      home: BottomNav(),
    );
  }
}
