import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/pages/categories.dart';
import 'package:wallpaper/pages/home.dart';
import 'package:wallpaper/pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  late List<Widget> pages;
  late HomeScreen home;
  late SearchWallpaper search;
  late Categories categories;
  late Widget currentPage;
  @override
  void initState() {
    super.initState();
    home = const HomeScreen();
    search = const SearchWallpaper();
    categories = const Categories();
    pages = [home, search, categories];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          color: const Color.fromARGB(255, 84, 87, 93),
          animationDuration: const Duration(microseconds: 500),
         buttonBackgroundColor: Colors.black,
         backgroundColor: Colors.white,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.category_outlined,
              color: Colors.white,
            ),
          ]),
    );
  }
}
