import 'package:flutter/material.dart';

class SwipeUpWidget extends StatefulWidget {
  const SwipeUpWidget({
    Key key,
  }) : super(key: key);

  @override
  _SwipeUpWidgetState createState() => _SwipeUpWidgetState();
}

class _SwipeUpWidgetState extends State<SwipeUpWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    animation = Tween<double>(begin: 10, end: 0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, animation.value),
              child: const Icon(
                Icons.keyboard_arrow_up,
                size: 32,
                color: Colors.white,
              ),
            );
          },
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Swipe up for details",
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
