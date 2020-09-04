import 'package:flutter/material.dart';
import 'package:todoapp/widget/custom_progress_indecator.dart';

class TimerScreen extends StatefulWidget {
  static const routeId = '/timer';

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  int counter = 0;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final taskId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.amber,
                    height: animationController.value *
                        MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: AnimatedBuilder(
                                    animation: animationController,
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return CustomPaint(
                                          painter: CustomTimerPainter(
                                        animation: animationController,
                                        backgroundColor: Colors.white,
                                        color: Colors.red,
                                      ));
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Round: $counter",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      AnimatedBuilder(
                                          animation: animationController,
                                          builder: (BuildContext context,
                                              Widget child) {
                                            return Text(
                                              timerString,
                                              style: TextStyle(
                                                  fontSize: 112.0,
                                                  color: Colors.white),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                          animation: animationController,
                          builder: (context, child) {
                            return FloatingActionButton.extended(
                              backgroundColor: Colors.red,
                              onPressed: () {
                                if (animationController.isAnimating) {

                                  animationController.stop();
                                }
                                else {

                                  animationController.reverse(
                                      from: animationController.value == 0.0
                                          ? 1.0
                                          : animationController.value);
                                  setState(() {
                                    counter++;
                                  });
                                }
                              },
                              icon: Icon(animationController.isAnimating
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              label: Text(animationController.isAnimating
                                  ? "Pause"
                                  : "Play"),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
