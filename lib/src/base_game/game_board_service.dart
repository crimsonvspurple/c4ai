enum Piece { EMPTY, MIN, MAX }

class Player {
  Player(final Piece symbol, final String name, {int streak = 0});
}

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

  GameBoardService._internal();

  final List<List<Piece>> board = List.filled(6, List.filled(7, Piece.EMPTY)); // 6 rows  // 7 columns

  String printBoard() {
    String paper = "-- | 0 1 2 3 4 5 6\n";

    var i = 0;
    for (var row in board) {
      paper += "${i++} | ";
      for (Piece item in row) {
        // paper += "[ ${item.name} ${item.index} ]";
        paper += item.index.toString() + " ";
      }
      paper += "\n";
    }
    return paper;
  }
}
