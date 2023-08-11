import 'package:flutter/material.dart';

import '../../../util/mainColors.dart';

class ReadyButton extends StatelessWidget {
  late bool playerReady;
  late Function callback;

  ButtonStyle notReadyButtonStyle = TextButton.styleFrom(
    side: BorderSide(
      color: MainColors.primary,
      width: 3,
    ),
    foregroundColor: Colors.green,
    minimumSize: Size(150, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  ButtonStyle readyButtonStyle = TextButton.styleFrom(
    side: BorderSide(
      color: MainColors.primary,
      width: 3,
    ),
    foregroundColor: MainColors.primary,
    backgroundColor: Colors.green,
    minimumSize: Size(150, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  ReadyButton({super.key, required this.playerReady, required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: playerReady ? readyButtonStyle : notReadyButtonStyle,
      onPressed: () => callback(),
      icon: Icon(Icons.check_circle),
      label: Text(
        playerReady ? "Ready!" : "Get Ready!",
      ),
    );
  }
}
