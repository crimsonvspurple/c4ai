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
