import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/core/errors.dart';
import 'package:normaldo_gaming/domain/shop/entities/shop_item.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class ShopItemCard extends StatelessWidget {
  const ShopItemCard({
    required this.item,
    required this.onPressed,
    super.key,
  });

  final ShopItem item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (item is DollarForAdItem) {
      return _DollarAdForItemCard(
        item: item as DollarForAdItem,
        onPressed: onPressed,
      );
    }
    throw UnexpectedError();
  }
}

class _DollarAdForItemCard extends StatelessWidget {
  const _DollarAdForItemCard({
    required this.item,
    required this.onPressed,
    super.key,
  });

  final DollarForAdItem item;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BouncingButton(
      onPressed: onPressed,
      child: Card(
        child: Column(
          children: [
            Flexible(child: Image.asset(item.imagePath)),
            Text(item.title.tr(), style: textTheme.bodyLarge),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(item.description.tr(), style: textTheme.bodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
