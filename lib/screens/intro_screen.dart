import 'package:flutter/material.dart';
import 'package:persistencia_local/models/time.dart';
import 'package:persistencia_local/repositories/time_repository.dart';
import 'package:persistencia_local/screens/shell_screen.dart';
import 'package:persistencia_local/services/preferences_services.dart';

class IntroScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _teams = getTimes();
  Time? _selectedTeam;

  final preferences = PreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFf8fbf2), 
      body: SafeArea(child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsetsGeometry.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 30,
            children: [
            Text("Escolha seu time", style: Theme.of(context).textTheme.headlineMedium,),
            Expanded(
              child: Center(
                child: Column(
                  spacing: 10,
                  children: [
                    Text("Selecione seu time favorito", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    Text("A escolha será salva no SharedPreferences", style: Theme.of(context).textTheme.titleMedium),
                    SingleChildScrollView(
                      child: RadioGroup(
                        groupValue: _selectedTeam,
                        onChanged: (value) => setState(() => _selectedTeam = value), 
                        child: Column(children: _teams.map((time) => Column(
                          children: [
                            RadioListTile<Time>(
                              toggleable: true,
                              controlAffinity: ListTileControlAffinity.trailing,
                              value: time,
                              title: Row(
                                spacing: 5,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Image.asset(time.escudoUrl)
                                  ),
                                  Text(time.nome)
                                ],
                              ),
                            ),
                            if (time != _teams.last) 
                              Divider(height: 2)
                          ],
                        )).toList())
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity, 
                child: FilledButton(
                  onPressed: _selectedTeam != null 
                  ? () => setState(() {
                    preferences.saveFavoriteTeam(_selectedTeam!);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => ShellScreen()), ModalRoute.withName("/partidas"));
                  })
                  : null,
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                  ),
                  child: Text("Continuar", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
                )
              ),
            )
          ],),
        ),
      ))
    );
  }
}