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
