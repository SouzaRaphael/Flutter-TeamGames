import 'package:flutter/material.dart';
import 'package:persistencia_local/screens/cadastro_partida_screen.dart';
import 'package:persistencia_local/screens/partidas_screen.dart';

class ShellScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _selectedIndex = 0;

  Widget _getScreen() {
    if (_selectedIndex == 0) {
      return PartidasScreen(currentScreen: _selectedIndex, changeScreen: _changeScreen,);
    }

    return CadastroPartidaScreen(currentScreen: _selectedIndex, changeScreen: _changeScreen,);
  }

  void _changeScreen(int newIndex) {
    setState(() => _selectedIndex = newIndex); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sports_soccer),
            label: 'Jogos',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Cadastrar',
          ),
        ],
      ),
    );
  }
}