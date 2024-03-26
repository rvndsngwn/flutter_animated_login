extension IntExtinction on int {
  /// Returns the double value of the integer. 0 => 00, 1 => 01, 10 => 10
  String get toDigital => this < 10 ? '0$this' : '$this';
}
