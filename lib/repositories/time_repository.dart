import 'package:persistencia_local/models/time.dart';

const String assetsUrl = "./assets/images";

List<Time> getTimes() {
  return [
    Time(nome: "Corinthians", escudoUrl: "$assetsUrl/corinthians.png"),
    Time(nome: "Flamengo", escudoUrl: "$assetsUrl/flamengo.png"),
    Time(nome: "Gremio", escudoUrl: "$assetsUrl/gremio.png"),
    Time(nome: "Palmeiras", escudoUrl: "$assetsUrl/palmeiras.png"),
    Time(nome: "Santos", escudoUrl: "$assetsUrl/santos.png"),
    Time(nome: "Vasco", escudoUrl: "$assetsUrl/vasco.png"),
  ];
}