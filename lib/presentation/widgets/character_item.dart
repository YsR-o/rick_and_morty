import 'package:rick_and_morty/data/model/character_model.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, characterDetailsScreen,arguments: character);
      },
      child: GridTile(
        footer: Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          alignment: AlignmentDirectional.bottomCenter,
          child: Text(
            character.name,
            style: const TextStyle(
              color: Colors.white,
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: Hero(
          tag: character.id,
          child: Container(
            color: Colors.green,
            child: character.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    width: double.infinity,
                    image: character.image,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.broken_image,
                  ),
          ),
        ),
      ),
    );
  }
}
