import 'package:bloc/bloc.dart';
import 'package:breaking_bad/shared/bloc_observer.dart';
import 'package:breaking_bad/shared/network/local/cache_helper.dart';
import 'package:breaking_bad/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'layout/app_layout.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());}
class MyApp extends StatelessWidget
{
  MyApp();
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..getCharacters(),
        ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'BreakingBad',
            debugShowCheckedModeBanner: false,
            home: AppLayout(),
          );
        },
      ),
    );
  }
}
