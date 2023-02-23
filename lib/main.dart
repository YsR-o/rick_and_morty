import 'package:rick_and_morty/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RickAndMortyApp(
    appRouter: AppRouter()
  ));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRouter appRouter;

  const RickAndMortyApp({super.key, required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRouet,
    );
  }
}
