import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/ads/ads_cubit.dart';

class AdsOverlay extends StatelessWidget {
  const AdsOverlay({
    required this.child,
    super.key,
  });

  final Widget child;

  void _listener(BuildContext context, AdsState state) {
    state.when(
      initial: () {},
      loading: () {},
      showing: () {},
      failed: (e) {
        final textTheme = Theme.of(context).textTheme;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e,
          style: textTheme.displayMedium,
        )));
      },
      skipped: () {},
      completed: (completion) => completion(),
    );
  }

  Widget _builder(context, state) {
    return state.maybeWhen(
      showing: () => _buildShowing(context),
      loading: () => _buildLoading(context),
      orElse: () => const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          child,
          BlocConsumer<AdsCubit, AdsState>(
            builder: _builder,
            listener: _listener,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      color: Colors.black45,
      child: Center(
        child: Text('Loading...'.tr(), style: textTheme.displayLarge),
      ),
    );
  }

  Widget _buildShowing(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    return Container(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      color: Colors.black45,
      child: Center(
        child: Text('Showing Ad...'.tr(), style: textTheme.displayLarge),
      ),
    );
  }
}
