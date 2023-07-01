import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavieja/pages/game/controllers/game.controller.dart';
import 'package:lavieja/pages/game/game.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(GameController());
    return GetMaterialApp(
      title: 'La vieja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
