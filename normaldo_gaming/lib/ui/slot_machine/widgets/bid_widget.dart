import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
import 'package:normaldo_gaming/core/theme.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class BidWidget extends StatefulWidget {
  const BidWidget({
    required this.onBidChanged,
    required,
    super.key,
  });

  final void Function(int bid) onBidChanged;

  @override
  State<BidWidget> createState() => _BidWidgetState();
}

class _BidWidgetState extends State<BidWidget> {
  static const minBidStep = 5;

  late int _currentBid;

  void _onMinusPressed(int step) {
    setState(() {
      _currentBid -= step;
    });
    widget.onBidChanged(_currentBid);
  }

  void _onPlusPressed(int step) {
    setState(() {
      _currentBid += step;
    });
    widget.onBidChanged(_currentBid);
  }

  @override
  void initState() {
    super.initState();

    final dollars = context.read<UserCubit>().state.user.dollars;
    if (dollars < minBidStep) {
      _currentBid = 0;
    } else {
      _currentBid = minBidStep;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final increaseStyle =
        textTheme.displaySmall?.copyWith(color: NGTheme.green1);
    final decreaseStyle =
        textTheme.displaySmall?.copyWith(color: Colors.red[400]);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.user.dollars < _currentBid) {
          _currentBid = state.user.dollars - state.user.dollars % 5;
          widget.onBidChanged(_currentBid);
        }
      },
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _decreaseBidderWrapper(
            step: 100,
            child: BouncingButton(
              onPressed: () => _onMinusPressed(100),
              child: Text(
                '-100',
                style: decreaseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _decreaseBidderWrapper(
            step: 50,
            child: BouncingButton(
              onPressed: () => _onMinusPressed(50),
              child: Text(
                '-50',
                style: decreaseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _decreaseBidderWrapper(
            step: 5,
            child: BouncingButton(
              onPressed: () => _onMinusPressed(5),
              child: Text(
                '-5',
                style: decreaseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 70,
            child: Text(
              _currentBid.toString(),
              style: textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 16),
          _increaseBidderWrapper(
            step: 5,
            userDollars: state.user.dollars,
            child: BouncingButton(
              onPressed: () => _onPlusPressed(5),
              child: Text(
                '+5',
                style: increaseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _increaseBidderWrapper(
            step: 50,
            userDollars: state.user.dollars,
            child: BouncingButton(
              onPressed: () => _onPlusPressed(50),
              child: Text(
                '+50',
                style: increaseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _increaseBidderWrapper(
            step: 100,
            userDollars: state.user.dollars,
            child: BouncingButton(
              onPressed: () => _onPlusPressed(100),
              child: Text(
                '+100',
                style: increaseStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decreaseBidderWrapper({required int step, required Widget child}) {
    return AnimatedOpacity(
      opacity: _currentBid > step ? 1 : 0.3,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: _currentBid < step,
        child: child,
      ),
    );
  }

  Widget _increaseBidderWrapper({
    required int step,
    required int userDollars,
    required Widget child,
  }) {
    return AnimatedOpacity(
      opacity: _currentBid + step <= 999 && userDollars > _currentBid + step
          ? 1
          : 0.3,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring:
            !(_currentBid + step <= 999 && userDollars > _currentBid + step),
        child: child,
      ),
    );
  }
}
