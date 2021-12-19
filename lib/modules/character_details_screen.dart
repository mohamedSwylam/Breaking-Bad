import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/layout/cubit/cubit.dart';
import 'package:breaking_bad/layout/cubit/states.dart';
import 'package:breaking_bad/shared/network/remote/repository.dart';
import 'package:breaking_bad/shared/network/remote/web_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final int characterId;

  CharacterDetailsScreen({this.characterId});


  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: Colors.yellow[700],
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(AppStates state) {
    if (state is GetQuotesSuccessState) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: Colors.yellow[700],
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.yellow[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var charAttr = AppCubit.get(context).findByCharId(characterId);
    return BlocProvider(
      create: (BuildContext context) => AppCubit(Repository(WebServices()))..getQuotes(charAttr.name),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  stretch: true,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      charAttr.nickName,
                      style: TextStyle(color: Colors.white),
                    ),
                    background: Hero(
                      tag: charAttr.charId,
                      child: Image.network(
                        charAttr.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            characterInfo('Job : ', charAttr.jobs.join(' / ')),
                            buildDivider(315),
                            characterInfo(
                                'Appeared in : ', charAttr.categoryForTwoSeries),
                            buildDivider(250),
                            characterInfo('Seasons : ',
                                charAttr.appearanceOfSeasons.join(' / ')),
                            buildDivider(280),
                            characterInfo(
                                'Status : ', charAttr.statusIfDeadOrAlive),
                            buildDivider(300),
                            charAttr.betterCallSaulAppearance.isEmpty
                                ? Container()
                                : characterInfo('Better Call Saul Seasons : ',
                                charAttr.betterCallSaulAppearance.join(" / ")),
                            charAttr.betterCallSaulAppearance.isEmpty
                                ? Container()
                                : buildDivider(150),
                            characterInfo(
                                'Actor/Actress : ', charAttr.actorName),
                            buildDivider(235),
                            SizedBox(
                              height: 20,
                            ),
                            BlocBuilder<AppCubit, AppStates>(
                              builder: (context, state) {
                                return checkIfQuotesAreLoaded(state);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 500,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}