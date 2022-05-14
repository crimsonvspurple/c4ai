import 'dart:collection';

import 'package:c4ai/src/base_game/models/Direction.dart';
import 'package:c4ai/src/base_game/models/piece.dart';
import 'package:c4ai/src/base_game/models/result.dart';
import 'package:c4ai/src/base_game/models/slot.dart';

import 'models/player.dart';

typedef Board = List<List<Piece>>;

class GameBoardService {
  // Board Layout:
  // 0: 0123456
  // 1: 0123456
  // 2: 0123456
  // 3: 0123456
  // 4: 0123456
  // 5: 0123456

  static final GameBoardService _singleton = GameBoardService._internal();

  factory GameBoardService() {
    return _singleton;
  }

  GameBoardService._internal() {
    turn = player1;
  }

  // final Board board = List.filled(6, List.filled(7, Piece.empty)); // 6 rows  // 7 columns
  // ⬆️ OK. This can stay. Classic reference mistake. All 6 rows referencing same 7 col list. Change in one, whole col changes :(
  // ⬇️ This is correct version
  final Board board = List.generate(6, (index) => List.generate(7, (index2) => Piece.empty)); // 6 rows  // 7 columns
  int _move = 0;
  final Player player1 = Player(Piece.max, "MAX");
  final Player player2 = Player(Piece.min, "MIN");
  late Player turn;

  int getMoveCount() {
    return _move;
  }

  Board reset() {
    for (var row in board) {
      for (Piece item in row) {
        item = Piece.empty; // possible bug of reference
      }
    }
    _move = 0;
    return board;
  }

  Board playPiece(Slot slot, Player player) {
    if (!isTurn(player)) {
      throw Exception("Not this player's turn!");
    }
    if (validToPlay(slot)) {
      _setPiece(slot, player.symbol);
      _move++;
      swapTurn();
      return board;
    }
    throw Exception("Invalid Move!");
  }

  bool validToPlay(Slot slot) {
    Slot currentSlot = Slot(slot.row, slot.col);
    if (!isEmpty(currentSlot)) {
      return false;
    }
    while (currentSlot.canDown()) {
      currentSlot = currentSlot.down();
      if (isEmpty(currentSlot)) {
        return false;
      }
    }
    return true;
  }

  bool isEmpty(Slot slot) {
    return getPiece(slot) == Piece.empty;
  }

  Piece getPiece(Slot slot) {
    return board[slot.row.value][slot.col.value];
  }

  void _setPiece(Slot slot, Piece piece) {
    board[slot.row.value][slot.col.value] = piece;
  }

  bool isTurn(Player player) {
    return turn == player;
  }

  void swapTurn() {
    if (turn == player1) {
      turn = player2;
    } else {
      turn = player1;
    }
  }

  // RESULT checkWin() { // whole board
  //
  // }
  //
  RESULT checkWin(Slot slot) {
    Piece piece = getPiece(slot);
    RESULT result = RESULT.NONE;
    if (piece == Piece.empty) {
      throw Exception("Cant check win on empty");
    }
    Slot currentSlot = Slot(slot.row, slot.col);

    Map<WinDirection, Map<Side, List<Function>>> functionMap = {
      WinDirection.leftRight: {
        Side.one: [currentSlot.canLeft, currentSlot.left],
        Side.other: [currentSlot.canRight, currentSlot.right]
      },
      WinDirection.upDown: {
        Side.one: [currentSlot.canUp, currentSlot.up],
        Side.other: [currentSlot.canDown, currentSlot.down]
      },
      WinDirection.upLeftDownRight: {
        Side.one: [currentSlot.canUpLeft, currentSlot.upLeft],
        Side.other: [currentSlot.canDownRight, currentSlot.downRight]
      },
      WinDirection.upRightDownLeft: {
        Side.one: [currentSlot.canUpRight, currentSlot.upRight],
        Side.other: [currentSlot.canDownLeft, currentSlot.downLeft]
      }
    };

    for (var sides in functionMap.values) {
      ListQueue<Slot> connect4 = ListQueue(4);
      connect4.add(slot);
      while (sides[Side.one]![0]()) {
        currentSlot = sides[Side.one]![1]();
        if (getPiece(currentSlot) == piece) {
          connect4.addFirst(currentSlot);
          if (connect4.length == 4) {
            print("Winning Combo: ");
            connect4.forEach(print);
            return piece == Piece.max ? RESULT.MAX : RESULT.MIN;
          }
        } else {
          break;
        }
      }
      while (sides[Side.other]![0]()) {
        currentSlot = sides[Side.other]![1]();
        if (getPiece(currentSlot) == piece) {
          connect4.addLast(currentSlot);
          if (connect4.length == 4) {
            print("Winning Combo: ");
            connect4.forEach(print);
            return piece == Piece.max ? RESULT.MAX : RESULT.MIN;
          }
        } else {
          break;
        }
      }
    }

    return RESULT.NONE;
  }

  String printBoard() {
    String paper = "- | 0 1 2 3 4 5 6\n";

    var i = 0;
    for (var row in board) {
      paper += "${i++} | ";
      for (Piece item in row) {
        // paper += "[ ${item.name} ${item.index} ]";
        paper += item.value + " ";
      }
      paper += "\n";
    }
    return paper;
  }
}
