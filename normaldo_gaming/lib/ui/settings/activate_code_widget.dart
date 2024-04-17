import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/core/widgets/blinking_text.dart';
import 'package:normaldo_gaming/core/widgets/blinking_widget.dart';
import 'package:normaldo_gaming/domain/skins/skins_repository.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';
import 'package:normaldo_gaming/ui/shop/widgets/shop_skin_card.dart';
import 'package:normaldo_gaming/ui/widgets/ng_button.dart';
import 'package:normaldo_gaming/ui/widgets/ng_text_field.dart';

class ActivateCodeWidget extends StatefulWidget {
  const ActivateCodeWidget({super.key});

  @override
  State<ActivateCodeWidget> createState() => _ActivateCodeWidgetState();
}

class _ActivateCodeWidgetState extends State<ActivateCodeWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
          child: NGTextField(
            controller: _controller,
            placeholder: 'Enter your code..'.tr(),
          ),
        ),
        const SizedBox(width: 32),
        NGButton(
            text: 'Submit'.tr(),
            onPressed: () {
              if (_controller.text.isEmpty) return;
              final result = context
                  .read<UserCubit>()
                  .activateCode(_controller.text.toUpperCase());
              final newSkin = result.$1;
              final error = result.$2;
              if (newSkin != null) {
                showDialog(
                    context: context,
                    barrierColor: Colors.black87,
                    builder: (context) => CodeActivatedWidget(skin: newSkin));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: NGTheme.purple2,
                    content: Text(
                      error ?? 'Unknown error',
                      style: textTheme.displayMedium,
                    )));
              }
              _controller.clear();
            }),
        const Spacer(),
      ],
    );
  }
}

class CodeActivatedWidget extends StatelessWidget {
  final Skin skin;

  const CodeActivatedWidget({super.key, required this.skin});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 32),
          BlinkingText(
            'SUCCESS!!!'.tr(),
            duration: const Duration(milliseconds: 500),
            endDelay: const Duration(seconds: 2),
            style: textTheme.displayLarge
                ?.copyWith(fontSize: 48, color: NGTheme.colorOf(skin.rarity)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlinkingWidget(
              startDelay: const Duration(seconds: 1),
              endDelay: const Duration(hours: 2),
              duration: const Duration(milliseconds: 500),
              child: Column(
                children: [
                  Text('You received:'.tr(), style: textTheme.displayLarge),
                  Expanded(
                    child: ShopSkinCard(skin: skin, fromShop: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
