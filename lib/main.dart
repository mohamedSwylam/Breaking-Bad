import 'package:bloc/bloc.dart';
import 'package:breaking_bad/shared/bloc_observer.dart';
import 'package:breaking_bad/shared/network/remote/web_services.dart';
import 'package:breaking_bad/shared/network/remote/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/app_layout.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());}
class MyApp extends StatelessWidget
{
  MyApp(){
    charactersRepository=Repository(WebServices());
  }
  Repository charactersRepository;
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit(charactersRepository)..getAllCharacters(),
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
