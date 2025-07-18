import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart'; 
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
 import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class MainHeader extends StatelessWidget {
  MainHeader( {Key? key,required this.cubit}) : super(key: key);
  StudentProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;

    return Stack(
      children: [
        Image.asset(
          Images.courses,
          width: double.infinity,
          height: 300.h,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h, right: 15.w),
          child: Align(
            alignment: Alignment.topRight,
            child: OnBoardingContainer(
              width: 90.w,
              height: 25.h,
              color: appColors.darkText,
              widget: AuthText(
                text: 'Edit Profile',
                size: 14.sp,
                color: appColors.mainText,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OnBoardingContainer(
                width: 220.w,
                height: 68.h,
                color: appColors.primary,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthText(
                      text: cubit.studentProfileModel.name,
                      size: 18.sp,
                      color: appColors.mainText,
                      fontWeight: FontWeight.w700,
                    ),
                    AuthText(
                      text: cubit.studentProfileModel.email,
                      size: 10.sp,
                      color: appColors.pageBackground,
                      fontWeight: FontWeight.w700,
                    ),
                    AuthText(
                      text: cubit.studentProfileModel.joined,
                      size: 10.sp,
                      color: appColors.pageBackground,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5.sp),
              Column(
                children: [
                  OnBoardingContainer(
                    width: 110.w,
                    height: 30.h,
                    color: appColors.orang,
                    widget: Center(
                      child: AuthText(
                        text: cubit.studentProfileModel.level,
                        size: 12.sp,
                        color: appColors.mainText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  OnBoardingContainer(
                    width: 110.w,
                    height: 30.h,
                    color: appColors.darkText,
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.github,
                          height: 20.h,
                          width: 20.w,
                          color: appColors.mainText,
                        ),
                        SizedBox(width: 15.w),
                        AuthText(
                          text: 'GitHub',
                          size: 12.sp,
                          color: appColors.mainText,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
