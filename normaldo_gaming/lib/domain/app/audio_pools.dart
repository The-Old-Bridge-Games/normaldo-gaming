import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';

final class AudioPools {
  late final Map<Items, List<AudioPool>> _sfxPools;
  late final AudioPool _itemHit;
  late final AudioPool _moneygive;

  var _initialized = false;

  void playSfx(Items item, {double volume = 1.0}) {
    if (!_initialized) return;
    _sfxPools[item]?.random().start(volume: volume) ??
        print('no sfx for $item loaded');
  }

  void playItemHitSfx() async {
    if (!_initialized) return;
    _itemHit.start();
  }

  void playMoneygiveSfx() async {
    if (!_initialized) return;
    _moneygive.start();
  }

  Future<void> init(Skin skin) async {
    try {
      _itemHit = await AudioPool.createFromAsset(
        path: 'audio/sfx/gantelya1.mp3',
        maxPlayers: 10,
      );
      _moneygive = await AudioPool.createFromAsset(
        path: 'audio/sfx/dollars.mp3',
        maxPlayers: 5,
      );
      _sfxPools = {
        Items.bananaPeel: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/BANANA.mp3',
            maxPlayers: 8,
          )
        ],
        Items.boombox: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/bomb1.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.caseyMask: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/MASK FLY AROUND.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.energizer: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/energy.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.fatPizza: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/mystery 2.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.girl: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/SLAP ALTYSHKA.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.hourglass: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/magic_sound_longer.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.magicBox: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/MYSTERY.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.magicHat: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/MASK FLY AROUND magic  SHLYAPA.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.magnet: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/magnet.mp3',
            maxPlayers: 1,
          ),
        ],
        Items.punch: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/round_box.mp3',
            maxPlayers: 5,
          ),
        ]
      };
      final skinBiteSfx = skin.assets.sfx['bite'];
      if (skinBiteSfx != null) {
        final skinBitePools = await Future.wait(skinBiteSfx.map(
          (e) =>
              AudioPool.createFromAsset(path: 'audio/skins/$e', maxPlayers: 1),
        ));
        _sfxPools[Items.pizza] = skinBitePools;
      } else {
        _sfxPools[Items.pizza] = [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/havaet.mp3',
            maxPlayers: 1,
          ),
          await AudioPool.createFromAsset(
            path: 'audio/sfx/havaet2.mp3',
            maxPlayers: 1,
          ),
        ];
      }
      _initialized = true;
    } catch (e) {
      print('AUDIO POOLS ARE NOT INITIALIZED');
      rethrow;
    }
  }
}
