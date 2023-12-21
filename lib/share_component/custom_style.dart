import 'package:flutter/material.dart';
import 'package:task_managment/constant/color_path.dart';
import 'package:task_managment/constant/other_constant.dart';


class CustomStyle{
  static TextStyle kCustomTextStyle(
      {double? fontSize,
        FontWeight? fontWeight = FontWeight.normal,
        Color? color = ColorPath.kColorBlack,
        double? height,
        Color? backgroundColor = ColorPath.kSplashGradientTop}) =>
      TextStyle(
          fontSize: fontSize??OtherConstant.kRegularTextSize,
          fontWeight: fontWeight,
          color: color,
          height: height ?? 1.2,
          backgroundColor: backgroundColor);
  static BoxDecoration kCustomBoxDecoration(
      {Color color = ColorPath.kWhite,
        List<BoxShadow>? shadow,
        BorderRadiusGeometry? radius,

        BoxBorder? border,
        DecorationImage? image,BoxShape shape = BoxShape.rectangle}) =>
      BoxDecoration(
          color: color,
          borderRadius: radius ?? BorderRadius.circular(OtherConstant.kRegularRadius),
          boxShadow: shadow,
          border: border,
          shape: shape,
          image: image);
}