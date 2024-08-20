import 'package:crud/pages/employee/splash.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange)),
            labelStyle: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              fixedSize: const Size(double.maxFinite, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          )),
      home: const SplashScreen(),
    );
  }
}
