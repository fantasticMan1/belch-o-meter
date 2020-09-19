import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

class AudioManager {
  Soundpool _soundpool;

  AudioManager() {
    _soundpool = Soundpool();
  }

  void playSample(String path) async {
    try {
      int soundId = await rootBundle.load(path).then((ByteData soundData) {
        return _soundpool.load(soundData);
      });
      int streamId = await _soundpool.play(soundId);
    } catch (e) {
      print(e);
    }
  }

  /// Normalizes a sound file such that it:
  /// - has a -1 dB peak loudness
  /// - is exactly 5 seconds long.
  /// - removes silence from the beginning of the file
  /// - saves the new file as a mono, 16-bit, 44.1 kHz wav file
  void normalizeFile(String path) {}

  /// Returns a 220,500-element array of PCM sample values.
  void getPCMFromFile(String path) {}
}
