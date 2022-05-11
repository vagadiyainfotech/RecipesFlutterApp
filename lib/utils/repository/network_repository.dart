import 'package:indianfastfoodrecipes/app/export.dart';

class NetworkRepository {
  static final NetworkRepository _networkRepository =
      NetworkRepository._internal();
  static final dataStorage = GetStorage();

  factory NetworkRepository() {
    return _networkRepository;
  }
  NetworkRepository._internal();

  FocusNode searchFocus = FocusNode();

  privacyPolicy() async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.privacyPolicy);

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  rateApp() async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.rateApp);

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  shareApp() async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.shareApp);

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  specialView() async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.specialView);

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  specialViewById(id) async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          url: ApiAppConstants.apiEndPoint +
              '${ApiAppConstants.specialViewInformation}$id');

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  disclaimer() async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.disclaimer);

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  getCategory(
    context,
  ) async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          context: context,
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.categoryView);

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  getCarousel() async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          // context: context,
          url: ApiAppConstants.apiEndPoint + ApiAppConstants.carouselView);

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  getCategoryDetailsById(context, id) async {
    try {
      final response = await NetworkDioHttp.getDioHttpMethod(
          context: context,
          url: ApiAppConstants.apiEndPoint +
              "${ApiAppConstants.categoryDetailsView}$id");

      return checkResponse(
        response,
      );
    } catch (e) {
      CommonMethod().getXSnackBar("Error", e.toString(), red);
    }
  }

  // Image upload
  // Future uploadImage({context, selectedImage, uploadType}) async {
  //   String url = '${AppConstants.apiEndPoint}/upload/compress/$uploadType';
  //   var request = http.MultipartRequest(
  //     "POST",
  //     Uri.parse("$url"),
  //   );

  //   final token = await NetworkDioHttp.getHeaders();
  //   request.headers.addAll(token);
  //   request.files.add(
  //       await http.MultipartFile.fromPath("image", selectedImage.toString()));
  //   if (context != null) Circle().show(context);
  //   var response = await request.send();

  //   var responseData = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   var parsedJson = await json.decode(responseString);

  //   if (context != null) Circle().hide(context);
  //   if (response.statusCode == 200) {
  //     return UpdateImageModel.fromJson(parsedJson);
  //   } else {
  //     return '';
  //   }
  // }

  Future<void> checkResponse(
    response,
  ) async {
    if (response["error_description"] == null ||
        response["error_description"] == 'null') {
      // if (response['body']['status'] == 'success') {
      return response['body'];
      // }
      // else if (response['body']['status'] == 500 ||
      //     response['body']['status'] == "500") {
      //   return modelResponse;
      // }
      // else {
      //   showErrorDialog(message: response['body']['detail']);
      // }
    } else {
      return response['body'];
      // if (response['body']['status'] == 401 ||
      //     response['body']['status'] == '401') {
      //   showErrorDialog(message: response['body']['message']);
      //   // Future.delayed(Duration(seconds: 2), () {
      //   //   Get.to(LoginScreen());
      //   // });
      // } else {
      //   showErrorDialog(message: response['body']['message']);
      // }
    }
  }

  void showErrorDialog({required String message}) {
    CommonMethod().getXSnackBar("Error", message.toString(), red);
  }
}
