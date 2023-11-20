import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/ads/ads_cubit.dart';
import 'package:normaldo_gaming/application/shop_items_list/shop_items_list_cubit.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/domain/shop/entities/shop_item.dart';
import 'package:normaldo_gaming/ui/widgets/ads_overlay.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';
import 'package:normaldo_gaming/ui/widgets/earn_dollars_dialog.dart';

import 'widgets/shop_item_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  Future<void> _onItemPressed(BuildContext context, ShopItem item) async {
    if (item is DollarForAdItem) {
      final cubit = context.read<AdsCubit>();
      cubit.showAd(
          type: AdType.rewarded,
          onComplete: () {
            showDialog(
                context: context,
                builder: (context) => const EarnDollarsDialog(amount: 15));
            context.read<UserCubit>().addDollars(15);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AdsOverlay(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            return Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/dollar.png', height: 30),
                    const SizedBox(width: 8),
                    Text(
                      state.user.dollars.toString(),
                      style: textTheme.displayLarge,
                    ),
                  ],
                )
              ],
            );
          }),
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<ShopItemsListCubit, ShopItemsListState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              failed: (error) => Center(
                child: Column(
                  children: [
                    BouncingButton(
                        onPressed: () =>
                            context.read<ShopItemsListCubit>().loadList(),
                        child: const Icon(
                          Icons.replay,
                          size: 32,
                          color: Colors.white,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      'Loading error'.tr(),
                      style: textTheme.displayMedium,
                    ),
                    const SizedBox(height: 4),
                    if (error != null)
                      Text(
                        error.toString(),
                        style: textTheme.displaySmall,
                      )
                  ],
                ),
              ),
              success: (items) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ShopItemCard(
                        item: item,
                        onPressed: () => _onItemPressed(context, item),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
