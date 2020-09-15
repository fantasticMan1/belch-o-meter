import 'package:flutter_sound/flutter_sound.dart';
import 'useless.dart';

class AudioManager {
  void playSample(String path) {}

  /// Normalizes a sound file such that it:
  /// - has a -1 dB peak loudness
  /// - is exactly 5 seconds long.
  /// - removes silence from the beginning of the file
  /// - saves the new file as a mono, 16-bit, 44.1 kHz wav file
  void normalizeFile(String path) {}

  /// Returns a 220,500-element array of PCM sample values.
  void getPCMFromFile(String path) {}
}
