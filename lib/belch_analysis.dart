import 'dart:math';

class BelchAnalysis {
  Random random;

  BelchAnalysis() {
    // Seed random number generator with the millisecond time value.
    var now = DateTime.now();
    random = Random(now.millisecond);
  }

  /// Returns an integer 0 <= x <= 5 which represents a 5-star rating.
  /// 0 represents mere noise.
  int analyzeBelch(List<int> sampleArray) {
    return random.nextInt(6);
  }
}
