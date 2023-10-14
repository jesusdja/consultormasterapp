import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldGeneral extends StatelessWidget {
  final int maxLines;
  final double radius;
  final double sizeHeight;
  final double sizeBorder;
  final String? placeHolder;
  final String? initialValue;
  final String hintText;
  final bool obscure;
  final bool autoCorrect;
  final bool autoValidate;
  final bool enable;
  final bool autofocus;
  final bool activeErrorText;
  final IconData? icon;
  final Color borderColor;
  final TextEditingController? textEditingController;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextStyle labelStyle;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry padding;
  final TextCapitalization textCapitalization;
  final Color colorBack;
  final TextInputAction? textInputAction;
  final BoxConstraints? constraints;
  final List<TextInputFormatter> inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final BoxConstraints? suffixIconConstraints,prefixIconConstraints;
  final bool activeInputBorder;

  const TextFieldGeneral({
    Key? key,
    this.initialValue,
    this.placeHolder,
    this.icon,
    this.borderColor = Colors.grey,
    this.textEditingController,
    this.onChanged,
    this.textInputType = TextInputType.name,
    this.autoCorrect = true,
    this.obscure = false,
    this.autoValidate = false,
    this.maxLines = 1,
    this.focusNode,
    this.onTap,
    this.onFieldSubmitted,
    this.sizeHeight = 0,
    this.textAlign = TextAlign.left,
    this.labelStyle = const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
    this.boxShadow,
    this.sizeBorder = 1.5,
    this.suffixIcon,
    this.prefixIcon,
    this.enable = true,
    this.padding = const EdgeInsets.only(left: 5),
    this.textCapitalization = TextCapitalization.sentences,
    this.hintText = '',
    this.colorBack = Colors.white,
    this.autofocus = false,
    this.textInputAction,
    this.constraints,
    this.radius = 5.0,
    this.inputFormatters = const [],
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    this.activeErrorText = true,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.activeInputBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: colorBack,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
          width: sizeBorder,
          color: borderColor,
        ),
        boxShadow: boxShadow,
      ),
      child: TextFormField(
        controller: textEditingController,
        initialValue: initialValue,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        style: labelStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        obscureText: obscure,
        enabled: enable,
        onChanged: onChanged,
        autocorrect: autoCorrect,
        keyboardType: textInputType,
        focusNode: focusNode,
        textCapitalization: textCapitalization,
        autofocus: autofocus,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: activeInputBorder ? null : InputDecoration(
            filled: true,
            fillColor: colorBack,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              borderSide: const BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),            
            enabledBorder: activeInputBorder ? null : OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              borderSide: const BorderSide(
                width: 0.0,
                color: Colors.transparent,
              ),
            ),
            suffixIcon: suffixIcon,
            labelText: placeHolder,
            labelStyle: labelStyle,
            errorStyle: labelStyle,
            hintText: hintText,
            hintStyle: labelStyle,
            prefixIconConstraints: prefixIconConstraints,
            prefixIcon: prefixIcon,
            suffixIconConstraints: suffixIconConstraints,
            contentPadding: contentPadding
        ),
      ),
    );
  }
}


class TextFieldLine extends StatelessWidget {

  final int maxLines;
  final double radius;
  final double sizeHeight;
  final double sizeBorder;
  final String? placeHolder;
  final String? initialValue;
  final String hintText;
  final bool obscure;
  final bool autoCorrect;
  final bool autoValidate;
  final bool enable;
  final bool autofocus;
  final bool activeErrorText;
  final IconData? icon;
  final Color borderColor;
  final TextEditingController? textEditingController;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final TextStyle labelStyle;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry padding;
  final TextCapitalization textCapitalization;
  final Color colorBack;
  final TextInputAction? textInputAction;
  final BoxConstraints? constraints;
  final List<TextInputFormatter> inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final BoxConstraints? suffixIconConstraints,prefixIconConstraints;
  final bool activeInputBorder;

  const TextFieldLine({
    Key? key,
    this.initialValue,
    this.placeHolder,
    this.icon,
    this.borderColor = Colors.grey,
    this.textEditingController,
    this.onChanged,
    this.textInputType = TextInputType.name,
    this.autoCorrect = true,
    this.obscure = false,
    this.autoValidate = false,
    this.maxLines = 1,
    this.focusNode,
    this.onTap,
    this.onFieldSubmitted,
    this.sizeHeight = 0,
    this.textAlign = TextAlign.left,
    this.labelStyle = const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
    this.boxShadow,
    this.sizeBorder = 1.5,
    this.suffixIcon,
    this.prefixIcon,
    this.enable = true,
    this.padding = const EdgeInsets.only(left: 5),
    this.textCapitalization = TextCapitalization.sentences,
    this.hintText = '',
    this.colorBack = Colors.white,
    this.autofocus = false,
    this.textInputAction,
    this.constraints,
    this.radius = 5.0,
    this.inputFormatters = const [],
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    this.activeErrorText = true,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    this.activeInputBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          contentPadding: contentPadding
      ),
    );
  }
}
