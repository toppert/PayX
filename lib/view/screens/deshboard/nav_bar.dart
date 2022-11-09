import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:payx/controller/menu_controller.dart';
import 'package:payx/controller/profile_screen_controller.dart';
import 'package:payx/controller/qr_code_scanner_controller.dart';
import 'package:payx/controller/requested_money_controller.dart';
import 'package:payx/controller/transaction_history_controller.dart';
import 'package:payx/helper/notification_helper.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/view/base/animated_custom_dialog.dart';
import 'package:payx/view/base/logout_dialog.dart';
import 'package:payx/view/screens/deshboard/widget/gradient_border.dart';

class NavBarScreen extends StatefulWidget {
  NavBarScreen({Key key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, false);
      Get.find<ProfileController>().profileData(loading: true);
      Get.find<RequestedMoneyController>().getRequestedMoneyList(1,context ,reload: true );
      Get.find<RequestedMoneyController>().getOwnRequestedMoneyList(1 ,reload: true );
      Get.find<TransactionHistoryController>().getTransactionData(1, reload: true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.find<ProfileController>().profileData(loading: true);
       Get.find<RequestedMoneyController>().getRequestedMoneyList(1,context ,reload: true );
       Get.find<RequestedMoneyController>().getOwnRequestedMoneyList(1 ,reload: true );
       Get.find<TransactionHistoryController>().getTransactionData(1, reload: true);
    });
  }

  @override
  Widget build(BuildContext context) {

    final qrScannerController = Get.find<QrCodeScannerController>();

    return WillPopScope(
          onWillPop: () => _onWillPop(context),
          child: GetBuilder<MenuController>(builder: (menuController) {
            return Scaffold(
              backgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
              body: PageStorage(bucket: bucket, child: menuController.currentScreen),
              floatingActionButton: UnicornOutlineButton(strokeWidth: 1.5, radius: 50,
                gradient: LinearGradient(colors: [ColorResources.gradientColor, ColorResources.gradientColor.withOpacity(0.5), ColorResources.secondaryColor.withOpacity(0.3), ColorResources.gradientColor.withOpacity(0.05), ColorResources.gradientColor.withOpacity(0),], begin: Alignment.topCenter, end: Alignment.bottomCenter),


                child: FloatingActionButton(backgroundColor: Theme.of(context).secondaryHeaderColor, elevation: 1,
                  onPressed: () =>  qrScannerController.scanQR(transactionType: '',isHome: true),


                    child: Padding(padding: const EdgeInsets.all(15.0), child: Image.asset(Images.scanner_icon)))),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: Container(height: 60, decoration: BoxDecoration(color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                boxShadow: [BoxShadow(color: ColorResources.getBlackAndWhite().withOpacity(0.14), blurRadius: 80, offset: const Offset(0, 20)), BoxShadow(color: ColorResources.getBlackAndWhite().withOpacity(0.20), blurRadius: 0.5, offset: const Offset(0, 0)),],
              ),



                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    customBottomItem(tap: () => menuController.selectHomePage(),
                      icon: menuController.currentTab == 0 ? Images.home_icon_bold : Images.home_icon, name: 'home'.tr, selectIndex: 0,),
                    customBottomItem(tap: () => menuController.selectHistoryPage(),
                      icon: menuController.currentTab == 1 ? Images.clock_icon_bold : Images.clock_icon, name: 'history'.tr, selectIndex: 1),
                    const SizedBox(height: 20, width: 20),
                    customBottomItem(tap: () => menuController.selectNotificationPage(),
                      icon: menuController.currentTab == 2 ? Images.notification_icon_bold : Images.notification_icon, name: 'notification'.tr, selectIndex: 2,
                    ),
                    customBottomItem(tap: () => menuController.selectProfilePage(),
                      icon: menuController.currentTab == 3 ? Images.profile_icon_bold : Images.profile_icon, name: 'profile'.tr, selectIndex: 3,
                    ),
                  ],
                ),
              ),
            );
          }),
        );


  }

  Future<bool> _onWillPop(BuildContext context) async {
    showAnimatedDialog(context,
        CustomDialog(
          icon: Icons.exit_to_app_rounded, title: 'exit'.tr, description: 'do_you_want_to_exit_the_app'.tr, onTapFalse:() => Navigator.of(context).pop(false),
          onTapTrue:() {
            SystemNavigator.pop();
            },
          onTapTrueText: 'yes'.tr, onTapFalseText: 'no'.tr,
        ),
        dismissible: false,
        isFlip: true);
    return true;
  }

  Widget customBottomItem({String icon, String name, VoidCallback tap, int selectIndex}) {
    return InkWell(onTap: tap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Dimensions.NAVBAR_ICON_SIZE, width: Dimensions.NAVBAR_ICON_SIZE,
            child: Image.asset(icon, fit: BoxFit.contain, color: Get.find<MenuController>().currentTab == selectIndex
                  ? ColorResources.getPrimaryTextColor() : ColorResources.nevDefaultColor,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(name, style: TextStyle(color: Get.find<MenuController>().currentTab == selectIndex
              ? ColorResources.getPrimaryTextColor() : ColorResources.nevDefaultColor, fontSize: Dimensions.NAVBAR_FONT_SIZE, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
