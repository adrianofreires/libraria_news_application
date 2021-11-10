import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static Future<InitializationStatus> initialization() {
    return MobileAds.instance.initialize();
  }

  static String get bannerdUnitID {
    if (Platform.isAndroid) {
      return "ca-app-pub-7793520822431470/2455545513";
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7793520822431470/4893350052';
    } else {
      throw UnsupportedError('Plataforma não compatível para anúncios');
    }
  }

  static String get nativeAdvancedUnitID {
    if (Platform.isAndroid) {
      return "ca-app-pub-7793520822431470/8177811332";
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7793520822431470/6650775546';
    } else {
      throw UnsupportedError('Plataforma não compatível para anúncios');
    }
  }

  BannerAd createBannerAd() {
    BannerAd banner = BannerAd(
        size: AdSize.banner,
        adUnitId: bannerdUnitID,
        listener: BannerAdListener(onAdClosed: (Ad ad) {
          print("Ad Closed");
        }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        }, onAdLoaded: (Ad ad) {
          print('Ad Loaded');
        }, onAdOpened: (Ad ad) {
          print('Ad opened');
        }),
        request: AdRequest());
    return banner;
  }
}
