import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/boxes.dart';

import '../constants/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool gameSound = myBox.get('gameSound') ?? true;
  List<String> difficulties = ["Easy", "Medium", "Hard"];
  int selectedIndex = myBox.get('aiDifficulty') ?? 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getBar(),
      body: SafeArea(child: _getSettingBody()),
    );
  }

  Widget _getSettingBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _mainSettings(),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.boxGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Difficulty",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                ),
                SizedBox(height: 10),
                for (int i = 0; i < 3; i++) _diffButton(i),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _diffButton(int index) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            selectedIndex = index;
            myBox.put('aiDifficulty', index);
          });
        },
        child: Text(
          difficulties[index],
          style: TextStyle(
            fontFamily: 'Tahoma',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.white : AppColors.lightGrey,
          ),
        ),
        style: selectedIndex == index
            ? ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 40),
              )
            : ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[400]!, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 40),
              ));
  }

  Container _mainSettings() {
    return Container(
      height: 100,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.boxGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sound",
            style: TextStyle(
              fontFamily: 'Tahoma',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Game Sound",
                style: TextStyle(
                  fontFamily: 'Tahoma',
                  fontSize: 16,
                  color: AppColors.lightGrey,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 45,
                height: 30,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    value: gameSound,
                    onChanged: (value) {
                      setState(() {
                        gameSound = !gameSound;
                        myBox.put('gameSound', gameSound);
                      });
                    },
                    activeColor: AppColors.purple,
                    thumbColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar _getBar() {
    return AppBar(
      title: Text(
        "Settings",
        style: TextStyle(
          fontFamily: 'Tahoma',
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: AppColors.grey,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
