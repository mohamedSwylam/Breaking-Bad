import 'package:bloc/bloc.dart';
import 'package:breaking_bad/layout/cubit/states.dart';
import 'package:breaking_bad/shared/network/remote/dio_helper.dart';
import 'package:breaking_bad/shared/network/remote/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  void getHomeData() {
    emit(GetCharactersLoadingState());
    DioHelper.getData(
      url: GET_CHARACTERS,
    ).then((value) {

      emit(GetCharactersSuccessState());
    }).catchError((error) {
      emit(GetCharactersErrorState(error.toString()));
    });
  }
}

