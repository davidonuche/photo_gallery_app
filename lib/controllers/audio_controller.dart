import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _audioAssets = [
    'audio/i_want_to_live.m4a',
    'audio/i_will_waste_my_life.m4a',
    'audio/let_me_want_what_you_want.m4a',
    'audio/lord_i_come_before_your_majesty.m4a',
    'audio/lord_i_long_for_your_lovely_face.m4a',
    'audio/my_eyes_are_upon_you.m4a',
    'audio/take_the_lead.m4a',
    'audio/you_are_always_there.m4a',
  ];
  int _currentIndex = 0;

  void play() async {
    await _audioPlayer.play(AssetSource(_audioAssets[_currentIndex]));
    _audioPlayer.onPlayerComplete.listen((event) {
      _currentIndex = (_currentIndex + 1) % _audioAssets.length;
      play();
    });
  }

  void stop() async {
    await _audioPlayer.stop();
  }
}
