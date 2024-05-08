import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';

enum MenuSfx {
  button,
}

final class AudioManager {
  final _bgmPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.loop);
  final _assetBgmPlayer = AudioPlayer();

  var _bgmVolume = 1.0;
  var _sfxVolume = 1.0;

  final _menuPlayers = {
    MenuSfx.button: AudioPlayer(),
  };

  Future<void> playBgm({String? path}) {
    if (path != null) {
      return _bgmPlayer.play(AssetSource(path), volume: _bgmVolume);
    } else {
      return _bgmPlayer.play(AssetSource('audio/main_theme.mp3'),
          volume: _bgmVolume);
    }
  }

  Future<void> stopBgm() async {
    await _bgmPlayer.stop();
  }

  Future<void> pauseBgm() async {
    await _bgmPlayer.pause();
  }

  Future<void> resumeBgm() {
    return _bgmPlayer.resume();
  }

  Future<void> setBgmVolume(double volume) {
    assert(volume >= 0 && volume <= 1);
    _bgmVolume = volume;
    return _bgmPlayer.setVolume(volume);
  }

  Future<void> playMenuSfx(MenuSfx sfx) async {
    await _menuPlayers[sfx]!.stop();
    return switch (sfx) {
      MenuSfx.button => _menuPlayers[sfx]!.play(
          AssetSource('audio/sfx/ui/button1.mp3'),
          volume: _sfxVolume,
        ),
    };
  }

  Future<void> setVolumeToMenuSfx(double volume) async {
    assert(volume >= 0 && volume <= 1);
    _sfxVolume = volume;
    for (final player in _menuPlayers.values) {
      await player.setVolume(volume);
    }
  }

  Future<AudioPlayer> playAssetSfx(String assetPath) async {
    final player = AudioPlayer()
      ..play(
        AssetSource(assetPath),
        volume: _sfxVolume,
      );
    return player;
  }

  Future<void> playAssetBgm(String assetPath, {bool loop = false}) async {
    if (loop) {
      await _assetBgmPlayer.setReleaseMode(ReleaseMode.loop);
    } else if (_assetBgmPlayer.releaseMode == ReleaseMode.loop) {
      await _assetBgmPlayer.setReleaseMode(ReleaseMode.release);
    }
    return _assetBgmPlayer.play(
      AssetSource(assetPath),
      volume: _bgmVolume,
    );
  }

  Future<void> stopAssetBgm() {
    return _assetBgmPlayer.stop();
  }
}

final class AudioPools {
  late final Map<Items, List<AudioPool>> _sfxPools;
  late final AudioPool _itemHit;
  late final AudioPool _moneygive;

  bool get initialized => _initialized;

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

  Future<void> changeSkin(Skin skin) async {
    try {
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
    } catch (e) {
      print('CHANGE SKIN AUDIO POOLS FAILED');
    }
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
        ],
        Items.cocktail: [
          await AudioPool.createFromAsset(
            path: 'audio/sfx/drink.mp3',
            maxPlayers: 1,
          ),
          await AudioPool.createFromAsset(
            path: 'audio/sfx/drink2.mp3',
            maxPlayers: 1,
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
    }
  }
}
