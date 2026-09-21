class Time {
  final String nome;
  final String escudoUrl;

  Time({required this.nome, required this.escudoUrl});

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'escudoUrl': escudoUrl,
    };
  }

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      nome: json['nome'] as String, 
      escudoUrl: json['escudoUrl'] as String, 
    );
  }
}