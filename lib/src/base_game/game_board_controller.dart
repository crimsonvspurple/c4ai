import 'game_board_service.dart';

class GameBoardController {
  GameBoardController(this._gameBoardService);

  final GameBoardService _gameBoardService;

  Future<void> loadBoard() async {
    _gameBoardService.printBoard();
  }
}
