import 'package:flutter/material.dart';
import 'package:instagram_story_viewer/data/repository.dart';
import 'package:instagram_story_viewer/indicator_widget.dart';
import 'package:instagram_story_viewer/swipe_up_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _sliderAnimationController;

  int _currentSlidingIndex = 0;

  @override
  void initState() {
    super.initState();

    _sliderAnimationController = AnimationController(vsync: this);
    _initiateSliding(itemsLength: car.urls.length, animateToPage: false);

    _sliderAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sliderAnimationController.stop();
        _sliderAnimationController.reset();
        setState(() {
          if (_currentSlidingIndex + 1 < car.urls.length) {
            _currentSlidingIndex++;
            _initiateSliding(itemsLength: car.urls.length);
          } else {
            _currentSlidingIndex = 0;
            _initiateSliding(itemsLength: car.urls.length);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sliderAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: List.generate(
                    car.urls.length,
                    (index) => IndicatorWidget(
                      animController: _sliderAnimationController,
                      position: index,
                      currentIndex: _currentSlidingIndex,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SwipeUpWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _initiateSliding(
      {@required int itemsLength, bool animateToPage = true}) {
    _sliderAnimationController.stop();
    _sliderAnimationController.reset();
    _sliderAnimationController.duration = Duration(seconds: 5 * itemsLength);
    _sliderAnimationController.forward();

    // if (animateToPage) {
    //   _pageController.animateToPage(
    //     _currentIndex,
    //     duration: const Duration(milliseconds: 1),
    //     curve: Curves.easeInOut,
    //   );
    // }
  }
}
