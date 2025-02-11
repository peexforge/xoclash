import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/functions/navigator.dart';
import 'package:tictatctoe/pages/game.dart';
import 'package:tictatctoe/pages/leaderBoard.dart';
import 'package:tictatctoe/pages/settings.dart';

class GameModePage extends StatelessWidget {
  GameModePage({super.key});
  // 0 [Player vs Player] and 1 [Ai vs Player]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getBar(context),
      backgroundColor: Colors.white,
      body: SafeArea(child: _getGameModeBody(context)),
    );
  }

  Widget _getGameModeBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Choose Game Mode",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(height: 15, width: double.infinity),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 45),
              backgroundColor: AppColors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Nav().gotoPage(GamePage(gameType: 1, isAiMode: true), context);
            },
            child: Text(
              "Play vs AI",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 45),
              backgroundColor: AppColors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Nav().gotoPage(
                GamePage(gameType: 0, isAiMode: false),
                context,
              );
            },
            child: Text(
              "Play vs Friend",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(double.infinity, 45),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[400]!, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Nav().gotoPage(LeaderboardPage(), context);
            },
            child: Text(
              "Leaderboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _getBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Game Type",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Nav().gotoPage(SettingsPage(), context);
          },
          icon: Icon(
            Icons.settings,
            color: AppColors.grey,
          ),
        )
      ],
    );
  }
}
