import 'dart:async';
import 'package:breaking_bad/models/character%20_model.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class AppLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(child: Text('Moza')), /*GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: AppCubit.get(context).characterModel.name.length,
            itemBuilder: (context, index) {

            },
          ),*/
          floatingActionButton: FloatingActionButton(
            onPressed: (){

            },
          ),
        );
      },
    );
  }
}
 buildCharacterItem(CharacterModel character)=>Container(
  width: double.infinity,
  margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
  padding: EdgeInsetsDirectional.all(4),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
  ),
  child: InkWell(
    onTap: () {},
    child: GridTile(
      child: Hero(
        tag: character.charId,
        child: Container(
          color: Colors.grey,
          child: character.image.isNotEmpty
              ? FadeInImage.assetNetwork(
            width: double.infinity,
            height: double.infinity,
            placeholder: 'assets/images/loading.gif',
            image: character.image,
            fit: BoxFit.cover,
          )
              : Image.asset('assets/images/placeholder.jpg'),
        ),
      ),
      footer: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: Colors.black54,
        alignment: Alignment.bottomCenter,
        child: Text(
          '${character.name}',
          style: TextStyle(
            height: 1.3,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),
);

Widget showLoadingIndicator() {
  return Center(
    child: CircularProgressIndicator(
      color: Colors.yellow,
    ),
  );
}