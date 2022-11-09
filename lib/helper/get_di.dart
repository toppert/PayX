import 'dart:convert';
import 'package:payx/controller/banner_controller.dart';
import 'package:payx/controller/create_account_controller.dart';
import 'package:payx/controller/edit_profile_controller.dart';
import 'package:payx/controller/faq_controller.dart';
import 'package:payx/controller/forget_password_controller.dart';
import 'package:payx/controller/bootom_slider_controller.dart';
import 'package:payx/controller/add_money_controller.dart';
import 'package:payx/controller/menu_controller.dart';
import 'package:payx/controller/notification_controller.dart';
import 'package:payx/controller/qr_code_scanner_controller.dart';
import 'package:payx/controller/screen_shot_widget_controller.dart';
import 'package:payx/controller/requested_money_controller.dart';
import 'package:payx/controller/selfie_controller.dart';
import 'package:payx/controller/home_controller.dart';
import 'package:payx/controller/language_controller.dart';
import 'package:payx/controller/localization_controller.dart';
import 'package:payx/controller/profile_screen_controller.dart';
import 'package:payx/controller/auth_controller.dart';
import 'package:payx/controller/image_controller.dart';
import 'package:payx/controller/transaction_controller.dart';
import 'package:payx/controller/splash_controller.dart';
import 'package:payx/controller/theme_controller.dart';
import 'package:payx/controller/transaction_history_controller.dart';
import 'package:payx/controller/varification_controller.dart';
import 'package:payx/controller/websitelink_controller.dart';
import 'package:payx/data/api/api_client.dart';
import 'package:payx/data/repository/add_money_repo.dart';
import 'package:payx/data/repository/auth_repo.dart';
import 'package:payx/data/repository/banner_repo.dart';
import 'package:payx/data/repository/faq_repo.dart';
import 'package:payx/data/repository/language_repo.dart';
import 'package:payx/data/repository/notification_repo.dart';
import 'package:payx/data/repository/profile_repo.dart';
import 'package:payx/data/repository/requested_money_repo.dart';
import 'package:payx/data/repository/transaction_repo.dart';
import 'package:payx/data/repository/transaction_history_repo.dart';
import 'package:payx/data/repository/websitelink_repo.dart';
import 'package:payx/data/repository/splash_repo.dart';
import 'package:payx/util/app_constants.dart';
import 'package:payx/data/model/response/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
   Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => TransactionRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(),sharedPreferences: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => WebsiteLinkRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));
  Get.lazyPut(() => AddMoneyRepo(apiClient: Get.find()));
  Get.lazyPut(() => FaqRepo(apiClient: Get.find()));
  Get.lazyPut(() => NotificationRepo(apiClient: Get.find()));
  Get.lazyPut(() => RequestedMoneyRepo(apiClient: Get.find()));
  Get.lazyPut(() => TransactionHistoryRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
   Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => TransactionMoneyController(transactionRepo: Get.find(), authRepo: Get.find()));
  Get.lazyPut(() => AddMoneyController(addMoneyRepo:Get.find() ));
  Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => FaqController(faqrepo: Get.find()));
  Get.lazyPut(() => BottomSliderController());

  Get.lazyPut(() => MenuController());
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => HomeController());
  Get.lazyPut(() => CreateAccountController());
  Get.lazyPut(() => VarificationController(authRepo: Get.find()));
  Get.lazyPut(() => ImageController());
  Get.lazyPut(() => SelfieController());
  Get.lazyPut(() => ForgetPassController());
  Get.lazyPut(() => WebsiteLinkController(websiteLinkRepo: Get.find()));
  Get.lazyPut(() => QrCodeScannerController());
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));
  Get.lazyPut(() => TransactionHistoryController(transactionHistoryRepo: Get.find()));
  Get.lazyPut(() => EditProfileController(authRepo: Get.find()));
  Get.lazyPut(() => RequestedMoneyController(requestedMoneyRepo: Get.find()));
  Get.lazyPut(() => ScreenShootWidgetController());



  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}
