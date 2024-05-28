class HistoriqueModel {
  final String numClient;
  final String sim;
  final String proprietaire;
  final String numeroPOS;
  final String dateOperation;
  final String dateModification;
  final String statut;
  final String texte;
  final String canal;
  final String simDSA;

  HistoriqueModel({
    required this.numClient,
    required this.sim,
    required this.proprietaire,
    required this.numeroPOS,
    required this.dateOperation,
    required this.dateModification,
    required this.statut,
    required this.texte,
    required this.canal,
    required this.simDSA,
  });

  factory HistoriqueModel.fromJson(List<String> json) {
    return HistoriqueModel(
      numClient: json[0],
      sim: json[1],
      proprietaire: json[2],
      numeroPOS: json[3],
      dateOperation: json[4],
      dateModification: json[5],
      statut: json[6],
      texte: json[7],
      canal: json[8],
      simDSA: json[9],
    );
  }
}
