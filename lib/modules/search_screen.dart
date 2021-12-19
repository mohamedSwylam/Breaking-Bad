import 'package:breaking_bad/layout/cubit/cubit.dart';
import 'package:breaking_bad/models/character%20_model.dart';
import 'package:breaking_bad/shared/network/remote/repository.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchTextController;
  final FocusNode _node = FocusNode();

  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController.dispose();
  }

  List<CharacterModel> _searchList = [];

  List<CharacterModel> searchQuery(String searchText) {
    List _searchList = AppCubit.get(context)
        .characters
        .where((element) =>
            element.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return _searchList;
  }
 Repository characterRepository;
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:Text('Search'),
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Container(
                height: 50,
                child: TextFormField(
                  textAlign: TextAlign.start,
                  cursorColor: Colors.yellow[700],
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  cursorHeight: 25,
                  onChanged: (String enteredKeyword) {
                    List<CharacterModel> result = [];
                    if (enteredKeyword.isEmpty) {
                      // if the search field is empty or only contains white-space, we'll display all products
                      result = AppCubit.get(context).characters;
                    } else {
                      result = AppCubit.get(context)
                              .characters
                              .where((element) => element.name
                                  .toLowerCase()
                                  .startsWith(enteredKeyword.toLowerCase()))
                              .toList();
                      // we use the toLowerCase() method to make it case-insensitive
                    }
                    // Refresh the UI
                    setState(() {
                      _searchList = result;
                      print(_searchList.length);
                    });
                  },
                  style: TextStyle(
                    color: Colors.yellow[700],
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8.0),
                    hintText: 'Find actor..',
                    hintStyle: TextStyle(
                        color: Colors.yellow[700],
                        fontSize:15,
                    ),
                    fillColor: Colors.white,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Feather.search,
                          color: Colors.yellow[700],
                          size: 20,
                        ),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: _searchTextController.text.isEmpty
                          ? null
                          : () {
                              _searchTextController.clear();
                              _node.unfocus();
                            },
                      child: Icon(Feather.x,
                          size:20,
                          color: _searchTextController.text.isNotEmpty
                              ? Colors.red
                              : Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
              ),
            ),
            Container(
              child: _searchTextController.text.isNotEmpty &&
                      _searchList.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Icon(
                          Feather.search,
                          size: 35,
                            color: Colors.yellow[700],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'No result found',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700,color: Colors.yellow[700]),
                        ),
                      ],
                    )
                  :  GridView.count(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 240 / 420,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(
                    _searchList.length, (index) {
                  return buildCharacterItem(_searchList[index]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildCharacterItem(CharacterModel character) =>
      Container(
        width: double.infinity,
        margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        padding: EdgeInsetsDirectional.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Hero(
                tag: character.charId,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: character.image.isNotEmpty
                      ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Image.asset('assets/images/placeholder.jpg'),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            ],
          ),
        ),
      );
}
