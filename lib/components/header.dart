// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:persistencia_local/models/time.dart';

class Header extends StatelessWidget {
  Header({super.key, required this.favoriteTeam, required this.changeScreen, required this.currentScreen});

  final ValueChanged<int> changeScreen;
  int currentScreen;

  final Time favoriteTeam;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text("Brasileirão", style: Theme.of(context).textTheme.headlineMedium),
          Row(
            spacing: 10,
            children: [
              SizedBox(height: 20, child: Image.asset(favoriteTeam.escudoUrl)),
              Text("Meu time: ${favoriteTeam.nome}")
            ],
          )
        ],
      ),
      IconButton(onPressed: () => changeScreen(currentScreen == 1 ? 0 : 1), icon: Icon(Icons.swap_horiz_outlined))
    ],
  );
}