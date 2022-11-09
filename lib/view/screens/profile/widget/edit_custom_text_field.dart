import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/styles.dart';
import 'package:flutter/material.dart';
class EditCustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hint;
  final String levelText;
  const EditCustomTextField({Key key,this.controller,this.textInputType,this.hint,this.levelText}) : super(key: key);

  @override
  State<EditCustomTextField> createState() => _EditCustomTextFieldState();
}

class _EditCustomTextFieldState extends State<EditCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text(widget.levelText,
          style: rubikMedium.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          ),),
        ),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_SMALL,
        ),
        TextField(
          controller: widget.controller,
          keyboardType: widget.textInputType,
          textCapitalization: TextCapitalization.words,
          cursorColor: ColorResources.getPrimaryColor(),
          style: rubikRegular.copyWith(
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
            // letterSpacing: 1.0,
          ),
          decoration: InputDecoration(

            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 22),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
              borderSide: BorderSide(
                color: ColorResources.getPrimaryTextColor(),
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
              borderSide: BorderSide(
                color: ColorResources.textFieldBorderColor,
                width: 1,
              ),
            ),
            hintText: widget.hint,
            hintStyle: rubikRegular.copyWith(
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
