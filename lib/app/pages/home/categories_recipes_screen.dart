import 'dart:typed_data';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:indianfastfoodrecipes/app/components/image/image_widget.dart';
import 'package:indianfastfoodrecipes/app/controller/home_controller.dart';
import 'package:indianfastfoodrecipes/app/export.dart';
import 'package:indianfastfoodrecipes/app/pages/home/widget/settings_widget.dart';
import 'package:indianfastfoodrecipes/utils/adsId.dart';
import 'package:screenshot/screenshot.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CategoryRecipesScreen extends StatefulWidget {
  final String title;
  final dynamic ingredients;
  final dynamic method;
  final String image;
  final String link;
  CategoryRecipesScreen({
    Key? key,
    required this.ingredients,
    required this.title,
    required this.method,
    required this.image,
    required this.link,
  }) : super(key: key);

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  late YoutubePlayerController videocontroller;

  ScreenshotController screenshotController = ScreenshotController();

  Uint8List? screenShotPath;
  InterstitialAd? _interstitialAd;

  HomeController controller = Get.put(HomeController());
  RxBool isFullscreenVideo = false.obs;
  void listener() {
    if (mounted && videocontroller.value.isFullScreen) {
      isFullscreenVideo.value = true;
      setState(() {});
    }
    if (mounted && !videocontroller.value.isFullScreen) {
      isFullscreenVideo.value = false;
      setState(() {});
    }
    if(mounted && videocontroller.value.isReady){
      bool ads=true;
      print('---------Completed');
      if(ads) {
        print('---------Completed---');
       // createInterstial();
        setState(() {
          ads=false;

        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async {
        return false;
        },
      child: Scaffold(
        backgroundColor: primaryBlack,
        body: SafeArea(
          child: GetBuilder<HomeController>(initState: (state) {
            String videoId;
            videoId = YoutubePlayer.convertUrlToId(widget.link)!;
            videocontroller = YoutubePlayerController(
              initialVideoId: videoId,
              flags: const YoutubePlayerFlags(
                mute: false,
                autoPlay: false,
                disableDragSeek: true,
                loop: false,
                isLive: false,
                forceHD: false,

                // controlsVisibleAtStart: false,
                // hideControls: true,

                enableCaption: true,
              ),
            )..addListener(listener);
          }, builder: (controller) {
            return Obx(
              () => isFullscreenVideo.value
                  ? YoutubePlayer(
                      controller: videocontroller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: primaryBlack,
                      onEnded: (event) {
                        // Get.back();
                      },
                      onReady: () {
                        videocontroller.play();
                        setState(() {});
                      },
                    )
                  : Column(
                      children: [
                        UiInterface.headerWidget(
                          title: widget.title,
                        ),
                        YoutubePlayer(
                          controller: videocontroller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: primaryBlack,
                          onEnded: (event) {
                            // Get.back();
                          },
                          onReady: () {
                            // videocontroller.play();
                            setState(() {});
                          },
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              color: primaryWhite,
                              child: Column(
                                children: [
                                  UiInterface.buildHorizontalDivider(
                                    height: 1,
                                    padding: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            widget.title,
                                            style: AppTextStyle.normalBold24,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.share,
                                        color: primaryBlack,
                                      )
                                    ],
                                  ),


                                  UiInterface.buildHorizontalDivider(
                                    height: 1,
                                    padding: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      'Ingredients'.toUpperCase(),
                                      style: AppTextStyle.normalSemiBold16,
                                    ),
                                  ),
                                  height10,
                                  loadNativeAds(),
                                  Html(data: widget.ingredients),
                                  height20,
                                  Center(
                                    child: Text(
                                      'Method'.toUpperCase(),
                                      style: AppTextStyle.normalSemiBold16,
                                    ),
                                  ),
                                  height10,
                                  Html(data: widget.method),
                                  height20,
                                  Center(
                                    child: Text(
                                      'Result'.toUpperCase(),
                                      style: AppTextStyle.normalSemiBold16,
                                    ),
                                  ),
                                  height10,
                                  ClipRRect(
                                    borderRadius: circular10BorderRadius,
                                    child: NetworkImageWidget(
                                      imageUrl: widget.image,
                                      height: 200,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          }),
        ),
      ),
    );
  }

  willpopscop() async{

    return false;
  }

  void createInterstial() {
    InterstitialAd.load(
        adUnitId: adsId.interstialId,
        request: AdRequest(),

        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
            showAds();

          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');

            this._interstitialAd=null;

          },

        ));





  }
  void showAds() {
    _interstitialAd!.fullScreenContentCallback=FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad){

        },
        onAdDismissedFullScreenContent: (InterstitialAd ad){


          ad.dispose();
        },onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError error){


      ad.dispose();
      createInterstial();
    }
    );
    _interstitialAd!.show();
  }

  void backScreen() {

    Navigator.pop(context);
  }
  loadNativeAds() {
    if (controller.isAdLoaded.value ==
        true) {
      return Container(
        child: AdWidget(ad: controller.ad!),
        height: 72.0,
        alignment: Alignment.center,
      );
    }else{
      return Container();
    }
  }
}


