import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lms/Constant/urls.dart';
import 'package:lms/Helper/cach_helper.dart';
import 'package:lms/Helper/dio_helper.dart';
import 'package:lms/Module/LearnPathInfo/Cubit/learn_path_info_state.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_courses_model.dart';
import 'package:lms/Module/LearnPathInfo/Model/learn_path_info_model.dart';
import 'package:lms/generated/l10n.dart';

class LearnPathInfoCubit extends Cubit<LearnPathInfoState> {
  LearnPathInfoCubit() : super(LearnPathInfoInitial());
  LearningPathInfoModel? learningPathInfoModel;
  Future<void> fetchAllLearnPathData(int id) async {
    emit(LearnPathInfoLoading());

    try {
      final token = CacheHelper.getData(key: 'token') ?? '';
      final userId = CacheHelper.getData(key: 'user_id');

      print("🔄 Fetching learn path info from: ${Urls.learnPathInfo(id)}");
      final infoResponse = await DioHelper.getData(
        url: Urls.learnPathInfo(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (infoResponse.statusCode != 200) {
        emit(LearnPathInfoError(masseg: 'Failed to fetch path info'));
        print(infoResponse.data["message"]);

        return;
      }

      learningPathInfoModel = LearningPathInfoModel.fromJson(infoResponse.data);
      print("✅ Info fetched");

      print(
          "🔄 Fetching learn path courses from: ${Urls.learnPathInfocourse(id)}");
      final coursesResponse = await DioHelper.getData(
        url: Urls.learnPathInfocourse(id),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print(coursesResponse.statusCode);
      if (coursesResponse.statusCode != 200) {
        print(coursesResponse.data["message"]);

        emit(LearnPathInfoError(masseg: 'Failed to fetch path courses'));
        print(coursesResponse.data["message"]);
        return;
      }

      final courses =
          LearnPathInfoCourseResponse.fromJson(coursesResponse.data);
      print("✅ Courses fetched");
      emit(LearnPathAllDataSuccess(
          info: learningPathInfoModel!, courses: courses));
    } catch (e) {
      print("❌ Error while fetching data: $e");
      emit(LearnPathInfoError(masseg: 'Exception occurred: $e'));
      print(e);
    }
  }

////////
  ///
  Future<void> updatePathStatus(
      BuildContext context, int id, String status) async {
    if (status == "enroll")
      emit(UpdateEnrollStatusLoading());
    else
      emit(UpdateLaterStatusLoading());

    try {
      if (CacheHelper.getToken() == null) {
        emit(UnAuthUser(masseg: S.of(context).Login_or_SignUp));
        return;
      }
      print(id);
      final infoResponse = await DioHelper.putData(
        url: Urls.learnPathInfo(id),
        putData: {"status": status},
        headers: {
          'Authorization': 'Bearer ${CacheHelper.getToken()}',
          'Accept': 'application/json',
        },
      ).then((value) {
        print(value.data['message']);
        if (value.statusCode == 200) {
      fetchAllLearnPathData(id);

            emit(UpdateStatusSuccess());
        } else if (value.statusCode == 401) {
          emit(UnAuthUser(masseg: S.of(context).Login_or_SignUp));
        } else {
          emit(UpdateStatusError(massage: S.of(context).error_occurred));
        }
      }).catchError((onError) {
        emit(UpdateStatusError(massage: S.of(context).error_occurred));
      });
    } catch (e) {
      print("❌ Error while fetching data: $e");
      emit(UpdateStatusError(massage: S.of(context).error_in_server));
    }
  }

  //// delete status
  Future<void> deletePathStatus(BuildContext context, int id) async {
    emit(DeleteStatusLoading());

    try {
      if (CacheHelper.getToken() == null) {
        emit(UnAuthUser(masseg: S.of(context).Login_or_SignUp));
        return;
      }

      final infoResponse = await DioHelper.deleteData(
        url: Urls.learnPathInfo(id),
        headers: {
          'Authorization': 'Bearer ${CacheHelper.getToken()}',
          'Accept': 'application/json',
        },
      ).then((value) {
        if (value.statusCode == 200) {
      fetchAllLearnPathData(id);
 
          emit(DeleteStatusSuccess());
        } else if (value.statusCode == 401) {
          emit(UnAuthUser(masseg: S.of(context).Login_or_SignUp));
        } else {
          emit(DeleteStatusError(message: S.of(context).error_occurred));
        }
      }).catchError((onError) {
        emit(DeleteStatusError(message: S.of(context).error_occurred));
      });
    } catch (e) {
      print("❌ Error while fetching data: $e");
      emit(DeleteStatusError(message: S.of(context).error_in_server));
    }
  }
}
