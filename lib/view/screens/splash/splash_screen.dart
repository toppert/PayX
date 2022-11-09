import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:payx/controller/auth_controller.dart';
import 'package:payx/controller/splash_controller.dart';
import 'package:payx/helper/route_helper.dart';
import 'package:payx/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor:
              isNotConnected ? Colors.blue.shade900 : Colors.lightBlue,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    // Get.find<TransactionMoneyController>().getSuggestList();

    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((value) {
      if (value.isOk)
        Timer(Duration(seconds: 1), () async {
          Get.find<SplashController>().initSharedData().then((value) {
            (Get.find<AuthController>().getCustomerName().isNotEmpty &&
                    (Get.find<SplashController>().configModel.companyName !=
                        null))
                ? Get.offNamed(RouteHelper.getLoginRoute(
                    countryCode:
                        Get.find<AuthController>().getCustomerCountryCode(),
                    phoneNumber:
                        Get.find<AuthController>().getCustomerNumber()))
                : Get.offNamed(RouteHelper.getChoseLoginRegRoute());
          });
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.logo, height: 175),
          ],
        ),
      ),
    );
  }
}
