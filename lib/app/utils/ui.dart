import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:indianfastfoodrecipes/app/export.dart';
import 'package:indianfastfoodrecipes/app/pages/home/widget/settings_widget.dart';

import '../../utils/adsId.dart';

class UiInterface {
  static Widget headerWidget(
      {required String title, bool isBackArrow = true, Function()? onBackTap}) {
    InterstitialAd? _interstitialAd;
    void createInterstial() {
      InterstitialAd.load(
          adUnitId: adsId.interstialId,
          request: AdRequest(),

          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              // Keep a reference to the ad so you can show it later.
              _interstitialAd = ad;
              _interstitialAd!.fullScreenContentCallback=FullScreenContentCallback(
                  onAdShowedFullScreenContent: (InterstitialAd ad){

                  },
                  onAdDismissedFullScreenContent: (InterstitialAd ad){
                    Get.back();

                    ad.dispose();
                  },onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError error){
                Get.back();

                ad.dispose();
                createInterstial();
              }
              );
              _interstitialAd!.show();

            },
            onAdFailedToLoad: (LoadAdError error) {
              print('InterstitialAd failed to load: $error');
              Get.back();
              _interstitialAd=null;

            },

          ));

    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Row(
        children: [
          if (isBackArrow)
            InkWell(
              onTap: onBackTap ??
                  () {
                    print('backjjjk');

                    createInterstial();
                  },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: primaryWhite,
                ),
              ),
            ),
          width05,
          Expanded(
            child: Text(
              title,
              style:
                  AppTextStyle.normalSemiBold16.copyWith(color: primaryWhite),
            ),
          ),
          InkWell(
            onTap: () {
              Get.bottomSheet(
                 SettingWidget(),
                backgroundColor: primaryWhite,
              );
            },
            child: const Icon(
              Icons.more_vert,
              color: primaryWhite,
            ),
          ),
        ],
      ),
    );
  }

  static Widget logoWidget() {
    return SvgPicture.asset(
      AppAsset.appLogo,
      cacheColorFilter: true,
      allowDrawingOutsideViewBox: true,
      width: 150,
      color: primaryButtonColor,
      fit: BoxFit.cover,
    );
  }

  static Widget plusDecoration({double? height}) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 35.0,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.75],
          colors: [darKYellowGradientColor, lightYellowGradientColor],
        ),
      ),
      child: Text(
        'plus',
        style: AppTextStyle.normalSemiBold20,
      ),
    );
  }

  static Widget plusDecorationWithBlackColor(
      {Color? backgroundColor, double? height, double? width}) {
    return Container(
      alignment: Alignment.center,
      height: height ?? 30,
      width: width ?? 60,
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor ?? titleBlack,
      ),
      child: Text(
        'plus',
        style: AppTextStyle.normalSemiBold18,
      ),
    );
  }

  // static Widget logoWidget() {
  //   return SvgPicture.asset(
  //     AppAsset.logo,
  //     color: appColor,
  //     height: 100,
  //     width: 80,
  //     fit: BoxFit.cover,
  //   );
  // }

  static Widget prefixTextFieldIcon(String assetIcon) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: SvgPicture.asset(
        assetIcon,
        color: darkGreyWhite.withOpacity(0.5),
        fit: BoxFit.contain,
      ),
    );
  }

  static Widget greyLineContainer() {
    return Container(
      height: 5,
      width: 35,
      decoration: BoxDecoration(
        color: darkGreyWhite,
        borderRadius: circular15BorderRadius,
      ),
    );
  }

  static Widget buildHorizontalDivider({double? padding, double? height}) =>
      Container(
        margin: EdgeInsets.symmetric(vertical: padding ?? 25),
        height: height ?? 2,
        color: grey.withOpacity(0.50),
      );

  static Widget verticalDivider({double? width}) {
    return Container(
      width: width ?? 1,
      height: 55,
      color: primaryWhite,
    );
  }

  static Widget swipeUpToCheckoutWidget(
      {String? itemCount, String? totalPrice}) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          UiInterface.greyLineContainer(),
          height05,
          Text(
            'Swipe up to checkout',
            style: AppTextStyle.normalBold14
                .copyWith(color: primaryWhite.withOpacity(0.68)),
          ),
          height05,
          RichText(
            text: TextSpan(
              text: '$itemCount items ',
              style: AppTextStyle.normalBold16,
              children: <TextSpan>[
                TextSpan(
                  text: '(\$$totalPrice)',
                  style: AppTextStyle.normalBold16.copyWith(
                    color: primaryButtonColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget cafeOfTheDayWidget({dynamic data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Container(
            width: Get.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: circular30BorderRadius,
            ),
            child: ClipRRect(
              borderRadius: circular30BorderRadius,
              child: Image.asset(
                AppAsset.staticImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          FractionalTranslation(
            translation: const Offset(0.0, -0.5),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: circular25BorderRadius, color: lightBlackColor),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAsset.icShopSymbol,
                        height: 20,
                        width: 20,
                        fit: BoxFit.contain,
                      ),
                      width10,
                      Text(
                        'Kedai Kapi Kulo',
                        style: AppTextStyle.normalBold18
                            .copyWith(color: primaryButtonColor),
                      ),
                    ],
                  ),
                  height10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppAsset.icClock),
                            customWidth(5),
                            Expanded(
                              child: Text(
                                'Closes at 9pm',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.normalRegular12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppAsset.icStar),
                            customWidth(5),
                            Expanded(
                              child: Text(
                                '4.5',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.normalRegular12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        // flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppAsset.icLocation),
                            customWidth(5),
                            Expanded(
                              child: Text(
                                '3 km away',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.normalRegular12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static cafeDetailsWidget({double? leftPadding, dynamic data}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(leftPadding ?? 40, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data != null ? data['name'] : "Fore Coffee",
            style: AppTextStyle.normalSemiBold16,
          ),
          height10,
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAsset.icClock),
                  customWidth(5),
                  Text(
                    data != null &&
                            data['properties'] != null &&
                            data['properties']['time'].toString() != 'null'
                        ? data['properties']['time']
                        : '20 min',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.normalRegular14,
                  ),
                ],
              ),
              width15,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAsset.icStar),
                  customWidth(5),
                  Text(
                    data != null && data['properties'] != null
                        ? data['properties']['rating']
                        : '4.5',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.normalRegular14,
                  ),
                ],
              ),
              width15,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAsset.icLocation),
                  customWidth(5),
                  Text(
                    data != null && data['properties'] != null
                        ? '${data['properties']['distance']} away'
                        : '3 km away',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.normalRegular14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget titleViewAllWidget(
      {required String title,
      VoidCallback? onTap,
      required bool isViewallVisible}) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toString(),
              style: AppTextStyle.normalBold18,
            ),
            Visibility(
              visible: isViewallVisible,
              child: InkWell(
                onTap: onTap,
                child: Text(
                  'See All',
                  style: AppTextStyle.normalBold14
                      .copyWith(color: primaryButtonColor),
                ),
              ),
            ),
          ],
        ));
  }
}

Widget commonAppBar(
    {required BuildContext context,
    required String title,
    Function()? onPressed,
    Widget? actionIcon}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        onTap: onPressed ??
            () {
              Get.back();
            },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: circularBorderRadius(18),
            border: Border.all(color: commongreycolor),
          ),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: whiteColor,
            size: 20,
          ),
        ),
      ),
      Text(title, style: AppTextStyle.normalBold18),
      actionIcon ??
          Container(
            width: 30,
          ),
    ],
  );

  // AppBar(
  //   backgroundColor: appColor,
  // leading: InkWell(
  //   onTap: onPressed ??
  //       () {
  //         Get.back();
  //       },
  //   child: Container(
  //     height: 20,
  //     width: 20,
  //     decoration: BoxDecoration(
  //       borderRadius: circularBorderRadius(23),
  //       border: Border.all(color: commongreycolor),
  //     ),
  //     child: const Icon(
  //       Icons.arrow_back_ios_outlined,
  //       color: whiteColor,
  //       size: 25,
  //     ),
  //   ),
  // ),
  //   actions: [
  //     Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         actionIcon ?? Container(),
  //       ],
  //     ),
  //   ],
  //   title: Text(title, style: AppTextStyle.normalBold18),
  //   elevation: 0.0,
  // );
}

Widget becomethepacesetter(
    {Alignment? begin,
    Alignment? end,
    Radius? topleft,
    Radius? topright,
    Radius? bottomleft,
    Radius? bottomright,
    double? padding,
    Function()? ontap}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: padding ?? 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: topleft ?? Radius.zero,
        topRight: topright ?? Radius.zero,
        bottomLeft: bottomleft ?? Radius.zero,
        bottomRight: bottomright ?? Radius.zero,
      ),
      gradient: LinearGradient(
        begin: begin ?? Alignment.topCenter,
        end: end ?? Alignment.bottomCenter,
        stops: const [0.0, 0.7],
        colors: const [lightYellowGradientColor, darKYellowGradientColor],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: ontap,
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: titleBlack,
              ),
              child: const Icon(
                Icons.close,
                color: primaryWhite,
                size: 20,
              ),
            ),
          ),
        ),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAsset.logo,
              color: titleBlack,
            ),
            customWidth(8),
            UiInterface.plusDecorationWithBlackColor(),
          ],
        ),
        customHeight(30),
        Text(
          'Become the pacesetter',
          style: AppTextStyle.normalBold18.copyWith(color: titleBlack),
        ),
        height10,
        Text(
          'Truly reinvent the tradition of takeaway coffee',
          style: AppTextStyle.normalSemiBold14.copyWith(color: titleBlack),
        ),
        customHeight(30),
        benefitsList('Use location services to pick-up your cup of coffee.'),
        height10,
        benefitsList('Skip queues'),
        height10,
        benefitsList('Cancel anytime'),
      ],
    ),
  );
}

Widget benefitsList(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 25,
        width: 25,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: titleBlack),
        child: const Icon(
          Icons.check,
          color: primaryWhite,
          size: 15,
        ),
      ),
      width10,
      Expanded(
        child: Text(
          title,
          style: AppTextStyle.normalSemiBold16.copyWith(color: titleBlack),
        ),
      )
    ],
  );
}
