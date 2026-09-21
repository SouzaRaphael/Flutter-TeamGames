import 'package:flutter/material.dart';
import 'package:persistencia_local/models/partida.dart';

class PartidaComponent extends StatelessWidget {
  const PartidaComponent({super.key, required this.partida});

  final Partida partida;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(partida.data),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Column(
              children: [
                SizedBox(width: 50, child: Image.asset(partida.timeCasa.escudoUrl)),
                Text(partida.timeCasa.nome)
              ],
            ),
            Text(
              "${partida.golsCasa} X ${partida.golsVisitante}", 
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(letterSpacing: 10, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                SizedBox(width: 50, child: Image.asset(partida.timeVisitante.escudoUrl)),
                Text(partida.timeVisitante.nome)
              ],
            ),
          ],
        )
      ],
    );
  }
}