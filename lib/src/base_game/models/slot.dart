import 'package:c4ai/src/base_game/models/col.dart';
import 'package:c4ai/src/base_game/models/row.dart';

class Slot {
  final ROW row;
  final COL col;

  Slot(this.row, this.col);

  bool canUp() {
    return row.hasPrevious();
  }

  Slot up() {
    if (!canUp()) {
      throw Exception("Cant go up!");
    }
    return Slot(row.previous(), col);
  }

  bool canDown() {
    return row.hasNext();
  }

  Slot down() {
    if (!canDown()) {
      throw Exception("Cant go down!");
    }
    return Slot(row.next(), col);
  }

  bool canLeft() {
    return col.hasPrevious();
  }

  Slot left() {
    if (!canLeft()) {
      throw Exception("Cant go left!");
    }
    return Slot(row, col.previous());
  }

  bool canRight() {
    return col.hasNext();
  }

  Slot right() {
    if (!canRight()) {
      throw Exception("Cant go right!");
    }
    return Slot(row, col.next());
  }

  bool canUpLeft() {
    return canUp() && canLeft();
  }

  Slot upLeft() {
    if (!canUpLeft()) {
      throw Exception("Cant go up-left");
    }
    return Slot(row.previous(), col.previous());
  }

  bool canUpRight() {
    return canUp() && canRight();
  }

  Slot upRight() {
    if (!canUpRight()) {
      throw Exception("Cant go up-right");
    }
    return Slot(row.previous(), col.next());
  }

  bool canDownLeft() {
    return canDown() && canLeft();
  }

  Slot downLeft() {
    if (!canDownLeft()) {
      throw Exception("Cant go down-left");
    }
    return Slot(row.next(), col.previous());
  }

  bool canDownRight() {
    return canDown() && canRight();
  }

  Slot downRight() {
    if (!canDownRight()) {
      throw Exception("Cant go down-right");
    }
    return Slot(row.next(), col.next());
  }

  @override
  String toString() {
    return "( ${row.value}, ${col.value} )";
  }
}
