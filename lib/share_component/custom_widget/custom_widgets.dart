import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_managment/constant/color_path.dart';
import 'package:task_managment/constant/other_constant.dart';
import 'package:task_managment/share_component/custom_style.dart';


class CustomWidgets{

  static kCustomTextField({controller,hintText,String? Function(String?)? validator}){

    return Container(
      height: 50.sp,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
      color: Colors.white,
      boxShadow:  [
        BoxShadow(
          color: Colors.grey,
          offset: const Offset(0.0, 0.0),
          blurRadius: OtherConstant.kRegularRadius,
          spreadRadius: 0.0,
        ),
      ],
      borderRadius:
      BorderRadius.circular(OtherConstant.kRegularRadius),
    ),

      child: TextFormField(


        controller:controller,
        validator:validator,
        decoration: InputDecoration(

          helperText: "",
            contentPadding: EdgeInsets.only(top: OtherConstant.kRegularRadius,left:OtherConstant.kRegularRadius),

            hintText:hintText,
            border: InputBorder.none),

      ),
    );
  }
  static Container notAvailableContainer({
    // bool isCB = false,
    required context,
    String? asset,
    IconData? icon,
    required String title,
    String? subTitle,
    double? height,
    EdgeInsetsGeometry? padding ,
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? radius
  }) {
    return Container(
      height: height,
      width: OtherConstant.kCustomSize(context).width,
      decoration: CustomStyle.kCustomBoxDecoration(radius: radius ??BorderRadius.circular(0.0) ),
      padding:padding?? EdgeInsets.zero,
      margin:margin?? EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // padding: EdgeInsets.all(OtherConstant.kRegularPadding ),
            height: OtherConstant.kSmallIconSize * 3,
            width: OtherConstant.kSmallIconSize * 3,
            decoration:
            BoxDecoration(color: ColorPath.kLightPrimary.withOpacity(.8), shape: BoxShape.circle),
            child: Center(
              child:asset != null? Image.asset(asset): Icon(icon,size: OtherConstant.kSmallIconSize * 2,color: ColorPath.kPrimaryColor,) ,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: OtherConstant.kRegularPadding, bottom: OtherConstant.kLargePadding),
            child: Text(
              title,
              style: CustomStyle.kCustomTextStyle(color: ColorPath.kPrimaryColor,fontWeight: FontWeight.w500,),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            subTitle??'',
            textAlign: TextAlign.center,
            style: CustomStyle.kCustomTextStyle(color: ColorPath.k1),
          ),
        ],
      ),
    );
  }
}