import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:indianfastfoodrecipes/app/utils/colors.dart';
import 'pages/splash_screen.dart';

class IndianFastFoodRecipes extends StatefulWidget {
  const IndianFastFoodRecipes({Key? key}) : super(key: key);
  @override
  _IndianFastFoodRecipesState createState() => _IndianFastFoodRecipesState();
}

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey<NavigatorState>(debugLabel: "navigator");

class _IndianFastFoodRecipesState extends State<IndianFastFoodRecipes> {
  @override
  void initState() {
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((deviceToken) {
    //   debugPrint('\x1b[97m DEVICE TOKEN : ' + deviceToken.toString());

    //   setToken(deviceToken);
    //   notificationConfiguration();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Indian Fast Food Recipes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: primaryWhite,
          scaffoldBackgroundColor: appBlackColor,
          hintColor: primaryWhite,
          primaryColor: primaryWhite,
          fontFamily: "NunitoSans",
          iconTheme: const IconThemeData(color: primaryBlack, size: 24),
          appBarTheme: const AppBarTheme(
            elevation: 1,
            backgroundColor: primaryWhite,
            foregroundColor: primaryWhite,
            centerTitle: true,
          )),
      home: const SplashScreen(),
    );
  }
}
