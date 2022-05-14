import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String testId = 'ca-app-pub-3940256099942544/6300978111';

  static String homepageBannerId = 'ca-app-pub-8064702179639632/1894386584';
  static late BannerAd homepageAd;

  static void initializeAd() {
    homepageAdInit();
  }

  static void homepageAdInit() async {
    homepageAd = BannerAd(
        size: AdSize.banner,
        adUnitId: homepageBannerId
        ,
        listener: BannerAdListener(
            onAdLoaded: (ad) {},
            onAdClosed: (ad) {},
            onAdFailedToLoad: (ad, err) {}),
        request: const AdRequest());
    await homepageAd.load();
  }
}
