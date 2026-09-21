import 'package:flutter/material.dart';
import 'package:persistencia_local/components/header.dart';
import 'package:persistencia_local/components/partida_component.dart';
import 'package:persistencia_local/models/partida.dart';
import 'package:persistencia_local/models/time.dart';
import 'package:persistencia_local/repositories/partida_repository.dart';
import 'package:persistencia_local/services/preferences_services.dart';

class PartidasScreen extends StatefulWidget {
  const PartidasScreen({super.key, required this.changeScreen, required this.currentScreen});

  final ValueChanged<int> changeScreen;
  final int currentScreen;

  @override
  State<PartidasScreen> createState() => _PartidasScreenState();
}

class _PartidasScreenState extends State<PartidasScreen> {
  final preferences = PreferencesService();
  final repository = PartidaRepository();

  late final Time favoriteTeam;
  late final List<int> rodadas;
  late final List<Partida> partidas;

  int? rodada;

  Future<void> isScreenLoaded() async {
    favoriteTeam = (await (preferences.getFavoriteTeam()))!;
    rodadas = await repository.getAllDistinctRodadas();
    partidas = await repository.getAllPartidas();

    if (rodadas.isEmpty) {
      return;
    }

    rodada = rodadas.first;
  }

  List<Partida> filterByRodada(int rodada) {
    return partidas
        .where((partida) => partida.rodada == rodada)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: 
      Padding(
        padding: EdgeInsetsGeometry.all(5),
        child: FutureBuilder(
          future: isScreenLoaded(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(
              spacing: 20,
              children: [
                Header(favoriteTeam: favoriteTeam, currentScreen: widget.currentScreen, changeScreen: widget.changeScreen,),
                if (rodada != null) 
                  Center(child: Column(
                    spacing: 20,
                    children: [
                      Text("RODADA", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          IconButton(onPressed: () => rodada != rodadas.first 
                          ? setState(() => rodada = rodadas[rodadas.indexOf(rodada!) - 1])
                          : null, 
                          icon: Icon(Icons.arrow_back),),
                          Text("$rodada", style: Theme.of(context).textTheme.bodyLarge,),
                          IconButton(onPressed: () => rodada != rodadas.last 
                          ? setState(() => rodada = rodadas[rodadas.indexOf(rodada!) + 1])
                          : null, 
                          icon: Icon(Icons.arrow_forward))
                        ],
                      ),
                      ...filterByRodada(rodada!).map((partida) => Column(
                        spacing: 20,
                        children: [
                          Divider(height: 2,),
                          PartidaComponent(partida: partida)
                        ],
                      ))
                    ],
                  ),)
              ],
            );
          }
        ),
      )
    ),);
  }
}