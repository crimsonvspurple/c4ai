import 'dart:ui';

import 'package:c4ai/src/base_game/game_board_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../settings/settings_view.dart';

var bigText = GoogleFonts.getFont("Xanh Mono").copyWith(fontSize: 90);
const medText = TextStyle(fontFeatures: [FontFeature.tabularFigures()], fontSize: 45);

class GameBoardView extends StatefulWidget {
  const GameBoardView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<GameBoardView> createState() => _GameBoardViewState();
}

class _GameBoardViewState extends State<GameBoardView> {
  late final GameBoardService gameBoardService;
  late Player player1;
  late Player player2;

  @override
  void initState() {
    super.initState();
    gameBoardService = GameBoardService();
    player1 = Player(Piece.max, "MAX");
    player2 = Player(Piece.min, "MIN");
  }

  @override
  Widget build(BuildContext context) {
    Board board = gameBoardService.playPiece(ROW.values.last, COL.zero, player1);

    return Scaffold(
        appBar: AppBar(
          title: const Text('c4ai'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to the settings page. If the user leaves and returns
                // to the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("P: " + player1.name + " W: " + player1.streak.toString(), style: medText),
                    const Spacer(),
                    Text("P: " + player2.name + " W: " + player2.streak.toString(), style: medText),
                    const Spacer(),
                    Text("Move: " + gameBoardService.getMoveCount().toString(), style: medText)
                  ],
                ),
                Text(gameBoardService.printBoard(), style: bigText)
              ],
            )));
  }
}
