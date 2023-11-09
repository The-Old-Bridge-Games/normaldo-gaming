import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';

extension on Items {
  String get fullPath => switch (this) {
        Items.trashBin => 'assets/images/trash_bin.png',
        Items.pizza => 'assets/images/pizza.png',
        Items.dollar => 'assets/images/dollar.png',
        Items.fatPizza => 'assets/images/pizza_pack1.png',
        Items.homeless => 'assets/images/homeless1.png',
        Items.moneyBag => 'assets/images/money_bag.png',
        Items.bomb => 'assets/images/bomb.png',
        Items.cocktail => 'assets/images/cocktail.png',
        Items.molotov => 'assets/images/molotov1.png',
        Items.hourglass => 'assets/images/hourglass.png',
        Items.punch => 'assets/images/punch.png',
        Items.shredder => 'assets/images/shredder.png',
        Items.shuriken => 'assets/images/shuriken.png',
        _ => throw UnexpectedError(),
      };

  String get description => switch (this) {
        _ =>
          'Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo',
      };
}

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.item,
  });

  final Items item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Image.asset(
        item.fullPath,
        width: 80,
        height: 80,
      ),
      title: Text(item.name.tr(), style: textTheme.displayLarge),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          item.description,
          style: textTheme.displaySmall,
        ),
      ),
    );
  }
}
