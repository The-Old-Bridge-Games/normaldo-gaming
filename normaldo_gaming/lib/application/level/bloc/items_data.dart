part of 'level_bloc.dart';

final _goodItems = [
  (Items.magicHat, 0.2),
  (Items.energizer, 1.0),
  (Items.pizza, 50.0),
  (Items.moneyBag, 0.1),
  (Items.dollar, 2.0),
  (Items.hourglass, 0.5),
  (Items.caseyMask, 0.1),
  (Items.magnet, 2.0),
  (Items.boombox, 2.0),
  (Items.magicBox, 3.0),
];

final Map<int, Roller<Items>> _itemRollers = {
  0: Roller<Items>([
    ..._goodItems,
    (Items.bananaPeel, 80),
    (Items.trashBin, 3),
  ]),
  1: Roller<Items>([
    ..._goodItems,
    (Items.bananaPeel, 20),
    (Items.cone, 10),
    (Items.homeless, 10),
  ]),
  2: Roller<Items>([
    ..._goodItems,
    (Items.bananaPeel, 20),
    (Items.roadSign, 10),
    (Items.cone, 10),
    (Items.homeless, 5),
    (Items.trashBin, 3),
  ]),
  3: Roller<Items>([
    ..._goodItems,
    (Items.bananaPeel, 20),
    (Items.roadSign, 20),
    (Items.trashBin, 20),
    (Items.cone, 20),
    (Items.homeless, 20),
    (Items.punch, 20),
  ]),
  5: Roller<Items>([
    ..._goodItems,
    (Items.bananaPeel, 20),
    (Items.roadSign, 20),
    (Items.trashBin, 20),
    (Items.cone, 20),
    (Items.homeless, 20),
    (Items.cone, 20),
    (Items.punch, 20),
  ]),
};

final Map<int, Map<Items, double>> _itemsAppearingByLevel = {
  0: {
    Items.roadSign: 0.2,
    Items.pizza: 0.3,
    Items.caseyMask: 0.1,
    Items.bananaPeel: 0.3,
    Items.trashBin: 0.1,
    // Items.magicHat: 0.5,
  }
  // 0: Map<Items, double>.fromEntries(Items.values
  //     .where((item) =>
  //         item != Items.shredder &&
  //         item != Items.shredderSword &&
  //         item != Items.shuriken &&
  //         item != Items.fatPizza)
  //     .map((e) {
  //   final itemsCount = Items.values.length - 4;
  //   return MapEntry<Items, double>(
  //     e,
  //     1 / itemsCount,
  //   );
  // }))
  // {
  // Items.trashBin: 0.1,
  // Items.hourglass: 0.1,
  // Items.pizza: 0.1,
  // Items.dollar: 0.1,
  // Items.moneyBag: 0.1,
  // Items.homeless: 0.1,
  // Items.punch: 0.1,
  // Items.cocktail: 0.1,
  // Items.molotov: 0.1,
  // Items.boombox: 0.1,
  // },
  // 1: {
  //   Items.trashBin: 0.400,
  //   Items.pizza: 0.425,
  //   Items.dollar: 0.048,
  //   Items.moneyBag: 0.002,
  //   Items.homeless: 0.100,
  //   Items.punch: 0.025,
  // },
  // 2: {
  //   Items.trashBin: 0.375,
  //   Items.pizza: 0.375,
  //   Items.dollar: 0.050,
  //   Items.moneyBag: 0.002,
  //   Items.homeless: 0.052,
  //   Items.cocktail: 0.048,
  //   Items.bomb: 0.048,
  //   Items.punch: 0.050,
  // },
  // 4: {
  //   Items.trashBin: 0.392,
  //   Items.pizza: 0.350,
  //   Items.dollar: 0.050,
  //   Items.moneyBag: 0.002,
  //   Items.homeless: 0.010,
  //   Items.cocktail: 0.048,
  //   Items.bomb: 0.048,
  //   Items.molotov: 0.100
  // },
  // 5: {
  //   Items.trashBin: 0.412,
  //   Items.pizza: 0.370,
  //   Items.dollar: 0.044,
  //   Items.moneyBag: 0.002,
  //   Items.homeless: 0.012,
  //   Items.cocktail: 0.050,
  //   Items.bomb: 0.050,
  //   Items.molotov: 0.050,
  //   Items.punch: 0.010,
  // },
  // 6: {
  //   Items.trashBin: 0.372,
  //   Items.pizza: 0.370,
  //   Items.dollar: 0.034,
  //   Items.moneyBag: 0.002,
  //   Items.homeless: 0.012,
  //   Items.cocktail: 0.050,
  //   Items.bomb: 0.050,
  //   Items.molotov: 0.055,
  //   Items.punch: 0.050,
  //   Items.hourglass: 0.005,
  // },
};
