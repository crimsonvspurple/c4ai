enum Piece {
  empty("-"),
  min("O"),
  max("X");

  final String value;

  const Piece(this.value);
}

enum ROW {
  zero(0),
  one(1),
  two(2),
  three(3),
  four(4),
  five(5);

  final int value;

  const ROW(this.value);

  bool hasPrevious() {
    return this != zero;
  }

  ROW previous() {
    if (!hasPrevious()) {
      throw Exception("no previous row");
    }
    return ROW.values.elementAt(value - 1);
  }

  bool hasNext() {
    return this != five;
  }

  ROW next() {
    if (!hasNext()) {
      throw Exception("no next row");
    }
    return ROW.values.elementAt(value + 1);
  }
}

enum COL {
  zero(0),
  one(1),
  two(2),
  three(3),
  four(4),
  five(5),
  six(6);

  final int value;

  const COL(this.value);

  bool hasPrevious() {
    return this != zero;
  }

  COL previous() {
    if (!hasPrevious()) {
      throw Exception("no previous col");
    }
    return COL.values.elementAt(value - 1);
  }

  bool hasNext() {
    return this != six;
  }

  COL next() {
    if (!hasNext()) {
      throw Exception("no next col");
    }
    return COL.values.elementAt(value + 1);
  }
}

class Player {
  final Piece symbol;
  final String name;
  int streak;

  Player(this.symbol, this.name, {this.streak = 0});
}

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
  // ⬆️ OK. This can stay for the lulz. Classic reference mistake. All 6 rows referencing same 7 col list. Change in one, whole col changes :(
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
        item = Piece.empty;
      }
    }
    _move = 0;
    return board;
  }

  Board playPiece(ROW row, COL col, Player player) {
    if (!isTurn(player)) {
      throw Exception("Not this player's turn!");
    }
    if (validToPlay(row, col)) {
      board[row.value][col.value] = player.symbol;
      _move++;
      swapTurn();
      return board;
    }
    throw Exception("Invalid Move!");
  }

  bool validToPlay(ROW row, COL col) {
    ROW currentRow = row;
    if (!isEmpty(currentRow, col)) {
      return false;
    }
    while (currentRow.hasNext()) {
      currentRow = currentRow.next();
      if (isEmpty(currentRow, col)) {
        return false;
      }
    }
    return true;
  }

  bool isEmpty(ROW row, COL col) {
    return board[row.value][col.value] == Piece.empty;
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
