import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stopwatch/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: const NeumorphicStyle(
          color: Colors.white,
          shape: NeumorphicShape.concave,
          depth: 8,
          oppositeShadowLightSource: false,
          intensity: 8),
      child: Center(
        child: NeumorphicIcon(
          Icons.timer,
          style: const NeumorphicStyle(
              color: Colors.white12,
              boxShape: NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.concave,
              depth: 10,
              shadowDarkColor: Colors.black,
              shadowLightColor: Colors.black,
              oppositeShadowLightSource: false,
              intensity: 0.5),
          size: 300,
        ),
      ),
    );
  }
}
