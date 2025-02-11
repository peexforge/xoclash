import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tictatctoe/constants/boxes.dart';
import 'package:tictatctoe/data/gameLog.dart';
import 'package:tictatctoe/pages/home.dart';

void main(List<String> args) async {
  runApp(Application());
  await Hive.initFlutter();
  Hive.registerAdapter(GamelogAdapter());
  myBox = await Hive.openBox("settings"); // Box for game settings.
  games = await Hive.openBox("games"); // Box for games log and history.
}

class Application extends StatelessWidget {
  Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _firstPage(),
    );
  }

  Widget _firstPage() => HomePage();
}
