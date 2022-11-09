
import 'package:flutter/material.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';

class CustomPasswordField extends StatefulWidget {
  final bool isShowSuffixIcon;
  final bool isPassword;
  final bool isIcon;
  final Function onSuffixTap;
  final String suffixIconUrl;
  final String hint;
  final TextAlign textAlign;
  final TextEditingController controller;
  final double fontSize,letterSpacing;
  final FocusNode nextFocus,focusNode;
  final TextInputAction textInputAction;
  CustomPasswordField({
    this.isShowSuffixIcon,
    this.isPassword,
    this.isIcon = false,
    this.onSuffixTap,
    this.suffixIconUrl,
    this.hint,
    this.textAlign = TextAlign.start,
    this.controller,
    this.fontSize = 17.0,
    this.letterSpacing = 2.0,
    this.focusNode,
    this.nextFocus,
    this.textInputAction = TextInputAction.next,
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _obscureText : false,
      cursorColor: ColorResources.getPrimaryTextColor(),
      textAlign: widget.textAlign,
      keyboardType: TextInputType.number,
      textInputAction: widget.textInputAction,
      maxLength: 4,
      onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : null,

      style: TextStyle(
        color: ColorResources.getBlackColor(),
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w500,
        letterSpacing: widget.letterSpacing,
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
        hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          letterSpacing: 1.5,
        ),
        suffixIcon: widget.isShowSuffixIcon
            ? widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: ColorResources.getPrimaryTextColor(),size: 18,),
                    onPressed: _toggle)
                : widget.isIcon
                    ? IconButton(
                        onPressed: widget.onSuffixTap,
                        icon: Image.asset(
                          widget.suffixIconUrl,
                          width: 15,
                          height: 15,
                          color: ColorResources.getPrimaryTextColor(),
                        ),
                      )
                    : null
            : null,
      ),
    );
  }

  void _toggle() {
    print('off');
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
