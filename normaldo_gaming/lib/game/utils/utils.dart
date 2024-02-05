import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

abstract class Utils {
  const Utils._();

  static const bigBuddyBinSpeedMultiplier = 1.5;

  static const linesCount = 5;

  static double generateCocktailDuration() => Random().nextInt(5) + 2;
  static double generateHourglassDuration() => generateCocktailDuration();

  static Path getSatellitePath(Vector2 size) {
    Path path_0 = Path();
    path_0.moveTo(size.x * 0.9927536, size.y * 0.5000000);
    path_0.cubicTo(size.x * 0.9927536, size.y * 0.5247750, size.x * 0.9902739,
        size.y * 0.5514231, size.x * 0.9844087, size.y * 0.5800900);
    path_0.cubicTo(size.x * 0.9785014, size.y * 0.6089550, size.x * 0.9694594,
        size.y * 0.6382937, size.x * 0.9572246, size.y * 0.6672187);
    path_0.cubicTo(size.x * 0.9327580, size.y * 0.7250625, size.x * 0.8968754,
        size.y * 0.7781500, size.x * 0.8519159, size.y * 0.8231125);
    path_0.cubicTo(size.x * 0.7621130, size.y * 0.9129125, size.x * 0.6376884,
        size.y * 0.9687500, size.x * 0.5000000, size.y * 0.9687500);
    path_0.cubicTo(size.x * 0.3623116, size.y * 0.9687500, size.x * 0.2378870,
        size.y * 0.9129125, size.x * 0.1480841, size.y * 0.8231125);
    path_0.cubicTo(size.x * 0.1031239, size.y * 0.7781500, size.x * 0.06724188,
        size.y * 0.7250625, size.x * 0.04277609, size.y * 0.6672187);
    path_0.cubicTo(size.x * 0.03054000, size.y * 0.6382937, size.x * 0.02149812,
        size.y * 0.6089550, size.x * 0.01559159, size.y * 0.5800900);
    path_0.cubicTo(
        size.x * 0.009725377,
        size.y * 0.5514231,
        size.x * 0.007246377,
        size.y * 0.5247750,
        size.x * 0.007246377,
        size.y * 0.5000000);
    path_0.cubicTo(
        size.x * 0.007246377,
        size.y * 0.4752250,
        size.x * 0.009725377,
        size.y * 0.4485769,
        size.x * 0.01559159,
        size.y * 0.4199100);
    path_0.cubicTo(size.x * 0.02149812, size.y * 0.3910450, size.x * 0.03054000,
        size.y * 0.3617088, size.x * 0.04277609, size.y * 0.3327794);
    path_0.cubicTo(size.x * 0.06724188, size.y * 0.2749356, size.x * 0.1031239,
        size.y * 0.2218481, size.x * 0.1480841, size.y * 0.1768888);
    path_0.cubicTo(size.x * 0.2378870, size.y * 0.08708562, size.x * 0.3623116,
        size.y * 0.03125000, size.x * 0.5000000, size.y * 0.03125000);
    path_0.cubicTo(size.x * 0.6376884, size.y * 0.03125000, size.x * 0.7621130,
        size.y * 0.08708562, size.x * 0.8519159, size.y * 0.1768888);
    path_0.cubicTo(size.x * 0.8968754, size.y * 0.2218481, size.x * 0.9327580,
        size.y * 0.2749356, size.x * 0.9572246, size.y * 0.3327794);
    path_0.cubicTo(size.x * 0.9694594, size.y * 0.3617088, size.x * 0.9785014,
        size.y * 0.3910450, size.x * 0.9844087, size.y * 0.4199100);
    path_0.cubicTo(size.x * 0.9902739, size.y * 0.4485769, size.x * 0.9927536,
        size.y * 0.4752250, size.x * 0.9927536, size.y * 0.5000000);
    path_0.close();
    return path_0;
  }

  static Path getSatellitePath2(Vector2 size) {
    Path path_0 = Path();
    path_0.moveTo(size.x * 0.9956140, size.y * 0.5000000);
    path_0.cubicTo(size.x * 0.9956140, size.y * 0.5028858, size.x * 0.9954912,
        size.y * 0.5101217, size.x * 0.9942632, size.y * 0.5221925);
    path_0.cubicTo(size.x * 0.9930175, size.y * 0.5344133, size.x * 0.9909474,
        size.y * 0.5485042, size.x * 0.9878333, size.y * 0.5637158);
    path_0.cubicTo(size.x * 0.9816228, size.y * 0.5940667, size.x * 0.9721842,
        size.y * 0.6245442, size.x * 0.9596491, size.y * 0.6541892);
    path_0.cubicTo(size.x * 0.9346404, size.y * 0.7133133, size.x * 0.8982632,
        size.y * 0.7669450, size.x * 0.8530939, size.y * 0.8121158);
    path_0.cubicTo(size.x * 0.7628070, size.y * 0.9024000, size.x * 0.6379675,
        size.y * 0.9583333, size.x * 0.5000000, size.y * 0.9583333);
    path_0.cubicTo(size.x * 0.3620325, size.y * 0.9583333, size.x * 0.2371930,
        size.y * 0.9024000, size.x * 0.1469061, size.y * 0.8121158);
    path_0.cubicTo(size.x * 0.1017351, size.y * 0.7669450, size.x * 0.06535904,
        size.y * 0.7133133, size.x * 0.04035167, size.y * 0.6541892);
    path_0.cubicTo(size.x * 0.02781281, size.y * 0.6245442, size.x * 0.01837518,
        size.y * 0.5940667, size.x * 0.01216447, size.y * 0.5637158);
    path_0.cubicTo(
        size.x * 0.009051754,
        size.y * 0.5485042,
        size.x * 0.006979026,
        size.y * 0.5344133,
        size.x * 0.005737877,
        size.y * 0.5221925);
    path_0.cubicTo(
        size.x * 0.004512070,
        size.y * 0.5101217,
        size.x * 0.004385965,
        size.y * 0.5028858,
        size.x * 0.004385965,
        size.y * 0.5000000);
    path_0.cubicTo(
        size.x * 0.004385965,
        size.y * 0.4971142,
        size.x * 0.004512070,
        size.y * 0.4898783,
        size.x * 0.005737877,
        size.y * 0.4778075);
    path_0.cubicTo(
        size.x * 0.006979026,
        size.y * 0.4655867,
        size.x * 0.009051754,
        size.y * 0.4514958,
        size.x * 0.01216447,
        size.y * 0.4362842);
    path_0.cubicTo(size.x * 0.01837518, size.y * 0.4059333, size.x * 0.02781281,
        size.y * 0.3754558, size.x * 0.04035167, size.y * 0.3458108);
    path_0.cubicTo(size.x * 0.06535904, size.y * 0.2866867, size.x * 0.1017351,
        size.y * 0.2330550, size.x * 0.1469061, size.y * 0.1878842);
    path_0.cubicTo(size.x * 0.2371930, size.y * 0.09759750, size.x * 0.3620325,
        size.y * 0.04166667, size.x * 0.5000000, size.y * 0.04166667);
    path_0.cubicTo(size.x * 0.6379675, size.y * 0.04166667, size.x * 0.7628070,
        size.y * 0.09759750, size.x * 0.8530939, size.y * 0.1878842);
    path_0.cubicTo(size.x * 0.8982632, size.y * 0.2330550, size.x * 0.9346404,
        size.y * 0.2866867, size.x * 0.9596491, size.y * 0.3458108);
    path_0.cubicTo(size.x * 0.9721842, size.y * 0.3754558, size.x * 0.9816228,
        size.y * 0.4059333, size.x * 0.9878333, size.y * 0.4362842);
    path_0.cubicTo(size.x * 0.9909474, size.y * 0.4514958, size.x * 0.9930175,
        size.y * 0.4655867, size.x * 0.9942632, size.y * 0.4778075);
    path_0.cubicTo(size.x * 0.9954912, size.y * 0.4898783, size.x * 0.9956140,
        size.y * 0.4971142, size.x * 0.9956140, size.y * 0.5000000);
    path_0.close();
    return path_0;
  }
}
