import 'package:flutter/material.dart';
import 'package:xcmobile/features/historique_activation/data.dart';
import 'package:xcmobile/features/stock_disponible/dsa_section/dsa_item.dart';

class DSASection extends StatelessWidget {
  const DSASection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historiqueActivation.data.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final item = historiqueActivation.data[index];
        return DSAItem(item);
      },
    );
  }
}
