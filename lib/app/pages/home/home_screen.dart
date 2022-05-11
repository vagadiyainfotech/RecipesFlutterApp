import 'dart:developer';
import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:indianfastfoodrecipes/app/components/image/image_widget.dart';
import 'package:indianfastfoodrecipes/app/controller/home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:indianfastfoodrecipes/app/components/image/image_widget.dart';
import 'package:indianfastfoodrecipes/app/export.dart';
import 'package:indianfastfoodrecipes/app/pages/home/categories_details_screen.dart';
import 'package:indianfastfoodrecipes/app/pages/home/categories_recipes_screen.dart';
import 'package:indianfastfoodrecipes/app/utils/ui.dart';
import 'dart:math' as math;

import 'package:indianfastfoodrecipes/utils/adsId.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  bool heartIcon = false;
  InterstitialAd? _interstitialAd;
  int numb_failed_attemp=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      body: SafeArea(
        child: GetBuilder<HomeController>(
          initState: (state) {
            controller.callInit(context);
          },
          builder: (controller) {
            return Column(
              children: [
                UiInterface.headerWidget(
                  title: 'Indian Fast Food Recipes',
                  isBackArrow: false,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: primaryWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sliderWidget(dataList: controller.carouselList),
                          if (controller.categoryList != null &&
                              controller.categoryList.length != 0)
                            categoriesWidget(),
                          specialItemWidget(
                            title: 'Recommended',
                            dataList: controller.recommended,
                          ),
                          specialItemWidget(
                            title: 'Most Shared',
                            dataList: controller.mostShared,
                          ),
                          height20,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget categoriesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CATEGORIES',
                style: AppTextStyle.normalBold20,
              ),
              InkWell(
                onTap: () {
                  controller.status.value='1';
                  createInterstial();

                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        height05,
        SizedBox(
          height: 130,
          child: ListView.builder(
            itemCount: controller.categoryList.length,
            shrinkWrap: true,
            padding:const EdgeInsets.only(left:20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: categoriesItem(index),
            ),
          ),
        ),
      ],
    );
  }

  Widget categoriesItem(int index) {
    return InkWell(
      onTap: () async {
        await controller.getCategoryById(
          context,
          controller.categoryList[index]['id'],
        );
        Get.to(
          () => CategoriesDetailsScreen(
            dataList: controller.categoryDetailsList,
            title: controller.categoryList[index]['name'].toUpperCase(),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: circular10BorderRadius,
                child: controller.categoryList[index]['image'] != null
                    ? NetworkImageWidget(
                        imageUrl: controller.categoryList[index]['image'],
                        height: 110,
                        width: 110,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        AppAsset.pizza,
                        height: 110,
                        width: 110,
                        fit: BoxFit.fill,
                      ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: circular10BorderRadius,
                    color: blackColor.withOpacity(0.2),
                  ),
                ),
              )
            ],
          ),
          Center(
            child: Text(
              controller.categoryList[index]['name']!.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyle.normalBold16.copyWith(
                color: primaryWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget specialItemWidget({required String title, required dynamic dataList}) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height10,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.normalBold20,
              ),
              InkWell(
                onTap: () {
                  if(title=='Most Shared') {
                    controller.status.value = '3';
                  }
                  else{
                    controller.status.value = '2';
                  }

                  createInterstial();

                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        height10,
        UiInterface.buildHorizontalDivider(
          height: 1,
          padding: 10,
        ),
        SizedBox(
          height: 200,
          child: dataList != null && dataList.length != 0
              ? ListView.builder(
                  itemCount: dataList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemBuilder: (BuildContext context, int index) {
                    return listItemWidget(index: index, dataList: dataList);
                  },
                )
              : Center(
                  child: Text(
                    'No Data Found',
                    style: AppTextStyle.normalSemiBold16,
                  ),
                ),
        ),
      ],
    );
  }

  Widget listItemWidget({required int index, required dynamic dataList}) {
    return InkWell(
      onTap: () {

        Get.to(
          () => CategoryRecipesScreen(
            title: dataList[index]['name'],
            image: dataList[index]['image'],
            ingredients: dataList[index]['material'],
            method: dataList[index]['method'],
            link: dataList[index]['link'],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    height: 200,
                    width: 150,
                    child: NetworkImageWidget(
                      imageUrl: dataList[index]['image'].toString(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                      child: Container(
                        height: 50,
                        width: 150,
                        padding: const EdgeInsets.all(8.0),
                        color: whiteColor.withOpacity(0.70),
                        child: Center(
                          child: Text(
                            dataList[index]['name'] != null
                                ? dataList[index]['name'].toUpperCase()
                                : "N/A",
                            style: AppTextStyle.normalBold12,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                height: 25,
                width: 25,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: grey.withOpacity(0.30),
                    border: Border.all(
                        color: dataList[index]['NonVeg_Veg'] == 'Veg'
                            ? greenColor
                            : red),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Container(
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                    color: dataList[index]['NonVeg_Veg'] == 'Veg'
                        ? greenColor
                        : red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderWidget({required dynamic dataList}) {
    return dataList != null && dataList.length != 0
        ? CarouselSlider(
            options: CarouselOptions(
              height: Get.height / 3.5,
              autoPlay: true,
              viewportFraction: 1,
              disableCenter: true,
              initialPage: 1,
              pageSnapping: false,
              pauseAutoPlayOnTouch: true,
              scrollPhysics: const NeverScrollableScrollPhysics(),
              enlargeCenterPage: true,
            ),
            items: List.generate(
              dataList.length != 0 ? dataList.length : 0,
              (index) => InkWell(
                onTap: () {
                  print('sds');
                  Get.to(
                    () => CategoryRecipesScreen(
                      title: dataList[index]['TodaySpecial']['name'],
                      image: dataList[index]['TodaySpecial']['image'],
                      ingredients: dataList[index]['TodaySpecial']['material'],
                      method: dataList[index]['TodaySpecial']['method'],
                      link: dataList[index]['TodaySpecial']['link'],
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: circular20BorderRadius,
                              ),
                              width: Get.width,
                              child: NetworkImageWidget(
                                imageUrl: dataList[index]['TodaySpecial']
                                        ['image']
                                    .toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  padding: const EdgeInsets.all(8.0),
                                  color: whiteColor.withOpacity(0.70),
                                  child: Center(
                                    child: Text(
                                      dataList[index]['TodaySpecial']['name'] !=
                                              null
                                          ? dataList[index]['TodaySpecial']
                                                  ['name']
                                              .toUpperCase()
                                          : "N/A",
                                      style: AppTextStyle.normalBold12,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          height: 25,
                          width: 25,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: grey.withOpacity(0.30),
                              border: Border.all(
                                  color: dataList[index]['TodaySpecial']
                                              ['NonVeg_Veg'] ==
                                          'Veg'
                                      ? greenColor
                                      : red),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                              color: dataList[index]['TodaySpecial']
                                          ['NonVeg_Veg'] ==
                                      'Veg'
                                  ? greenColor
                                  : red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Offstage();
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
            numb_failed_attemp=0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
            numb_failed_attemp+1;
            this._interstitialAd=null;
            if( controller.status.value=='1') {
              Get.to(
                    () =>
                    CategoriesDetailsScreen(
                      title: 'Categories'.toUpperCase(),
                      dataList: controller.categoryList,
                      fromCategories: true,
                    ),
              );
            }
            else if(controller.status.value=='3'){
              Get.to(
                    () => CategoriesDetailsScreen(
                  title: 'Most Shared',
                  dataList: controller.mostShared,
                ),
              );
            }
            else if(controller.status.value=='2'){
              Get.to(
                    () => CategoriesDetailsScreen(
                  title: 'Recommended',
                  dataList: controller.recommended,
                ),
              );

            }

          },

        ));
  }
  void showAds() {
    _interstitialAd!.fullScreenContentCallback=FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad){

        },
        onAdDismissedFullScreenContent: (InterstitialAd ad){
          if( controller.status.value=='1') {
            Get.to(
                  () =>
                  CategoriesDetailsScreen(
                    title: 'Categories'.toUpperCase(),
                    dataList: controller.categoryList,
                    fromCategories: true,
                  ),
            );
          }
          else if(controller.status.value=='3'){
            Get.to(
                  () => CategoriesDetailsScreen(
                title: 'Most Shared',
                dataList: controller.mostShared,
              ),
            );
          }
          else if(controller.status.value=='2'){
            Get.to(
                  () => CategoriesDetailsScreen(
                title: 'Recommended',
                dataList: controller.recommended,
              ),
            );

          }


          ad.dispose();
        },onAdFailedToShowFullScreenContent: (InterstitialAd ad,AdError error){
      if( controller.status.value=='1') {
        Get.to(
              () =>
              CategoriesDetailsScreen(
                title: 'Categories'.toUpperCase(),
                dataList: controller.categoryList,
                fromCategories: true,
              ),
        );
      }
      else if(controller.status.value=='3'){
        Get.to(
              () => CategoriesDetailsScreen(
            title: 'Most Shared',
            dataList: controller.mostShared,
          ),
        );
      }
      else if(controller.status.value=='2'){
        Get.to(
              () => CategoriesDetailsScreen(
            title: 'Recommended',
            dataList: controller.recommended,
          ),
        );

      }

      ad.dispose();
      createInterstial();
    }
    );
    _interstitialAd!.show();
  }
}
