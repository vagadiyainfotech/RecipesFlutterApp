

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:indianfastfoodrecipes/app/export.dart';
import 'package:indianfastfoodrecipes/utils/adsId.dart';

class HomeController extends GetxController {
  NetworkRepository networkRepository = NetworkRepository();
  dynamic categoryList;
  dynamic carouselList;
  dynamic categoryDetailsList;
  dynamic rateAppData;
  dynamic privacyPolicyData;
  dynamic shareAppData;
  dynamic disclaimerData;
  dynamic mostShared;
  dynamic recommended;
  dynamic dataList;
  callInit(context) {
    getCategory(context);
    specialViewByid2(2);
    specialViewByid(1);
    getCarouselView();
    privacyPolicy();
    rateApp();
    shareApp();
    disclaimer();
    loadNative();
    showRewardAds();
  }
  // TODO: Add _kAdIndex
   RxInt kAdIndex = 4.obs;
    RxString status=''.obs;
  // TODO: Add a NativeAd instance
   NativeAd? ad;
   RewardedAd? rewardedAd;
   RxString nextscreen=''.obs;
    RxInt indexxx=0.obs;
    RxInt indexHome=0.obs;
  // TODO: Add _isRewardedAdReady
  RxBool isRewardedAdReady = false.obs;
  // TODO: Add _isAdLoaded
  RxBool isAdLoaded = false.obs;

  getCategory(context) async {
    var response = await networkRepository.getCategory(context);

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      categoryList = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  getCarouselView() async {
    var response = await networkRepository.getCarousel();

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      carouselList = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  specialViewByid(id) async {
    var response = await networkRepository.specialViewById(id);

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      mostShared = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  specialViewByid2(id) async {
    var response = await networkRepository.specialViewById(id);

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      recommended = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  getCategoryById(context, id) async {
    var response = await networkRepository.getCategoryDetailsById(context, id);

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      categoryDetailsList = response['data'];
    } else if (response['detail'] == 'Not found.') {
      categoryDetailsList = null;
    } else {
      // CommonMethod()
      //     .getXSnackBar("Error", 'Error in Category Details get', red);
    }
    update();
  }

  privacyPolicy() async {
    var response = await networkRepository.privacyPolicy();

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      privacyPolicyData = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  rateApp() async {
    var response = await networkRepository.rateApp();

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      rateAppData = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  shareApp() async {
    var response = await networkRepository.shareApp();

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      shareAppData = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  disclaimer() async {
    var response = await networkRepository.disclaimer();

    // ignore: unnecessary_null_comparison
    if (response != null && response['status'] == 'success') {
      disclaimerData = response['data'];
    } else {
      // CommonMethod().getXSnackBar("Error", 'Error in Category get', red);
    }
    update();
  }

  void loadNative() {
    // TODO: Create a NativeAd instance
    isAdLoaded.value=false;
    ad = new NativeAd(
      adUnitId: adsId.nativeId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
            isAdLoaded.value = true;

        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          loadNative();
          print('Ad load failed (code=${error.code} message=${error.message})');       },
      ),
    );
    ad?.load();
  }

  void showRewardAds() {
    RewardedAd.load(
      adUnitId: adsId.rewardId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          this.rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              isRewardedAdReady.value = false;

              showRewardAds();
            },
          );

          isRewardedAdReady.value = true;

        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');

            isRewardedAdReady.value = false;
          showRewardAds();
        },
      ),
    );

  }

}
