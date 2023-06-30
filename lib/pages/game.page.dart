import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavieja/util/mainColors.dart';

class GamePage extends GetView {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.background,
      body: Center(
        child: Text(
          "Hola",
          style: TextStyle(color: MainColors.primary),
        ),
      ),
    );
  }
}

class GameController extends GetxController {}
