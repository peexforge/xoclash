import 'package:flutter/material.dart';
import 'package:tictatctoe/constants/colors.dart';
import 'package:tictatctoe/constants/functions/navigator.dart';
import 'package:tictatctoe/pages/gameMode.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff12100E),
            Color(0xff2B4162),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: _getHomeBody(context),
        ),
      ),
    );
  }

  Widget _getHomeBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/bg.png', width: 200, height: 200),
        Text(
          "XOClash Game",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 35,
            fontFamily: "Tahoma",
          ),
        ),
        SizedBox(height: 15, width: double.infinity),
        ElevatedButton(
          onPressed: () {
            Nav().gotoPage(GameModePage(), context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(140, 40),
          ),
          child: Text(
            "Start Game",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.purple,
            ),
          ),
        ),
      ],
    );
  }
}
