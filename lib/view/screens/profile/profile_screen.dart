import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:payx/controller/auth_controller.dart';
import 'package:payx/controller/profile_screen_controller.dart';
import 'package:payx/controller/splash_controller.dart';
import 'package:payx/helper/route_helper.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/util/styles.dart';
import 'package:payx/view/base/appbar_home_element.dart';
import 'package:payx/view/base/custom_ink_well.dart';
import 'package:payx/view/screens/profile/widget/menu_item.dart' as widget;
import 'package:payx/view/screens/profile/widget/profile_holder.dart';
import 'package:payx/view/screens/profile/widget/profile_shimmer.dart';
import 'package:payx/view/screens/profile/widget/two_factor_menu.dart';
import 'package:payx/view/screens/profile/widget/user_info.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppbarHomeElement(title: 'profile'.tr),
        body: GetBuilder<AuthController>(
          builder: (progressController) {
            return ModalProgressHUD(
              inAsyncCall: progressController.isLoading,
              progressIndicator: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GetBuilder<ProfileController>(builder: (profileController) {
                      return profileController.isLoading
                          ? ProfileShimmer()
                          : UserInfo(profileController: profileController);
                    }),
                    ProfileHeader(title: 'setting'.tr),
                    Container(
                      child: Column(
                        children: [
                          CustomInkWell(
                              child: widget.MenuItem(
                                  image: Images.edit_profile,
                                  title: 'edit_profile'.tr),
                              onTap: () {
                                Get.toNamed(RouteHelper.getEditProfileRoute())
                                    .then((value) =>
                                        Get.find<ProfileController>()
                                            .profileData(loading: true));
                              }),
                          CustomInkWell(
                              child: widget.MenuItem(
                                  image: Images.request_list_image2,
                                  title: 'requests'.tr),
                              onTap: () => Get.toNamed(
                                  RouteHelper.getRequestedMoneyRoute())),
                          CustomInkWell(
                              child: widget.MenuItem(
                                  image: Images.my_requested_list_image,
                                  title: 'send_requests'.tr),
                              onTap: () => Get.toNamed(
                                  RouteHelper.getRequestedMoneyRoute(
                                      from: 'won'))),
                          CustomInkWell(
                              child: widget.MenuItem(
                                  image: Images.pinChange_logo,
                                  title: 'change_pin'.tr),
                              onTap: () =>
                                  Get.toNamed(RouteHelper.getChangePinRoute())),
                          CustomInkWell(
                              child: widget.MenuItem(
                                  image: Images.language_logo,
                                  title: 'change_language'.tr),
                              onTap: () => Get.toNamed(
                                  RouteHelper.getChoseLanguageRoute())),
                          if (Get.find<SplashController>()
                              .configModel
                              .twoFactor)
                            GetBuilder<ProfileController>(
                                builder: (profileController) {
                              return profileController.isLoading
                                  ? TwoFactorShimmer()
                                  : TwoFactorMenu();
                            }),
                          GetBuilder<ProfileController>(
                            builder: (profileController) {
                              return Container(
                                padding: EdgeInsets.only(
                                    top: Dimensions.PADDING_SIZE_SMALL,
                                    bottom: Dimensions.PADDING_SIZE_SMALL),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                      child: Image.asset(
                                        Images.change_theme,
                                        width:
                                            Dimensions.PROFILE_PAGE_ICON_SIZE,
                                      ),
                                    ),
                                    Text('dark_mode'.tr,
                                        style: rubikRegular.copyWith(
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE)),
                                    Spacer(),
                                    Transform.scale(
                                      scale: 1,
                                      child: Switch(
                                        onChanged:
                                            profileController.toggleSwitch,
                                        value: profileController.isSwitched,
                                        activeColor: Colors.black26,
                                        activeTrackColor: Colors.grey,
                                        inactiveThumbColor: Colors.white,
                                        inactiveTrackColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    ProfileHeader(title: 'Pay-x_support'.tr),
                    Column(
                      children: [
                        if (((splashController.configModel.companyEmail !=
                                null) ||
                            (splashController.configModel.companyPhone !=
                                null)))
                          CustomInkWell(
                              child: widget.MenuItem(
                                  image: Images.support_logo,
                                  title: '24_support'.tr),
                              onTap: () =>
                                  Get.toNamed(RouteHelper.getSupportRoute())),
                        CustomInkWell(
                            child: widget.MenuItem(
                                image: Images.question_logo, title: 'faq'.tr),
                            onTap: () => Get.toNamed(RouteHelper.faq))
                      ],
                    ),
                    ProfileHeader(title: 'policies'.tr),
                    Column(
                      children: [
                        CustomInkWell(
                            child: widget.MenuItem(
                                image: Images.about_us, title: 'about_us'.tr),
                            onTap: () => Get.toNamed(RouteHelper.about_us)),
                        CustomInkWell(
                            child: widget.MenuItem(
                                image: Images.terms, title: 'terms'.tr),
                            onTap: () => Get.toNamed(RouteHelper.terms)),
                        CustomInkWell(
                            child: widget.MenuItem(
                                image: Images.privacy,
                                title: 'privacy_policy'.tr),
                            onTap: () => Get.toNamed(RouteHelper.privacy))
                      ],
                    ),
                    ProfileHeader(title: 'account'.tr),
                    Column(
                      children: [
                        CustomInkWell(
                            child: widget.MenuItem(
                                image: Images.log_out, title: 'logout'.tr),
                            onTap: () =>
                                Get.find<ProfileController>().logOut(context)),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
