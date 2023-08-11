import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/mainColors.dart';
import '../controllers/game.controller.dart';

class GameBoard extends StatelessWidget {
  GameBoard({super.key});
  GameController controller = Get.find();

  final playTextStyle = TextStyle(
    color: MainColors.primary,
    fontSize: 50,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Center(
        child: Container(
          width: 500,
          height: 500,
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: (100 / 100),
            children: List.generate(9, (index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: MainColors.primary,
                      width: 10,
                    ),
                    color: cellBackgroundColor(index)),
                child: InkWell(
                  onTap: controller.roundFinished
                      ? () => {}
                      : () => controller.play(index),
                  highlightColor: controller.turnPlayerColor,
                  splashColor: controller.turnPlayerColor.withOpacity(0.2),
                  hoverColor: controller.turnPlayerColor.withOpacity(0.4),
                  child: Center(
                    child: Text(
                      controller.boardPlay(index),
                      style: playTextStyle,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  cellBackgroundColor(index) {
    Map<String, dynamic>? player = controller.boardCellPlayer(index);

    if (player != null) {
      return Color(player["color"]);
    } else {
      return Colors.transparent;
    }
  }
}
