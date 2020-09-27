import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class BottomMenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: _BottomMenuWidget(),
        ),
      ),
    );
  }
}

class _BottomMenuWidget extends StatefulWidget {
  @override
  __BottomMenuWidgetState createState() => __BottomMenuWidgetState();
}

class __BottomMenuWidgetState extends State<_BottomMenuWidget> {
  static const double animationWidth = 295.0;
  static const double animationHeight = 251.0;
  bool isOpen = false;

  final FlareControls animationControls = FlareControls();
  AnimationToPlay _lastPlayedAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: animationWidth,
      height: animationHeight,
      child: GestureDetector(
        onTapUp: (info) {
          final localTouchPosition = (context.findRenderObject() as RenderBox).globalToLocal(info.globalPosition);
          final topHalfTouched = localTouchPosition.dy < animationHeight / 2;
          final leftSideTouched = localTouchPosition.dx < animationWidth / 3;
          final rightSideTouched = localTouchPosition.dx > (animationWidth / 3) * 2;
          final middleTouched = !leftSideTouched && !rightSideTouched;

          if (leftSideTouched && topHalfTouched) {
            _setAnimationToPlay(AnimationToPlay.CameraTapped);
          } else if (middleTouched && topHalfTouched) {
            _setAnimationToPlay(AnimationToPlay.PulseTapped);
          } else if (rightSideTouched && topHalfTouched) {
            _setAnimationToPlay(AnimationToPlay.ImageTapped);
          } else {
            if (isOpen) {
              _setAnimationToPlay(AnimationToPlay.Deactivate);
            } else {
              _setAnimationToPlay(AnimationToPlay.Activate);
            }

            isOpen = !isOpen;
          }
        },
        child: FlareActor(
          'assets/button_animation.flr',
          animation: 'deactivate',
          controller: animationControls,
        ),
      ),
    );
  }

  void _setAnimationToPlay(AnimationToPlay animation) {
    final isTappedAnimation = AnimationX.asString(animation).contains('_tapped');

    if (isTappedAnimation && _lastPlayedAnimation == AnimationToPlay.Deactivate) {
      return;
    }
    animationControls.play(AnimationX.asString(animation));

    _lastPlayedAnimation = animation;
  }
}

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped,
}

extension AnimationX on AnimationToPlay {
  static String asString(AnimationToPlay value) => {
        AnimationToPlay.Activate: 'activate',
        AnimationToPlay.Deactivate: 'deactivate',
        AnimationToPlay.CameraTapped: 'camera_tapped',
        AnimationToPlay.PulseTapped: 'pulse_tapped',
        AnimationToPlay.ImageTapped: 'image_tapped',
      }[value];
}
