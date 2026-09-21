import 'package:persistencia_local/database/app_database.dart';
import 'package:persistencia_local/models/partida.dart';

class PartidaRepository {
  Future<int> insert(Partida partida) async {
    final db = await AppDatabase.instance.database;

    final json = partida.toJson();
    json.remove('id');

    return db.insert(
      'partidas',
      json,
    );
  }

  Future<List<int>> getAllDistinctRodadas() async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'partidas',
      columns: ['rodada'],
      distinct: true,
      orderBy: 'rodada'
    );

    return result
        .map((element) => element.values.first as int)
        .toList();
  }

  Future<List<Partida>> getAllPartidas() async {
    final db = await AppDatabase.instance.database;

    final result = await db.query(
      'partidas',
    );

    return result
        .map(Partida.fromJson)
        .toList();
  }
}