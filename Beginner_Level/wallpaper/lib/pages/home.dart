import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List wallpaper = [
    'images/wallpaper1.jpg',
    'images/wallpaper2.jpg',
    'images/wallpaper3.jpg',
    'images/wallpaper4.jpg'
  ];
  int activeIndicator = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 30, left: 20, right: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Material(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    elevation: 5.0,
                    child: ClipOval(
                      child: Image.asset(
                        'images/boy.jpg',
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 60.0,
                  ),
                  const Text(
                    'Wallify',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: CarouselSlider.builder(
                    itemCount: wallpaper.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = wallpaper[index];
                      return buildImage(imageUrl, index);
                    },
                    options: CarouselOptions(
                        // autoPlay: true,
                        height: MediaQuery.of(context).size.height / 1.7,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndicator = index;
                          });
                        })),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              Center(child: buildIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndicator,
        count: 4,
        effect: const JumpingDotEffect(
          activeDotColor: Colors.blue,
            dotColor: Colors.grey, dotHeight: 15, dotWidth: 15),
      );
  Widget buildImage(String urlImage, int index) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.7,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            urlImage,
            fit: BoxFit.cover,
          )),
    );
  }
}
