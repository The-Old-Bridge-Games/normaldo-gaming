import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/ads/ads_cubit.dart';

class AdsOverlay extends StatelessWidget {
  const AdsOverlay({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          child,
          BlocBuilder<AdsCubit, AdsState>(builder: (context, state) {
            return state.maybeWhen(
              showing: () => _buildShowing(context),
              loading: () => _buildLoading(context),
              orElse: () => const SizedBox.shrink(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.black45,
      child: Center(
        child: Text('Loading...'.tr(), style: textTheme.displayLarge),
      ),
    );
  }

  Widget _buildShowing(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.black45,
      child: Center(
        child: Text('Showing Ad...'.tr(), style: textTheme.displayLarge),
      ),
    );
  }
}
