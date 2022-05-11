import 'package:flutter_html/flutter_html.dart';
import 'package:indianfastfoodrecipes/app/controller/home_controller.dart';
import 'package:indianfastfoodrecipes/app/export.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBlack,
      body: SafeArea(
          child: Column(
        children: [
          UiInterface.headerWidget(
            title: 'Privacy Policy',
          ),
          Expanded(
            child: Container(
              padding:const EdgeInsets.all(15),
              color: primaryWhite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.privacyPolicyData.length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Html(
                        data: controller.privacyPolicyData[index]
                            ['privacypolicy'],),
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
