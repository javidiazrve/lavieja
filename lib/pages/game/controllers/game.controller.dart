import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/mainColors.dart';

class GameController extends GetxController {
  late RxList<int> _board;
  late RxInt _turn;
  late RxString _roundWinnerKey;
  late RxString _gameWinnerKey;
  late RxBool _roundFinished;
  late RxBool _gameFinished;
  late RxBool _player1Ready;
  late RxBool _player2Ready;
  late RxMap<String, Map<String, dynamic>> _players;

  GameController() {
    initGame();

    Colors.redAccent.value;
  }

  // Setters and Getters
  set gameFinished(value) => _gameFinished.value = value;
  get gameFinished => _gameFinished.value;

  set roundFinished(value) => _roundFinished.value = value;
  get roundFinished => _roundFinished.value;

  set gameWinnerKey(value) {
    _gameWinnerKey.value = value;
  }

  get gameWinnerKey => _gameWinnerKey.value;

  set roundWinnerKey(value) {
    _roundWinnerKey.value = value;
  }

  get roundWinnerKey => _roundWinnerKey.value;

  set turn(value) => _turn.value = value;
  get turn => _turn.value;
  get turnChip => _players["$turn"]!["chip"];
  get turnPlayerName => _players["$turn"]!["name"];
  Color get turnPlayerColor => Color(_players["$turn"]!["color"]);

  get player1 => _players["1"];
  get player2 => _players["2"];

  set player1Ready(value) {
    _player1Ready.value = value;
    checkReadyPlayers();
  }

  bool get player1Ready => _player1Ready.value;

  set player2Ready(value) {
    _player2Ready.value = value;
    checkReadyPlayers();
  }

  bool get player2Ready => _player2Ready.value;

  get winnerPlayerName => _players[gameWinnerKey]!["name"];

  initGame() {
    _board = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
    _turn = 1.obs;
    _players = {
      "1": {
        "name": "Javidiazrve",
        "chip": "X",
        "color": Colors.redAccent.value,
        "score": 0,
      },
      "2": {
        "name": "Rafagonz501",
        "chip": "O",
        "color": Colors.blue.value,
        "score": 0,
      },
    }.obs;
    _player1Ready = false.obs;
    _player2Ready = false.obs;
    _roundWinnerKey = "".obs;
    _roundFinished = false.obs;
    _gameWinnerKey = "".obs;
    _gameFinished = false.obs;
  }

  play(index) {
    if (_board[index] == 0) {
      _board[index] = turn;
      checkWinner();
    }
  }

  boardPlay(index) {
    int player = _board[index];

    if (player != 0) {
      return _players["$player"]!["chip"];
    } else {
      return "";
    }
  }

  Map<String, dynamic>? boardCellPlayer(index) {
    int playerIndex = _board[index];

    return _players["$playerIndex"];
  }

  checkReadyPlayers() {
    if (player1Ready && player2Ready) nextRound();
  }

  checkWinner() {
    // Diagonal
    if (checkLine(0, 4, 8)) endRound(_board[8]);

    // Transversal Diagonal
    if (checkLine(2, 4, 6)) endRound(_board[6]);

    // Vertical
    for (var i = 0; i < 3; i++) {
      if (checkLine(i, i + 3, i + 6)) endRound(_board[i]);
    }
    // Horizontal
    for (var i = 0; i < 9; i += 3) {
      bool line = checkLine(i, i + 1, i + 2);
      if (line) endRound(_board[i]);
    }

    _turn.value = turn == 1 ? 2 : 1;
  }

  checkLine(col1, col2, col3) {
    if (_board[col1] == 0) return false;
    if (_board[col1] == _board[col2] && _board[col2] == _board[col3]) {
      paintLine(col1, col2, col3);
      return true;
    } else {
      return false;
    }
  }

  paintLine(col1, col2, col3) {}

  endRound(key) {
    roundWinnerKey = key.toString();

    int rounds = _players["$key"]?["score"] += 1;

    if (rounds == 3) {
      endGame(key.toString());
    } else {
      roundFinished = true;
    }
  }

  endGame(playerKey) {
    gameWinnerKey = playerKey;

    Get.defaultDialog(
      title: "$winnerPlayerName GANA!!!",
      titleStyle: TextStyle(color: MainColors.primary, fontSize: 20),
      titlePadding: EdgeInsets.only(top: 20),
      contentPadding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
      barrierDismissible: false,
      backgroundColor: Colors.black87,
      radius: 20,
      content: Container(
        width: double.infinity,
        height: 70,
        child: Center(
          child: Text(
            "Seguimos jugando?",
            style: TextStyle(color: MainColors.primary),
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () {
          Get.back(closeOverlays: true);
          resetGame();
        },
        style: TextButton.styleFrom(
          backgroundColor: MainColors.background,
          foregroundColor: MainColors.primary,
        ),
        child: Text("Play Again"),
      ),
      cancel: TextButton(
        onPressed: () {
          Get.toNamed("home");
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.redAccent.shade400,
          foregroundColor: MainColors.primary,
        ),
        child: Text("Exit"),
      ),
    );
  }

  nextRound() {
    _board = [0, 0, 0, 0, 0, 0, 0, 0, 0].obs;
    turn = int.parse(roundWinnerKey);
    roundWinnerKey = "";
    roundFinished = false;
    player1Ready = false;
    player2Ready = false;
  }

  resetGame() {
    nextRound();
    initGame();
  }
}
