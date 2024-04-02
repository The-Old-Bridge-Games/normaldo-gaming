import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:normaldo_gaming/ui/missions/missions_list.dart';

class MissionsOnStartOverlay extends StatefulWidget {
  const MissionsOnStartOverlay({super.key});

  @override
  State<MissionsOnStartOverlay> createState() => _MissionsOnStartOverlayState();
}

class _MissionsOnStartOverlayState extends State<MissionsOnStartOverlay> {
  double _left = -1000;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300)).whenComplete(() {
      setState(() => _left = 16);
      Future.delayed(const Duration(seconds: 3))
          .whenComplete(() => setState(() => _left = -1000));
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: _left,
              width: MediaQuery.of(context).size.width / 2.5,
              child: const MissionsList(disabled: true),
            )
          ],
        ),
      ),
    );
  }
}
