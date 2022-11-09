import 'package:payx/controller/forget_password_controller.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/styles.dart';
import 'package:payx/view/base/custom_password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PinFieldSection extends StatefulWidget {
  final TextEditingController newPassController, confirmPassController;

  const PinFieldSection({Key key,@required this.newPassController,@required this.confirmPassController}) : super(key: key);

  @override
  State<PinFieldSection> createState() => _PinFieldSectionState();
}

class _PinFieldSectionState extends State<PinFieldSection> {
  final FocusNode confirmFocus = FocusNode();

   @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPassController>(builder: (controller){
      return Container(
        margin: const EdgeInsets.only(
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
          vertical: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorResources.getWhiteColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
            topRight: Radius.circular(Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.RADIUS_SIZE_EXTRA_EXTRA_LARGE),
                child: Text(
                  'Set_new_4_digit_pin'.tr,
                  textAlign: TextAlign.center,
                  style: rubikMedium.copyWith(
                    color: ColorResources.getPrimaryTextColor(),
                    fontSize: Dimensions.FONT_SIZE_EXTRA_OVER_LARGE,
                  ),
                ),
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE,
              ),
              CustomPasswordField(
                controller: widget.newPassController,
                nextFocus: confirmFocus,
                isPassword: true,
                isShowSuffixIcon: true,
                isIcon: false,
                hint: '＊＊＊＊',

                letterSpacing: 10.0,
                fontSize: 24.0,
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
              ),
              CustomPasswordField(
                controller: widget.confirmPassController,
                focusNode: confirmFocus,
                hint: 'Confirm_Password'.tr,
                isShowSuffixIcon: true,
                isPassword: true,
                isIcon: false,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_OVER_LARGE),

            ],
          ),
        ),
      );
    });
  }
}
