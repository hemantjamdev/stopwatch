import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stopwatch/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const StopWatchApp()));
}

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NeumorphicApp(
      themeMode: ThemeMode.light,
      title: "Stop Watch",
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
