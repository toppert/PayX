import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/controller/splash_controller.dart';
import 'package:payx/data/model/response/notification_model.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/util/styles.dart';

class NotificationDialog extends StatelessWidget {
  final Notifications notificationModel;
  NotificationDialog({@required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.width-130, width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).primaryColor.withOpacity(0.20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                image: '${Get.find<SplashController>().configModel.baseUrls.notificationImageUrl}/${notificationModel.image}',
                height: MediaQuery.of(context).size.width-130, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                imageErrorBuilder: (c, o, s) => Image.asset(
                  Images.placeholder, height: MediaQuery.of(context).size.width-130,
                  width: MediaQuery.of(context).size.width, fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: Text(notificationModel.title, textAlign: TextAlign.center, style: rubikMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.FONT_SIZE_LARGE))),

          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(notificationModel.description, textAlign: TextAlign.center, style: rubikRegular)),

        ],
      ),
    );
  }
}
