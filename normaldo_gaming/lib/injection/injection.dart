import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:normaldo_gaming/application/ads/ads_cubit.dart';
import 'package:normaldo_gaming/application/game_session/cubit/cubit/game_session_cubit.dart';
import 'package:normaldo_gaming/application/level/bloc/level_bloc.dart';
import 'package:normaldo_gaming/application/pre_death/pre_death_cubit.dart';
import 'package:normaldo_gaming/application/shop_items_list/shop_items_list_cubit.dart';
import 'package:normaldo_gaming/application/slot_machine/cubit/slot_machine_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/config/config.dart';
import 'package:normaldo_gaming/data/ads/ng_ad_manager.dart';
import 'package:normaldo_gaming/data/app/ng_audio_impl.dart';
import 'package:normaldo_gaming/data/game_center/game_center.dart';
import 'package:normaldo_gaming/data/level/level_manager_impl.dart';
import 'package:normaldo_gaming/data/pull_up_game/missions/local_missions_repository.dart';
import 'package:normaldo_gaming/data/shop/shop_repository_impl.dart';
import 'package:normaldo_gaming/domain/ads/ad_manager.dart';
import 'package:normaldo_gaming/domain/app/audio.dart';
import 'package:normaldo_gaming/domain/pull_up_game/level_manager.dart';
import 'package:normaldo_gaming/domain/pull_up_game/missions/missions_repository.dart';
import 'package:normaldo_gaming/domain/shop/shop_repository.dart';

final injector = Injector();

void initializeInjector(Config config) {
  // Cubits&Blocs
  injector.map<UserCubit>((injector) => UserCubit());
  injector.map<GameSessionCubit>((injector) => GameSessionCubit());
  injector.map<LevelBloc>((injector) => LevelBloc());
  injector.map<SlotMachineCubit>((injector) => SlotMachineCubit());
  injector.map<PreDeathCubit>((injector) => PreDeathCubit());
  injector.map<AdsCubit>((injector) => AdsCubit());
  injector.map<ShopItemsListCubit>(
      (injector) => ShopItemsListCubit(injector.get()));

  // Repositories
  injector.map<MissionsRepository>((injector) => LocalMissionsRepository());
  injector.map<ShopRepository>((injector) => ShopRepositoryImpl());

  // Managers
  injector.map<BaseAdManager>((injector) => AdManager(config));
  injector.map<LevelManager>(
    (injector) => LevelManagerImpl(injector.get()),
    isSingleton: true,
  );

  // Centers
  injector.map<GameCenter>((injector) => GameCenterImpl());

  // Audio
  injector.map<NgAudio>(
    (injector) => NgAudioImpl(),
    isSingleton: true,
  );
}
