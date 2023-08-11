// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavieja/pages/game/widgets/cardPlayer.widget.dart';
import 'package:lavieja/pages/game/widgets/gameBoard.widget.dart';
import 'package:lavieja/pages/game/widgets/readyButton.widget.dart';
import 'package:lavieja/util/mainColors.dart';

import 'controllers/game.controller.dart';

class GamePage extends GetView<GameController> {
  GamePage({super.key});

  final vsTextStyle = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: MainColors.secundary,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.background,
      body: Center(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "Turno: ${controller.turnPlayerName}",
                    style: TextStyle(
                      color: MainColors.primary,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              GameBoard(),
              controller.roundFinished
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ReadyButton(
                          playerReady: controller.player1Ready,
                          callback: () {
                            controller.player1Ready = !controller.player1Ready;
                          },
                        ),
                        ReadyButton(
                          playerReady: controller.player2Ready,
                          callback: () {
                            controller.player2Ready = !controller.player2Ready;
                          },
                        ),
                      ],
                    )
                  : SizedBox(),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const SizedBox(width: 50),
                    CardPlayer(
                      playerNum: 1,
                      score: controller.player1["score"],
                      namePlayer: controller.player1["name"],
                      chip: controller.player1["chip"],
                      colorChip: Color(controller.player1["color"]),
                    ),
                    const SizedBox(width: 20),
                    Text(" VS ", style: vsTextStyle),
                    const SizedBox(width: 20),
                    CardPlayer(
                      playerNum: 2,
                      score: controller.player2["score"],
                      namePlayer: controller.player2["name"],
                      chip: controller.player2["chip"],
                      colorChip: Color(controller.player2["color"]),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
