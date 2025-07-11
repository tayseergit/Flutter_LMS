// lib/Module/Courses/page/courses_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/Module/mainWidget/authText.dart';
import 'package:lms/Module/Contest/TabButtonsForContest.dart';
import 'package:lms/Module/Contest/TabbuttonsforcontestCubit.dart';
import 'package:lms/Module/Contest/gridViewContest.dart';
import 'package:lms/Module/Them/cubit/app_color_cubit.dart';
import 'package:lms/Module/Them/cubit/app_color_state.dart';
import 'package:lms/Module/mainWidget/customTextFieldSearsh.dart';

class ContestPage extends StatelessWidget {
  const ContestPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final search = TextEditingController();

    return BlocProvider(
      create: (_) => TabbuttonsforcontestCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: appColors.pageBackground,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: appColors.pageBackground,
            elevation: 0,
            title: Align(
              alignment: Alignment.center,
              child: AuthText(
                text: 'Contest',
                size: 24,
                color: appColors.mainText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            children: [
              Customtextfieldsearsh(
                onSubmit: () {
                  
                },
                controller: search,
                hintText: 'what do you want to learn ?',
              ),
              SizedBox(height: 15.h),
              const Tabbuttonsforcontest(),
              SizedBox(height: 10.h),
              BlocBuilder<TabbuttonsforcontestCubit, int>(
                builder: (context, state) {
                  switch (state) {
                    case 0:
                      return Gridviewcontest();
                    case 1:
                      return _buildSimpleTab(context, 'Enroll Content');
                    case 2:
                      return _buildSimpleTab(context, 'Completed Content');
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleTab(BuildContext context, String text) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Center(
      child: Text(
        text,
        style: TextStyle(color: appColors.mainText),
      ),
    );
  }
}
