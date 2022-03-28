import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// form field with label class
// ignore: must_be_immutable
class GlobalFormField extends StatefulWidget {
  final int textLimit, maxLines;
  final bool allow, secureText, isReadOnly;
  final String hint, label, regExp;
  final TextEditingController controller;
  final Function validator, onChange;
  Function onTap = () {};
  final Widget suffixIcon, prefixIcon;
  final FocusNode focusNode, nextNode, unFocus;
  final TextInputType type;
  final TextInputAction action;
  final TextCapitalization capitalization;

  GlobalFormField(
      {this.hint,
      this.label,
      this.prefixIcon,
      this.controller,
      this.focusNode,
      this.nextNode,
      this.unFocus,
      this.type,
      this.action,
      this.capitalization,
      this.validator,
      this.onChange,
      this.onTap,
      this.textLimit,
      this.maxLines,
      this.regExp,
      this.allow = false,
      this.secureText = false,
      this.isReadOnly = false,
      this.suffixIcon});

  @override
  _GlobalFormFieldState createState() => _GlobalFormFieldState();
}

class _GlobalFormFieldState extends State<GlobalFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, widget.label) ?? "",
          style: MyTextStyle.mulish().copyWith(
              color: themeColor,
              fontSize: Get.width * .04,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.textLimit),
            FilteringTextInputFormatter(RegExp(widget.regExp ?? ""),
                allow: widget.allow ?? false)
          ],
          textAlign: TextAlign.start,
          controller: widget.controller,
          focusNode: widget.focusNode,
          onFieldSubmitted: (val) {
            setState(() {
              FocusScope.of(Get.context).requestFocus(widget.nextNode);
            });
          },
          onTap: widget.onTap,
          readOnly: widget.isReadOnly,
          textInputAction: widget.action,
          obscureText: widget.secureText ?? false,
          style: MyTextStyle.mulish().copyWith(fontSize: 12),
          decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              isDense: true,
              hintText: getTranslated(context, widget.hint),
              prefixIcon:
                  Container(height: 15, width: 15, child: widget.prefixIcon),
              fillColor: white,
              filled: true,
              hintStyle:
                  MyTextStyle.mulish().copyWith(fontSize: 11, color: lightGrey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: fieldBorder, width: 1.2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: fieldBorder, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: themeColor, width: 1.2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: red, width: 1.2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: red, width: 1.2),
              ),
              errorStyle:
                  MyTextStyle.mulish().copyWith(color: red, fontSize: 10)),
          textCapitalization: widget.capitalization ?? TextCapitalization.none,
          onChanged: widget.onChange,
          maxLines: widget.maxLines ?? 1,
          // onEditingComplete: () {
          //   setState(() {
          //     widget.focusNode.unfocus();
          //   });
          // },
          keyboardType: widget.type,
          validator: widget.validator,
        )
      ],
    );
  }
}

// form field without label class
// ignore: must_be_immutable
class GlobalFormFieldWithoutLabel extends StatefulWidget {
  final int textLimit, maxLines;
  final bool allow, secureText, isReadOnly;
  final String hint, regExp;
  final TextEditingController controller;
  final Function validator, onChange;
  Function onTap = () {};
  final TextAlign textAlign;
  final Widget suffixIcon, prefixIcon;
  final FocusNode focusNode, nextNode, unFocus;
  final TextInputType type;
  final TextInputAction action;
  final TextCapitalization capitalization;

  GlobalFormFieldWithoutLabel(
      {this.hint,
      this.prefixIcon,
      this.controller,
      this.focusNode,
      this.nextNode,
      this.unFocus,
      this.type,
      this.action,
      this.capitalization,
      this.validator,
      this.onChange,
      this.onTap,
      this.textAlign,
      this.textLimit,
      this.maxLines,
      this.regExp,
      this.allow = false,
      this.secureText = false,
      this.isReadOnly = false,
      this.suffixIcon});

  @override
  _GlobalFormFieldWithoutLabelState createState() =>
      _GlobalFormFieldWithoutLabelState();
}

class _GlobalFormFieldWithoutLabelState
    extends State<GlobalFormFieldWithoutLabel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.textLimit),
            FilteringTextInputFormatter(RegExp(widget.regExp ?? ""),
                allow: widget.allow ?? false)
          ],
          textAlign: widget.textAlign ?? TextAlign.start,
          controller: widget.controller,
          focusNode: widget.focusNode,
          onFieldSubmitted: (val) {
            setState(() {
              FocusScope.of(Get.context).requestFocus(widget.nextNode);
            });
          },
          onTap: widget.onTap,
          readOnly: widget.isReadOnly,
          textInputAction: widget.action,
          obscureText: widget.secureText ?? false,
          style: MyTextStyle.mulish().copyWith(fontSize: 12),
          decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              isDense: true,
              hintText: getTranslated(context, widget.hint),
              prefixIcon: widget.prefixIcon,
              fillColor: white,
              contentPadding:
                  EdgeInsets.only(left: 15, right: 0, bottom: 20, top: 10),
              filled: true,
              hintStyle:
                  MyTextStyle.mulish().copyWith(fontSize: 11, color: lightGrey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: fieldBorder, width: 1.2),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: fieldBorder, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: themeColor, width: 1.2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: red, width: 1.2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: red, width: 1.2),
              ),
              errorStyle:
                  MyTextStyle.mulish().copyWith(color: red, fontSize: 10)),
          textCapitalization: widget.capitalization ?? TextCapitalization.none,
          onChanged: widget.onChange,
          maxLines: widget.maxLines ?? 1,
          onEditingComplete: () {
            setState(() {
              widget.focusNode.unfocus();
            });
          },
          keyboardType: widget.type,
          validator: widget.validator,
        )
      ],
    );
  }
}
