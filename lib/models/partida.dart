import 'dart:convert';

import 'package:persistencia_local/models/time.dart';

class Partida {
  final int? id;
  final int rodada;
  final String data;
  final Time timeCasa;
  final Time timeVisitante;
  final int golsCasa;
  final int golsVisitante;

  Partida({this.id, required this.rodada, required this.data, required this.timeCasa, required this.timeVisitante, required this.golsCasa, required this.golsVisitante});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rodada': rodada,
      'data': data,
      'timeCasa': jsonEncode(timeCasa.toJson()),
      'timeVisitante': jsonEncode(timeVisitante.toJson()),
      'golsCasa': golsCasa,
      'golsVisitante': golsVisitante,
    };
  }

  factory Partida.fromJson(Map<String, dynamic> json) {
    return Partida(
      id: json['id'] as int?,
      rodada: json['rodada'] as int, 
      data: json['data'] as String, 
      timeCasa: Time.fromJson(jsonDecode(json['timeCasa'])), 
      timeVisitante: Time.fromJson(jsonDecode(json['timeVisitante'])), 
      golsCasa: json['golsCasa'] as int, 
      golsVisitante: json['golsVisitante'] as int
    );
  }
}