import 'package:flutter/material.dart';
import 'package:persistencia_local/components/header.dart';
import 'package:persistencia_local/models/partida.dart';
import 'package:persistencia_local/models/time.dart';
import 'package:persistencia_local/repositories/partida_repository.dart';
import 'package:persistencia_local/repositories/time_repository.dart';
import 'package:persistencia_local/services/preferences_services.dart';

class CadastroPartidaScreen extends StatefulWidget {
  const CadastroPartidaScreen({super.key, required this.changeScreen, required this.currentScreen});

  final ValueChanged<int>  changeScreen;
  final int currentScreen;

  @override
  State<CadastroPartidaScreen> createState() => _CadastroPartidaScreenState();
}

class _CadastroPartidaScreenState extends State<CadastroPartidaScreen> {

  final preferences = PreferencesService();
  final repository = PartidaRepository();
  
  final times = getTimes();

  late final Time favoriteTeam;

  final TextEditingController rodadaController = TextEditingController();
  final TextEditingController dataControler = TextEditingController();
  late Time timeCasa;
  late Time timeVisitante;
  final TextEditingController golsCasaController = TextEditingController();
  final TextEditingController golsVisitaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> isScreenLoaded() async {
    favoriteTeam = (await (preferences.getFavoriteTeam()))!;
  }

  void cadastrarPartida() {
    final _partidaCadastrada = Partida(
      rodada: int.parse(rodadaController.text), 
      data: dataControler.text, 
      timeCasa: timeCasa, 
      timeVisitante: timeVisitante, 
      golsCasa: int.parse(golsCasaController.text), 
      golsVisitante: int.parse(golsVisitaController.text)
    );

    repository.insert(_partidaCadastrada);
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

            return Form(
              key: _formKey,
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(favoriteTeam: favoriteTeam, currentScreen: widget.currentScreen, changeScreen: widget.changeScreen,),
                  Column(
                    spacing: 5,
                    children: [
                      Text("Cadastrar Partida", style: Theme.of(context).textTheme.displayMedium,),
                      Text("Os dados serão persistidos no SQLite usando sqflite.")
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        spacing: 15,
                        children: [
                          TextFormField(
                            controller: rodadaController,
                            decoration: InputDecoration(
                              labelText: 'Rodada',
                              hintText: 'Digite o número da rodada',
                              prefixIcon: const Icon(Icons.list),
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                            ),
                            validator: (value) => int.tryParse(value ?? '') == null ? 'Rodada deve ser um número' : null,
                          ),
                      
                          TextFormField(
                            controller: dataControler,
                            decoration: InputDecoration(
                              labelText: 'Data',
                              hintText: 'Digite a data da partida',
                              prefixIcon: const Icon(Icons.calendar_today),
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                            ),
                            validator: (value) => value == null || value.isEmpty ? 'Digite a data' : null,
                          ),
                      
                          DropdownButtonFormField(
                            items: times.map((time) => DropdownMenuItem(
                              value: time, 
                              child: Row(
                                spacing: 10,
                                children: [
                                  SizedBox(height: 20, child: Image.asset(time.escudoUrl)),
                                  Text(time.nome)
                                ]
                              ),
                            )).toList(), 
                            decoration: InputDecoration(
                              hintText: 'Time da casa',
                              prefixIcon: const Icon(Icons.home),
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                            ),
                            validator: (value) => value == null ? 'Selecione o Time da casa' : null,
                            onChanged: (value) => timeCasa = value!
                          ),
                      
                          DropdownButtonFormField(
                            items: times.map((time) => DropdownMenuItem(
                              value: time, 
                              child: Row(
                                spacing: 10,
                                children: [
                                  SizedBox(height: 20, child: Image.asset(time.escudoUrl)),
                                  Text(time.nome)
                                ]
                              ),
                            )).toList(), 
                            decoration: InputDecoration(
                              hintText: 'Time visitante',
                              prefixIcon: const Icon(Icons.flight_takeoff),
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                            ),
                            validator: (value) => value == null ? 'Selecione o Time visitante' : null,
                            onChanged: (value) => timeVisitante = value!
                          ),
                      
                          Row(
                            spacing: 20,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: golsCasaController,
                                  decoration: InputDecoration(
                                    labelText: 'Gols casa',
                                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                  ),
                                  validator: (value) => int.tryParse(value ?? '') == null ? 'Rodada deve ser um número' : null,
                                ),
                              ),
                      
                              Expanded(
                                child: TextFormField(
                                  controller: golsVisitaController,
                                  decoration: InputDecoration(
                                    labelText: 'Gols visitante',
                                    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                                  ),
                                  validator: (value) => int.tryParse(value ?? '') == null ? 'Rodada deve ser um número' : null,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    cadastrarPartida();
                                    widget.changeScreen(widget.currentScreen == 1 ? 0 : 1);
                                  }
                                }, 
                                label: Text("Salvar partida"), 
                                icon: Icon(Icons.save),
                                style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.all(15))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      )
    ),);
  }
}