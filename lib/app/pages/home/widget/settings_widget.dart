import 'package:indianfastfoodrecipes/app/controller/home_controller.dart';
import 'package:indianfastfoodrecipes/app/export.dart';
import 'package:indianfastfoodrecipes/app/pages/disclaimer_screen.dart';
import 'package:indianfastfoodrecipes/app/pages/privacy_policy_screen.dart';
import 'package:indianfastfoodrecipes/app/utils/ui.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingWidget extends StatelessWidget {
  SettingWidget({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Settings',
            style: AppTextStyle.normalSemiBold14,
          ),
          UiInterface.buildHorizontalDivider(height: 0.5, padding: 10),
          titleWidget(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              Get.to(() => PrivacyPolicyScreen());
            },
          ),
          height20,
          titleWidget(
            icon: Icons.star,
            title: 'Rate Us',
            onTap: () async {
              await launchUrl(
                  Uri.parse(controller.rateAppData[0]['rateApp'].toString()));
            },
          ),
          height20,
          titleWidget(
            icon: Icons.share,
            title: 'Share App',
            onTap: () async {
              /*    await launchUrl(
                  Uri.parse(controller.shareAppData[0]['shareapp'].toString()));*/
              Share.share(
                  'Please download Indian Fast Food Recipe App \n https://play.google.com/store/apps/details?id=indian.fastfood.recipes',
                  subject: 'Download and share with your froiends');
            },
          ),
          height20,
          titleWidget(
            icon: Icons.settings,
            title: 'Disclamier',
            onTap: () {
              Get.to(() => DisclaimerScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget titleWidget(
      {required IconData icon,
      required String title,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: grey,
          ),
          customWidth(20),
          Text(
            title,
            style: AppTextStyle.normalRegular16,
          ),
        ],
      ),
    );
  }
}
