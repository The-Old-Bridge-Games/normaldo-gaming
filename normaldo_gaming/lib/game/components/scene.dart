import 'package:flame/components.dart';

class Scene extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('level1_bg.png');
    super.onLoad();
  }
}
