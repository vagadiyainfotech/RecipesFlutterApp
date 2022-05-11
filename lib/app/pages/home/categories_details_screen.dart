import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:indianfastfoodrecipes/app/components/image/image_widget.dart';
import 'package:indianfastfoodrecipes/app/controller/home_controller.dart';
import 'package:indianfastfoodrecipes/app/export.dart';
import 'package:indianfastfoodrecipes/app/pages/home/categories_recipes_screen.dart';
import 'package:indianfastfoodrecipes/utils/adsId.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final dynamic dataList;
  final String title;
  final bool fromCategories;
  InterstitialAd? _interstitialAd;

  CategoriesDetailsScreen({Key? key,
    required this.title,
    required this.dataList,
    this.fromCategories = false})
      : super(key: key);
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      body: GetBuilder<HomeController>(
          initState: (state) {},
          builder: (controller) {
            return SafeArea(
              child: Column(
                children: [
                  UiInterface.headerWidget(title: title),
                  Expanded(
                    child: Container(
                      color: primaryWhite,
                      width: Get.width,
                      child: dataList != null && dataList.length != 0
                          ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataList.length,
                          padding: const EdgeInsets.all(15),
                          itemBuilder: (context, int index) {
                            controller.loadNative();
                            return Column(
                              children: [
                           index==2?Container(
                            child: AdWidget(ad: controller.ad!),
                            height: 72.0,
                            alignment: Alignment.center,
                            ):Container(),
                                GestureDetector(
                                  onTap: () async {
                                    if (controller.isRewardedAdReady.isTrue) {
                                      controller.rewardedAd?.show(
                                          onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
                                            if (fromCategories == true)
                                            {
                                              await controller.getCategoryById(
                                                context,
                                                dataList[index]['id'],
                                              );

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoriesDetailsScreen(
                                                          title: controller
                                                              .categoryList[index]
                                                          ['name']
                                                              .toUpperCase(),
                                                          dataList: controller
                                                              .categoryDetailsList),
                                                ),
                                              );

                                              controller.update();
                                            } else {
                                              controller.indexxx.value=index;
                                              createInterstial();

                                            }
                                          }
                                      );
                                    }
                                    else{
                                      if (fromCategories == true)
                                      {
                                        await controller.getCategoryById(
                                          context,
                                          dataList[index]['id'],
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CategoriesDetailsScreen(
                                                    title: controller
                                                        .categoryList[index]
                                                    ['name']
                                                        .toUpperCase(),
                                                    dataList: controller
                                                        .categoryDetailsList),
                                          ),
                                        );

                                        controller.update();
                                      } else {
                                        Get.to(
                                              () =>
                                              CategoryRecipesScreen(
                                                title: dataList[index]['name'],
                                                image: dataList[index]['image'],
                                                ingredients: dataList[index]
                                                ['material'],
                                                method: dataList[index]['method'],
                                                link: dataList[index]['link'],
                                              ),
                                        );
                                      }
                                    }

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              circular30BorderRadius,
                                              child: dataList[index]['image'] !=
                                                  null
                                                  ? NetworkImageWidget(
                                                imageUrl: dataList[index]
                                                ['image'],
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              )
                                                  : Image.asset(
                                                AppAsset.pizza,
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            width10,
                                            Text(
                                              dataList[index]['name'],
                                              style:
                                              AppTextStyle.normalRegular15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      )
                          : Center(
                          child: Text(
                            'No Items Found',
                            style: AppTextStyle.normalSemiBold18,
                          )),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
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
            Get.to(
                  () =>
                  CategoryRecipesScreen(
                    title: dataList[controller.indexxx.value]['name'],
                    image: dataList[controller.indexxx.value]['image'],
                    ingredients: dataList[controller.indexxx.value]
                    ['material'],
                    method: dataList[controller.indexxx.value]['method'],
                    link: dataList[controller.indexxx.value]['link'],
                  ),
            );
            this._interstitialAd=null;

          },

        ));





  }
  void showAds() {
    _interstitialAd!.fullScreenContentCallback=FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad){

        },
        onAdDismissedFullScreenContent: (InterstitialAd ad){

          Get.to(
                () =>
                CategoryRecipesScreen(
                  title: dataList[controller.indexxx.value]['name'],
                  image: dataList[controller.indexxx.value]['image'],
                  ingredients: dataList[controller.indexxx.value]
                  ['material'],
                  method: dataList[controller.indexxx.value]['method'],
                  link: dataList[controller.indexxx.value]['link'],
                ),
          );
          ad.dispose();
        },onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError error){
      Get.to(
            () =>
            CategoryRecipesScreen(
              title: dataList[controller.indexxx.value]['name'],
              image: dataList[controller.indexxx.value]['image'],
              ingredients: dataList[controller.indexxx.value]
              ['material'],
              method: dataList[controller.indexxx.value]['method'],
              link: dataList[controller.indexxx.value]['link'],
            ),
      );

      ad.dispose();
      createInterstial();
    }
    );
    _interstitialAd!.show();
  }
}
