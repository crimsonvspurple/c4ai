import 'dart:ui';

import 'package:c4ai/src/base_game/game_board_service.dart';
import 'package:c4ai/src/base_game/models/result.dart';
import 'package:c4ai/src/base_game/models/slot.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../settings/settings_view.dart';
import 'models/col.dart';
import 'models/piece.dart';
import 'models/player.dart';
import 'models/row.dart';

var bigText = GoogleFonts.getFont("Oxygen Mono").copyWith(fontSize: 70);
const medText = TextStyle(fontFeatures: [FontFeature.tabularFigures()], fontSize: 35);

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
  late Board board;
  RESULT result = RESULT.NONE;

  @override
  void initState() {
    super.initState();
    gameBoardService = GameBoardService();
    board = gameBoardService.board;
    player1 = gameBoardService.player1;
    player2 = gameBoardService.player2;
    gameBoardService.playPiece(Slot(ROW.five, COL.three), player1);
    gameBoardService.playPiece(Slot(ROW.four, COL.three), player2);
    gameBoardService.playPiece(Slot(ROW.three, COL.three), player1);
    gameBoardService.playPiece(Slot(ROW.two, COL.three), player2);
    gameBoardService.playPiece(Slot(ROW.one, COL.three), player1);
    // gameBoardService.playPiece(Slot(ROW.zero, COL.three), player2);
    // gameBoardService.playPiece(Slot(ROW.five, COL.two), player1);
    // gameBoardService.playPiece(Slot(ROW.five, COL.one), player2);
    // gameBoardService.playPiece(Slot(ROW.five, COL.five), player1);
    // gameBoardService.playPiece(Slot(ROW.five, COL.four), player2);
    // gameBoardService.playPiece(Slot(ROW.four, COL.four), player1);
    // gameBoardService.playPiece(Slot(ROW.three, COL.four), player2);
    // gameBoardService.playPiece(Slot(ROW.two, COL.four), player1);
    // gameBoardService.playPiece(Slot(ROW.four, COL.one), player2);
    // gameBoardService.playPiece(Slot(ROW.four, COL.two), player1);
    // gameBoardService.playPiece(Slot(ROW.one, COL.four), player2);
    // gameBoardService.playPiece(Slot(ROW.three, COL.two), player1);
    // gameBoardService.playPiece(Slot(ROW.two, COL.two), player2);
    // gameBoardService.playPiece(Slot(ROW.one, COL.two), player1);
    // gameBoardService.playPiece(Slot(ROW.five, COL.six), player2);
    // gameBoardService.playPiece(Slot(ROW.four, COL.five), player1);
    // gameBoardService.playPiece(Slot(ROW.three, COL.one), player2);
    // gameBoardService.playPiece(Slot(ROW.two, COL.one), player1);
    // gameBoardService.playPiece(Slot(ROW.three, COL.five), player2);
    // gameBoardService.playPiece(Slot(ROW.two, COL.five), player1);
    // gameBoardService.playPiece(Slot(ROW.one, COL.five), player2);
    // gameBoardService.playPiece(Slot(ROW.one, COL.one), player1);
    // gameBoardService.playPiece(Slot(ROW.four, COL.six), player2);
    // gameBoardService.playPiece(Slot(ROW.three, COL.six), player1);
    // gameBoardService.playPiece(Slot(ROW.two, COL.six), player2);
    // gameBoardService.playPiece(Slot(ROW.one, COL.six), player1);
    // gameBoardService.playPiece(Slot(ROW.zero, COL.six), player2);
    // gameBoardService.playPiece(Slot(ROW.zero, COL.two), player1);
    // gameBoardService.playPiece(Slot(ROW.five, COL.zero), player2);
    // gameBoardService.playPiece(Slot(ROW.four, COL.zero), player1);
    // gameBoardService.playPiece(Slot(ROW.three, COL.zero), player2);
    // gameBoardService.playPiece(Slot(ROW.zero, COL.four), player1);
    // gameBoardService.playPiece(Slot(ROW.zero, COL.five), player2);
    // gameBoardService.playPiece(Slot(ROW.zero, COL.one), player1);
    // gameBoardService.playPiece(Slot(ROW.two, COL.zero), player2);
    // gameBoardService.playPiece(Slot(ROW.one, COL.zero), player1);
    // setState(() {
    //   player1 = player1;
    // });
  }

  activePlayerStyle(Player player) {
    if (gameBoardService.isTurn(player)) {
      return Colors.green;
    }
    return Colors.white;
  }

  _updateBoard(Board board, COL col, ROW row) {
    setState(() {
      this.board = board;
      result = gameBoardService.checkWinByCol(col);
    });


  }

  @override
  Widget build(BuildContext context) {
    // gameBoardService = GameBoardService();
    // setState(() {
    //   player1 = gameBoardService.player1;
    //   player2 = gameBoardService.player2;
    //   board = gameBoardService.board;
    // });
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
              children: <Widget>[
                Row(
                  children: [
                    Text("P: " + player1.name + " W: " + player1.streak.toString(), style: medText.apply(color: activePlayerStyle(player1))),
                    const Spacer(),
                    Text("P: " + player2.name + " W: " + player2.streak.toString(), style: medText.apply(color: activePlayerStyle(player2))),
                    const Spacer(),
                    Text("Move: " + gameBoardService.getMoveCount().toString(), style: medText),
                    const Spacer(),
                    // Text("Win: " + gameBoardService.checkWin(Slot(ROW.one, COL.zero)).name, style: medText)
                    Text("Win: " + result.name, style: medText)
                  ],
                ),
                // Text(gameBoardService.printBoard(), style: bigText),
                Padding(
                  padding: const EdgeInsets.all(100),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.white10, width: 10, style: BorderStyle.solid), color: Colors.blueGrey),
                    child: Column(
                      children: <Widget>[
                        for (int r = 0; r < board.length; ++r) ...[
                          Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: <Widget>[
                            for (int c = 0; c < board[r].length; ++c) ...[
                              BoardSlot(_updateBoard, board, r, c, COL.values[c], ROW.values[r])
                            ]
                          ])
                        ]
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

class BoardSlot extends StatelessWidget {
  COL col;
  ROW row;
  Function callback;
  Board board;
  int r;
  int c;

  BoardSlot(this.callback, this.board, this.r, this.c, this.col, this.row, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (board[r][c]) {
      case Piece.max:
        color = Colors.redAccent;
        break;
      case Piece.min:
        color = Colors.yellowAccent;
        break;
      default:
        color = Colors.white70;
    }

    return GestureDetector(
      onTap: () => _playColumn(col, context),
      child: Stack(children: [
        Container(
          height: 112,
          width: 112,
          color: Colors.blueGrey,
        ),
        Positioned.fill(
          top: 5,
          left: 5,
          right: 5,
          bottom: 5,
          child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: color), child: Text("$row $col", style: TextStyle(color: Colors.black)),),
        )
      ]),
    );
  }

  _playColumn(COL col, BuildContext context) {
    var board = GameBoardService().playColumn(col);
    callback(board, col, row);
  }
}

