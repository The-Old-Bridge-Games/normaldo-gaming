import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/injection/injection.dart';

mixin HasNgAudio {
  NgAudio get audio => injector.get();
}
