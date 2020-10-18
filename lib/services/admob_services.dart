import 'dart:io';
class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8926108791024988~9194319421';
    }
    return null;
  }
  String getBannerAdId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8926108791024988/3397700282';
      //Test ads Banner ca-app-pub-3940256099942544/6300978111
      //Real ads Banner ca-app-pub-8926108791024988/3397700282
    }
    return null;
  }
}