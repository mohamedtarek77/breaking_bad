import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../bussiness_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({Key? key, required this.character})
      : super(key: key);
  Widget buildSliversAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickName,
          style: TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
          tag: character.chartId,
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      // textAlign: TextAlign.left,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndend) {
    return Divider(
      height: 30,
      endIndent: endIndend,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
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
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.myYellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote)
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
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);

    return Scaffold(
        backgroundColor: MyColors.myGrey,
        body: CustomScrollView(
          slivers: [
            buildSliversAppBar(),
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
                        characterInfo('Job : ', character.jobs.join(' / ')),
                        buildDivider(330),
                        characterInfo(
                            'Appeared in : ', character.categoryForTwoSeries),
                        buildDivider(280),
                        character.appearanceOfSeasons.isEmpty
                            ? Container()
                            : characterInfo('Seasons : ',
                                character.appearanceOfSeasons.join(' / ')),
                        character.appearanceOfSeasons.isEmpty
                            ? Container()
                            : buildDivider(320),
                        characterInfo(
                            'Status : ', character.statusIfDeadOrLive),
                        buildDivider(320),
                        character.betterCallSaulAppearance.isEmpty
                            ? Container()
                            : characterInfo('Better Call Sual Seasons : ',
                                character.betterCallSaulAppearance.join(' / ')),
                        character.betterCallSaulAppearance.isEmpty
                            ? Container()
                            : buildDivider(320),
                        characterInfo('Actor/Actress : ', character.atorName),
                        buildDivider(250),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                            return checkIfQuotesAreLoaded(state);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
