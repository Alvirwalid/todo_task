import 'package:flutter/material.dart';
import 'package:task_managment/constant/color_path.dart';
import 'package:task_managment/constant/other_constant.dart';
import 'package:task_managment/share_component/custom_style.dart';


class CustomButton{
  static SizedBox kCustomElevatedButton(
      {height, Color color = ColorPath.kAccentColor,fontSize,title,child,onPressed,fontWeight = FontWeight.w400,elevation = 0.0,padding, Color fontColor =  ColorPath.kWhite}) =>
      SizedBox(
          width: Size.infinite.width,
          height: height,
          child: ElevatedButton(
            onPressed: onPressed,

            child:child ?? Text(title,style: CustomStyle.kCustomTextStyle(fontSize:fontSize?? OtherConstant.kLargeTextSize,color:fontColor,fontWeight: fontWeight),),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(color),
                elevation: MaterialStateProperty.all(elevation),
                padding: MaterialStateProperty.all(
                    EdgeInsets.all(padding??OtherConstant.kLargePadding)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(OtherConstant.kRegularRadius)))
            ),
          ));
}