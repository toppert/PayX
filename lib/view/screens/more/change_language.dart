
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/controller/localization_controller.dart';
import 'package:payx/util/app_constants.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/styles.dart';
import 'package:payx/view/base/custom_app_bar.dart';
import 'package:payx/view/base/custom_logo.dart';
import 'package:payx/view/base/custom_small_button.dart';
import 'package:payx/view/base/custom_snackbar.dart';
import 'package:payx/view/screens/more/widget/language_widget.dart';

class ChooseLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'language'.tr),
      body: GetBuilder<LocalizationController>(
          builder: (localizationController) {
        return Column(children: [
          Expanded(
              child: Center(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Center(
                    child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CustomLogo(
                            height: 150,
                            width: 150,
                          ),
                        ),
                        const SizedBox(height: Dimensions.PADDING_SIZE_OVER_LARGE,),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child:
                              Text('select_language'.tr, style: rubikMedium.copyWith(color: ColorResources.getPrimaryTextColor(),fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (1 / 1),
                          ),
                          itemCount: localizationController.languages.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => LanguageWidget(
                            languageModel:
                                localizationController.languages[index],
                            localizationController: localizationController,
                            index: index,
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                        Text('you_can_change_language'.tr,
                            style: rubikRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                              color: Theme.of(context).disabledColor,
                            )),
                      ]),
                )),
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, bottom: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
            child: Row(
              children: [
                Expanded(
                  child: CustomSmallButton(
                    onTap: () {
                      if (localizationController.languages.length > 0 &&
                          localizationController.selectedIndex != -1) {
                        localizationController.setLanguage(Locale(
                          AppConstants.languages[localizationController.selectedIndex]
                              .languageCode,
                          AppConstants.languages[localizationController.selectedIndex]
                              .countryCode,
                        ));
                        Get.back();
                      } else {
                        showCustomSnackBar('select_a_language'.tr,isError: false);
                      }
                    },
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    text: 'save'.tr,
                    textColor: ColorResources.getBlackColor(),
                  ),
                ),
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
