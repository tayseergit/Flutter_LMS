import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Constant/images.dart';
import 'package:lms/Module/StudentsProfile/Model/student_profile_model.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/achievement_gridView.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/certificate_gridVeiw.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Header/main_header.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/Tabs/info_tabs.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/GridView/contest_profile_widget.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/build_profile_content.dart';
import 'package:lms/Module/StudentsProfile/View/Widget/profile_student_status.dart';
import 'package:lms/Module/StudentsProfile/cubit/student_profile_cubit.dart';
import 'package:lms/Module/mainWidget/Container.dart';
import 'package:lms/Module/mainWidget/TabButtons.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/loading.dart';

class StudentProfilePage extends StatelessWidget {
  StudentProfilePage({super.key});
  StudentProfileModel? studentProfileModel;
  @override
  Widget build(BuildContext context) {
    final appColors = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StudentProfileCubit()..getProfile()),
      ],
      child: BlocConsumer<StudentProfileCubit, StudentProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {}
          if (state is ProfileSuccess) {
            studentProfileModel = state.student;
            print(studentProfileModel?.name);
          }
        },
        builder: (context, state) {
          StudentProfileCubit studentProfileCubit = context.watch<StudentProfileCubit>();

          return Container(
            color: appColors.pageBackground,
            child: SafeArea(
                child: Scaffold(
              backgroundColor: appColors.pageBackground,
              body: Builder(
                builder: (context) {
                  if (state is ProfileLoading) {
                    return Center(
                      child: SizedBox(
                        height: 80.h,
                        child: Loading(height: 50.h, width: 50.w),
                      ),
                    );
                  }
                  if (state is ProfileError) {
                    return Center(
                      child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: Image.asset(Images.noConnection),
                      ),
                    );
                  }
                  if (state is ProfileSuccess) {
                    return BuildProfileContent(cubit:  studentProfileCubit);
                  } else {
                    return BuildProfileContent(cubit:  studentProfileCubit);

                  }
                },
              ),
            )),
          );
        },
      ),
    );
  }

  

}
