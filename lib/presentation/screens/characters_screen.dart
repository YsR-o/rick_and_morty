import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/constants/my_colors.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/model/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/character_item.dart';
import '../widgets/loading_widget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? allCharacters = [];
  late List<Character> searchedCharacters;
  final searchingController = TextEditingController();
  bool isSearching = false;
  final scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    if (currentScroll == maxScroll && allCharacternextUrl != null) {
      BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: buildBlocWidget(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: MyColors.myYellow,
      title: const Text(
        'Characters',
        style: TextStyle(
          color: MyColors.myGrey,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // _startSearch();  
          Navigator.pushNamed(context, searchingScreen);
          },
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ],
      elevation: 0.0,
    );
  }


  BlocBuilder<CharactersCubit, CharactersState> buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoadedState)  {
          allCharacters = (allCharacters! + state.character);
          return buildLodadedList();
        } else if(allCharacters!.isNotEmpty){
          return buildLodadedList();
        }
         {
          return myLoading();
        }
      },
    );
  }

  Widget buildLodadedList() {
    return GridView.builder(
      controller: scrollController,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: searchingController.text.isEmpty
          ? allCharacters!.length + 1
          : searchedCharacters.length,
      itemBuilder: (context, index) => index >= allCharacters!.length
          ? myLoading()
          : CharacterItem(
              character: searchingController.text.isEmpty
                  ? allCharacters![index]
                  : searchedCharacters[index]),
    );
  }
}
