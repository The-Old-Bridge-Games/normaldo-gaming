import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:normaldo_gaming/domain/pull_up_game/mission.dart';
import 'package:normaldo_gaming/game/utils/utils.dart';

class MissionTile extends StatelessWidget {
  final Mission mission;
  final bool showProgress;

  const MissionTile({
    super.key,
    required this.mission,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: _buildExp(context),
      title: Text(
          mission.when(
            collectPizza: (exp, completeValue, isOneGame, description,
                    adsViewed, type, currentValue) =>
                mission.description
                    .plural(completeValue, args: [completeValue.toString()]),
            crashItem: (exp, completeValue, isOneGame, description, adsViewed,
                    item, type, currentValue) =>
                mission.description.plural(completeValue,
                    args: [item.name, completeValue.toString()]),
            passItem: (exp, completeValue, isOneGame, description, adsViewed,
                    item, type, currentValue) =>
                mission.description.plural(completeValue,
                    args: [item.name, completeValue.toString()]),
            reachLocation: (exp, description, adsViewed, completeValue,
                    isOneGame, type, currentValue) =>
                mission.description.tr(args: [
              Utils.locationIndexToString[completeValue] ?? 'UNKNOWN'
            ]),
            finishGame: (exp, description, adsViewed, completeValue, isOneGame,
                    type, currentValue) =>
                mission.description.tr(args: [
              Utils.locationIndexToString[completeValue] ?? 'UNKNOWN'
            ]),
          ),
          style: textTheme.displayMedium),
      subtitle:
          showProgress && !mission.isOneGame ? _buildSubtitle(context) : null,
    );
  }

  Widget _buildExp(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/pizza_pack1.png',
          fit: BoxFit.cover,
          width: 25,
          height: 25,
        ),
        const SizedBox(width: 8),
        Text(mission.exp.toString(), style: textTheme.displayMedium),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(mission.progressText, style: textTheme.displaySmall);
  }
}

// class MissionTile extends StatelessWidget {
//   static const height = 55.0;

//   const MissionTile({
//     required this.mission,
//     this.progressText,
//     super.key,
//   });

//   final Mission mission;
//   final String? progressText;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Card(
//       color: NGTheme.purple2,
//       margin: const EdgeInsets.only(bottom: 8.0),
//       child: SizedBox(
//         height: height,
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: _buildIcon(),
//             ),
//             Expanded(
//               child: Text(
//                 progressText == null
//                     ? mission.description
//                     : '${mission.description} $progressText',
//                 style: textTheme.bodySmall?.copyWith(fontSize: 12),
//               ),
//             ),
//             const SizedBox(width: 16.0),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIcon() {
//     Widget iconWrapper(String asset) {
//       return Image.asset(
//         asset,
//         fit: BoxFit.cover,
//         width: 25,
//         height: 25,
//       );
//     }

//     final starsIcons = switch (mission.exp) {
//       1 => iconWrapper('assets/images/pizza_pack1.png'),
//       2 => iconWrapper('assets/images/pizza_pack2.png'),
//       3 => iconWrapper('assets/images/pizza_pack3.png'),
//       _ => throw UnexpectedError(),
//     };

//     if (mission.completed) {
//       return Stack(
//         clipBehavior: Clip.none,
//         children: [
//           starsIcons,
//           Positioned(
//             bottom: -4,
//             right: -4,
//             child: Image.asset(
//               'assets/images/checkmark.png',
//               width: 25,
//               height: 18,
//             ),
//           ),
//         ],
//       );
//     } else {
//       return starsIcons;
//     }
//   }
// }
