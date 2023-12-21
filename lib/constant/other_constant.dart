import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtherConstant{
  //Padding
  static  double kLargePadding = 16.0.sp;
  static double kRegularPadding = 8.0.sp;
  static double kSmallPadding = 4.0.sp;

  //Radius
  static double kLargeRadius = 16.0.sp;
  static double kRegularRadius = 10.0.sp;
  static double kSmallRadius = 5.0.sp;

  //Text Size
  static double kVerySmallTextSize = 10.0.sp;
  static double kSmallTextSize = 12.0.sp;
  static double kMediumTextSize = 14.0.sp;
  static double kRegularTextSize = 16.0.sp;
  static double kLargeTextSize = 20.0.sp;
  static double kHeadlineTextSize = 28.0.sp;
  static  double kSmallIconSize = 20.0.sp;
  static Size kCustomSize(context) => MediaQuery.of(context).size;
  static double kCustomWidth(context) => MediaQuery.of(context).size.width;
  static double kCustomHeight(context) => MediaQuery.of(context).size.height;


}