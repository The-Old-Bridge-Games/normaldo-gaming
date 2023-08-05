import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:normaldo_gaming/application/user/cubit/user_cubit.dart';
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
  static const bidStep = 5;

  late int _currentBid;

  void _onMinusPressed() {
    setState(() {
      _currentBid -= bidStep;
    });
    widget.onBidChanged(_currentBid);
  }

  void _onPlusPressed() {
    setState(() {
      _currentBid += bidStep;
    });
    widget.onBidChanged(_currentBid);
  }

  @override
  void initState() {
    super.initState();

    final dollars = context.read<UserCubit>().state.user.dollars;
    if (dollars < 5) {
      _currentBid = 0;
    } else {
      _currentBid = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.user.dollars < _currentBid) {
          _currentBid = state.user.dollars - state.user.dollars % 5;
          widget.onBidChanged(_currentBid);
        }
      },
      builder: (context, state) => Column(
        children: [
          Text('Bid'.tr(), style: textTheme.displayLarge),
          const SizedBox(height: 8),
          SizedBox(
            width: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Visibility(
                    visible: _currentBid > 5,
                    child: BouncingButton(
                      onPressed: _onMinusPressed,
                      child: Text(
                        '-',
                        style: textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                  _currentBid.toString(),
                  style: textTheme.displayLarge,
                  textAlign: TextAlign.center,
                )),
                Expanded(
                  child: Visibility(
                    visible: _currentBid < 100 &&
                        state.user.dollars >= _currentBid + bidStep,
                    child: BouncingButton(
                      onPressed: _onPlusPressed,
                      child: Text(
                        '+',
                        style: textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
