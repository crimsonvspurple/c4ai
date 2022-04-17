import 'package:c4ai/src/base_game/models/piece.dart';

class Player {
  final Piece symbol;
  final String name;
  int streak;

  Player(this.symbol, this.name, {this.streak = 0});
}
