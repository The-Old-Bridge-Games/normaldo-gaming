import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/domain/pull_up_game/items.dart';
import 'package:normaldo_gaming/ui/knowledge_book/widgets/item_list_tile.dart';
import 'package:normaldo_gaming/ui/knowledge_book/widgets/type_picker.dart';
import 'package:normaldo_gaming/ui/widgets/liner_button.dart';

class KnowledgeBookScreen extends StatefulWidget {
  const KnowledgeBookScreen({super.key});

  @override
  State<KnowledgeBookScreen> createState() => _KnowledgeBookScreenState();
}

class _KnowledgeBookScreenState extends State<KnowledgeBookScreen> {
  Types _type = Types.good;

  final gudItems = [
    Items.pizza,
    Items.bomb,
    Items.hourglass,
    Items.dollar,
    Items.moneyBag,
  ];

  final badItems = [
    Items.trashBin,
    Items.cocktail,
    Items.homeless,
    Items.molotov,
    Items.punch,
    Items.shuriken,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),
            _buildItemsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    final items = _type == Types.good ? gudItems : badItems;
    return Expanded(
      child: ListView.separated(
        key: ValueKey(_type),
        shrinkWrap: true,
        itemCount: items.length,
        separatorBuilder: (context, index) => const Divider(
          indent: 110,
          color: NGTheme.purple2,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemListTile(item: item);
        },
      ),
    );
  }

  Row _buildAppBar(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              LinerButton(
                side: LinerSide.top,
                onPressed: () => context.pop(),
                child: Text('<', style: textTheme.displayLarge),
              ),
            ],
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 8),
            Text(
              'Book of Knowledge'.tr(),
              style: textTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            TypePicker(
              onChanged: (type) {
                setState(() {
                  _type = type;
                });
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
