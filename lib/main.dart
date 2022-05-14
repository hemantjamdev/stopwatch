import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stopwatch/splash.dart';

import 'ad_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///mobile ad initialize
  MobileAds.instance.initialize();

  /// banner ads initialize
  AdHelper.initializeAd();
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
