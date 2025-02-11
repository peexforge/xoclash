import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/boxes.dart';
import 'package:tictatctoe/constants/colors.dart';

import '../data/gameLog.dart';

class LeaderboardPage extends StatefulWidget {
  LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getBar(),
      body: SafeArea(child: _getLeaderBody()),
    );
  }

  Widget _getLeaderBody() {
    return Column(
      children: [
        for (Gamelog game in games.values)
          _gameResult(
            gameType: game.gameType,
            result: game.result,
            date: game.date,
          )
      ],
    );
  }

  Widget _gameResult(
      {required int gameType, required String result, required String date}) {
    TextStyle _headerStyle = TextStyle(
      fontFamily: 'Tahoma',
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    List<String> gameTypes = ["Player vs Player", "Ai vs Player"];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.boxGrey,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.gamepad_outlined, color: AppColors.blue),
              SizedBox(width: 5),
              Text("GameType:", style: _headerStyle),
              Spacer(),
              // 0 [Player vs Player] and 1 [Ai vs Player]

              Text(gameTypes[gameType]),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.star_purple500_sharp, color: AppColors.grey),
              SizedBox(width: 5),
              Text("Result:", style: _headerStyle),
              Spacer(),
              Text(result),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.date_range_rounded, color: AppColors.blue),
              SizedBox(width: 5),
              Text("Date:", style: _headerStyle),
              Spacer(),
              Text(date),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _getBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "History",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            games.clear();
            setState(() {});
          },
          icon: Icon(
            Icons.delete,
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}
