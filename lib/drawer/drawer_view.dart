import 'package:flutter/material.dart';
import 'package:smart_flare/smart_flare.dart';

class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PanFlareActor(
          width: 135,
          height: MediaQuery.of(context).size.height,
          filename: 'assets/drawer/slideout-menu.flr',
          openAnimation: 'open',
          closeAnimation: 'close',
          direction: ActorAdvancingDirection.RightToLeft,
          threshold: 20,
          reverseOnRelease: true,
          completeOnThresholdReached: true,
          activeAreas: [
            RelativeActiveArea(
              area: Rect.fromLTWH(0, 0.7, 1.0, 0.3),
              debugArea: false,
            ),
          ],
        ),
      ),
    );
  }
}
