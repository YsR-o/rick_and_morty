import 'package:rick_and_morty/business_logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/constants/my_colors.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/model/character_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/character_item.dart';
import '../widgets/loading_widget.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  List<Character> searchedCharacters=[];
  final searchingController = TextEditingController();
  bool isSearching = false;
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    if (currentScroll == maxScroll && serchingnextUrl != null) {
      BlocProvider.of<CharactersCubit>(context).searchedCharacters(searchingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBarIsSearching(),
      body: buildBlocWidget(),
    );
  }

  AppBar _appBarIsSearching() {
    return AppBar(
      leading: const BackButton(
        color: MyColors.myGrey,
      ),
      backgroundColor: MyColors.myYellow,
      title: TextFormField(
        controller: searchingController,
        decoration: const InputDecoration(
          hintText: 'Find a character....',
          hintStyle: TextStyle(
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            BlocProvider.of<CharactersCubit>(context).searchedCharacters(value);
          });
        },
      ),
      elevation: 0.0,
      actions: [
        IconButton(
          onPressed: () {
            isSearching = false;
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ],
    );
  }


  Widget buildBlocWidget() {
    return BlocConsumer<CharactersCubit, CharactersState>(
      listener: (context, state) {
        if (state is ShearchedCharactersLoadedState) {
          searchedCharacters =  state.searched;
        }
      },
      builder: (context, state) {
        if (searchedCharacters.isNotEmpty) {
          return buildLodadedList();
        } else {
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
      itemCount: searchedCharacters.length,
      itemBuilder: (context, index) =>
          CharacterItem(character: searchedCharacters[index]),
    );
  }
}
