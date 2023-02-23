
  import 'package:rick_and_morty/constants/my_colors.dart';
import 'package:flutter/material.dart';

Center myLoading() {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(color: MyColors.myYellow,)),
    );
  }