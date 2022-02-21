import 'dart:async';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<String> controller = StreamController<String>();

  final Stopwatch stopwatch = Stopwatch();
  static const Color activeColor = Colors.black;
  static const Color disableColor = Colors.grey;
  static const String initialData = "00:00:000";
  static const String title = "Stop Watch";
  List<String> targetList = [];

  static const NeumorphicStyle buttonStyle = NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle(),
      shape: NeumorphicShape.concave,
      depth: 8,
      oppositeShadowLightSource: false,
      intensity: 8);

  void startStopWatch() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
      startWatch();
    }
  }

  Widget customIcon({required IconData icon}) => Padding(
      padding: const EdgeInsets.all(18.0),
      child: Icon(icon, color: activeColor));

  void startWatch() {
    if (stopwatch.isRunning) {
      Timer.periodic(
        const Duration(milliseconds: 30),
        (timer) {
          var milli = stopwatch.elapsed.inMilliseconds;
          String millisecond = (milli % 1000).toString().padLeft(3, "0");
          String second = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
          String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");
          controller.add("$minutes:$second:$millisecond");
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
          title: NeumorphicText(title,
              textStyle: NeumorphicTextStyle(fontSize: 26),
              style: const NeumorphicStyle(color: activeColor)),
          centerTitle: true),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Neumorphic(
                style: buttonStyle,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: stopwatch.isRunning ? activeColor : disableColor,
                        width: 4),
                  ),
                  alignment: Alignment.center,
                  child: StreamBuilder<Object>(
                    initialData: initialData,
                    stream: controller.stream,
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data.toString(),
                        style: TextStyle(
                            fontSize: 40,
                            color: stopwatch.isRunning
                                ? activeColor
                                : disableColor),
                      );
                    }, 
                  ),
                ),
              ),
              Neumorphic(
                style: const NeumorphicStyle(
                  depth: 8,
                  oppositeShadowLightSource: false,
                  intensity: 8,
                  shape: NeumorphicShape.concave,
                ),
                margin: const EdgeInsets.all(18),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Icon(Icons.flag),
                            NeumorphicText(
                              " TARGETS",
                              textStyle: NeumorphicTextStyle(
                                fontSize: 18,
                              ),
                              style: const NeumorphicStyle(color: activeColor),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        targetList.clear();
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.delete, size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        targetList.isNotEmpty
                            ? Expanded(
                                child: Scrollbar(
                                  isAlwaysShown: true,
                                  child: ListView.builder(
                                    itemCount: targetList.length,
                                    itemBuilder: (context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                            "#${index + 1}    ${targetList[index]}"),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const Expanded(
                                child: Center(
                                  child: Text("No targets found !"),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NeumorphicButton(
                    style: buttonStyle,
                    child: customIcon(icon: Icons.refresh),
                    onPressed: () => stopwatch.reset(),
                  ),
                  NeumorphicButton(
                    style: buttonStyle,
                    child: customIcon(icon: Icons.flag),
                    onPressed: () {
                      setState(
                        () {
                          if (stopwatch.isRunning) {
                            var milli = stopwatch.elapsed.inMilliseconds;
                            String millisecond =
                                (milli % 1000).toString().padLeft(3, "0");
                            String second = ((milli ~/ 1000) % 60)
                                .toString()
                                .padLeft(2, "0");
                            String minutes = ((milli ~/ 1000) ~/ 60)
                                .toString()
                                .padLeft(2, "0");
                            String value = "$minutes:$second:$millisecond";
                            targetList.add(value);
                          }
                        },
                      );
                    },
                  ),
                  NeumorphicButton(
                    style: buttonStyle,
                    child: customIcon(
                        icon: stopwatch.isRunning
                            ? Icons.pause
                            : Icons.play_arrow),
                    onPressed: () {
                      startStopWatch();
                      setState(() {});
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
