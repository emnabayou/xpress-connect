import 'package:flutter/material.dart';
import 'package:xcmobile/features/historique_activation/data.dart';
import 'package:xcmobile/features/historique_activation/historique_item.dart';

class HistoriquePage extends StatefulWidget {
  const HistoriquePage({super.key});

  @override
  State<HistoriquePage> createState() => _HistoriquePageState();
}

class _HistoriquePageState extends State<HistoriquePage> {
  Set<String> _selected = {"anciennes"};
  String selectedSection = "anciennes";

  _onSelectionChanged(Set<String> values) {
    setState(() {
      _selected = values;
      selectedSection = values.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 10),
            SegmentedButton(
              segments: const [
                ButtonSegment(
                    label: Text("Anciennes"),
                    icon: Icon(Icons.hourglass_empty_outlined),

                    value: "anciennes"),
                ButtonSegment(
                    label: Text("Récentes"),
                    icon: Icon(Icons.history),
                    value: "recentes")
              ],
              selected: _selected,
              onSelectionChanged: _onSelectionChanged,
            ),
            historiqueActivation.data.isEmpty
                ? const Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline_outlined),
                        Text("Vous n’avez aucune activation pour ce mois ! "),
                      ],
                    ),
                )
                : Expanded(
                    child: ListView.builder(
                      itemCount: historiqueActivation.data.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        final item = historiqueActivation.data[index];
                        return HistoriqueItem(item);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
