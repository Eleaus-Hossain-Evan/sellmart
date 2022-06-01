import 'package:flutter/material.dart';

class BounceAnimation extends StatefulWidget {

  final Widget child;

  BounceAnimation({@required this.child, Key key}) : super(key: key);

  @override
  BounceState createState() => BounceState();
}

class BounceState extends State<BounceAnimation> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {

    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8, //tap down ratio
    ).animate(animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }
      });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(

      animation: animationController,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,

        child: widget.child,
      ),
    );
  }
}