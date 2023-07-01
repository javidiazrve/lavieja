import 'package:flutter/material.dart';

import '../../../util/mainColors.dart';

class CardPlayer extends StatelessWidget {
  final int playerNum;
  final int score;
  final String namePlayer;
  final String chip;
  final Color colorChip;

  CardPlayer({
    super.key,
    required this.playerNum,
    required this.score,
    required this.namePlayer,
    required this.chip,
    required this.colorChip,
  });

  final playerTextStyle = TextStyle(
    fontSize: 30,
    color: MainColors.primary,
  );

  final scoreTextStyle = TextStyle(
    fontSize: 40,
    color: MainColors.secundary,
    fontWeight: FontWeight.bold,
  );

  late TextStyle chipTextStyle;

  late List<Widget> children;

  @override
  Widget build(BuildContext context) {
    chipTextStyle = TextStyle(
      fontSize: 40,
      color: colorChip,
      fontWeight: FontWeight.bold,
    );

    children = [
      Text(
        chip,
        style: chipTextStyle,
      ),
      Text(namePlayer, style: playerTextStyle),
      Text(score.toString(), style: scoreTextStyle),
    ];

    return Expanded(
      flex: 1,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: MainColors.foreground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: playerNum == 1 ? children : children.reversed.toList(),
        ),
      ),
    );
  }
}
