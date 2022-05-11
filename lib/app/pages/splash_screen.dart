import 'dart:async';

import 'package:indianfastfoodrecipes/app/components/image/image_widget.dart';
import 'package:indianfastfoodrecipes/app/export.dart';
import 'package:indianfastfoodrecipes/app/pages/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static final dataStorage = GetStorage();
  @override
  void initState() {
    super.initState();
    startTime();
    // getLocation();
  }

  startTime() async {
    return Timer(
      const Duration(seconds: 2),
      () {
        Get.offAll(const HomeScreen());
      },
    );
  }

  void navigationPage() async {
    bool? status = dataStorage.read("isLoggedIn");
    String? token = dataStorage.read('token');
    if (token == null) {
      // Get.offAll(MainHomeScreen(
      //   initialPageIndex: 0,
      // ));
    } else if (token.isNotEmpty && status == true) {
      // Get.offAll(MainHomeScreen(
      //   initialPageIndex: 0,
      // ));

    } else {
      // Get.to(LoginScreen());
    }
  }

  // getLocation() async {
  //   // final Position position = await CommonRepository.getCurrentLocation();

  //   // dataStorage.write('latitude', position.latitude);
  //   // dataStorage.write('longitude', position.longitude);

  //   await CurrentAddress.getCurrentAddress();
  //   debugPrint('\x1b[92m--- City : ${dataStorage.read('city')}');

  //   debugPrint(
  //       "\x1b[97m Latitude : ${dataStorage.read('latitude')}  Longitude : ${dataStorage.read('longitude')}");
  //   startTime();
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryWhite,
      body: Center(
        child: NetworkImageWidget(
          imageUrl:
              'https://mh-1-stockagency.panthermedia.net/media/media_detail/0025000000/25101000/~cartoon-funny-chef-cartoon-holding-platter_25101436_detail.jpg',
       
       height: 350,
       width: 350,
        ),
      ),
      // ),
    );
  }
}
