import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/controller/auth_controller.dart';
import 'package:payx/controller/image_controller.dart';
import 'package:payx/controller/profile_screen_controller.dart';
import 'package:payx/helper/route_helper.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/view/base/animated_custom_dialog.dart';
import 'package:payx/view/base/custom_app_bar.dart';
import 'package:payx/view/base/custom_large_button.dart';
import 'package:payx/view/base/custom_snackbar.dart';
import 'package:payx/view/base/my_dialog.dart';
import 'package:payx/view/screens/auth/other_info/widget/gender_selection.dart';
import 'package:payx/view/screens/auth/other_info/widget/input_section.dart';

class OtherInfoScreen extends StatefulWidget {
  const OtherInfoScreen({Key key}) : super(key: key);

  @override
  State<OtherInfoScreen> createState() => _OtherInfoScreenState();
}

class _OtherInfoScreenState extends State<OtherInfoScreen> {
  TextEditingController occupationTextController = TextEditingController();
  TextEditingController fNameTextController = TextEditingController();
  TextEditingController lNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: Scaffold(
        //backgroundColor: ColorResources.getWhiteColor(),
        appBar: CustomAppbar(
          title: 'information'.tr,
          onTap: (){
            _onWillPop(context);
          },
        ),
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GenderSelectionSection(),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    //OccupationSelectionSection(),
                    InputSection(
                      occupationController: occupationTextController,
                      fNameController: fNameTextController,
                      lNameController: lNameTextController,
                      emailController: emailTextController,
                    ),
                    const SizedBox(
                      height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE,
                    ),
                  ],
                ),
              ),
            ),
            GetBuilder<ProfileController>(builder: (getController) {
              return Container(
                height: 110,
                child: CustomLargeButton(
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  text: 'proceed'.tr,
                  onTap: () {
                    if (fNameTextController.text == '' || lNameTextController.text == '') {
                      showCustomSnackBar('first_name_or_last_name_must_not_be_null'.tr, isError: true);
                    }
                    else {
                      if(emailTextController.text != ''){
                        bool _emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailTextController.text);
                        if(!_emailValid){
                          showCustomSnackBar('please_provide_valid_email'.tr, isError: true);
                        }
                        else{
                          Get.toNamed(RouteHelper.getPinSetRoute(
                            fName: fNameTextController.text,
                            lName: lNameTextController.text,
                            email: emailTextController.text,
                            occupation: occupationTextController.text,
                          ));
                        }
                      }
                      else{
                        print('without email');
                        Get.toNamed(RouteHelper.getPinSetRoute(
                          fName: fNameTextController.text,
                          lName: lNameTextController.text,
                          email: emailTextController.text,
                          occupation: occupationTextController.text,
                        ));
                      }
                      //showCustomSnackBar('Successfully done', context, isError: false);
                    }
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Future _onWillPop(BuildContext context) async {

      showAnimatedDialog(context,
          MyDialog(
            icon: Icons.clear,
            title: 'alert'.tr,
            description: 'your_information_will_remove'.tr,
            isFailed: true,
            showTwoBtn: true,
            onTap: (){
                Get.find<ImageController>().removeImage();
                Get.find<AuthController>().change(0);
                return Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
            },
          ),
          dismissible: false,
          isFlip: true);



  }

 /* Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove your setup information'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Get.find<ImageController>().removeImage();
                  Get.offAllNamed(RouteHelper.getChoseLoginRegRoute());
                },
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }*/
}
