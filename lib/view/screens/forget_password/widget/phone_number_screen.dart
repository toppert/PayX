
import 'package:phone_number/phone_number.dart';
import 'package:payx/controller/auth_controller.dart';
import 'package:payx/controller/forget_password_controller.dart';
import 'package:payx/helper/phone_cheker.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/styles.dart';
import 'package:payx/view/base/custom_app_bar.dart';
import 'package:payx/view/base/custom_country_code_picker.dart';
import 'package:payx/view/base/custom_logo.dart';
import 'package:payx/view/base/custom_large_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/view/base/custom_snackbar.dart';
class FphoneNumberScreen extends StatefulWidget {
  final String phoneNumber,countryCode;
  const FphoneNumberScreen({Key key, this.phoneNumber, this.countryCode}) : super(key: key);

  @override
  _FphoneNumberScreenState createState() => _FphoneNumberScreenState();
}

class _FphoneNumberScreenState extends State<FphoneNumberScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
     super.initState();
     Get.find<ForgetPassController>().setInitialCode(widget.countryCode);
     phoneNumberController.text = widget.phoneNumber;

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: CustomAppbar(
          title: 'forget_password_appbar'.tr,
        ),
        body: Column(
          children: [
            Expanded(
              // flex: 10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
                    ),
                    CustomLogo(
                      height: Dimensions.BIG_LOGO,
                      width: Dimensions.BIG_LOGO,
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: Text(
                        'forget_pass_long_text'.tr,
                        style: rubikRegular.copyWith(
                          color: ColorResources.getBlackColor(),
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),
                    Container(
                      height: 52,
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Center(
                        child: TextField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          cursorColor: ColorResources.getPrimaryColor(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SIZE_SMALL),
                              borderSide: BorderSide(
                                color: ColorResources.getPrimaryColor(),
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SIZE_SMALL),
                              borderSide: BorderSide(
                                color: ColorResources.textFieldBorderColor,
                                width: 1,
                              ),
                            ),
                            prefixIcon: CustomCountryCodePiker(
                              initSelect: Get.find<ForgetPassController>().countryCode,
                              onChanged: (code) {
                                print(code);
                                Get.find<ForgetPassController>().setCountryCode(code);
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GetBuilder<AuthController>(builder: (controller){
              return Container(
                height: 110,
                child: !controller.isLoading ? CustomLargeButton(
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  text: 'Send_for_OTP'.tr,
                  onTap: () async{
                    String phoneNumber = Get.find<ForgetPassController>().countryCode + phoneNumberController.text;
                    PhoneNumber number = await PhoneChecker.isNumberValid(phoneNumber);
                    print('f number-------->: $number');
                    if(number != null ){
                      Get.find<ForgetPassController>().sendForOtpResponse(context: context,phoneNumber: phoneNumberController.text);
                    }
                    else{
                      showCustomSnackBar('please_input_your_valid_number'.tr,isError: true);
                    }
                  },
                ) : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),),
              );
            }),
          ],
        ),
      ),
    );

  }

}
