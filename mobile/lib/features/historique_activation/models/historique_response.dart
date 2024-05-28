import 'package:xcmobile/features/historique_activation/models/historique_model.dart';

class HistoriqueResponse {
  final String sEcho;
  final String iTotalRecords;
  final String iTotalDisplayRecords;
  final List<HistoriqueModel> data;

  HistoriqueResponse({
    required this.sEcho,
    required this.iTotalRecords,
    required this.iTotalDisplayRecords,
    required this.data,
  });

  factory HistoriqueResponse.fromJson(Map<String, dynamic> json) {
    return HistoriqueResponse(
      sEcho: json['sEcho'],
      iTotalRecords: json['iTotalRecords'],
      iTotalDisplayRecords: json['iTotalDisplayRecords'],
      data: List.from(json['aaData'])
          .map((e) => HistoriqueModel.fromJson(e))
          .toList(),
    );
  }
}
