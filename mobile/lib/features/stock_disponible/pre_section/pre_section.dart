import 'package:flutter/material.dart';
import 'package:xcmobile/features/historique_activation/data.dart';
import 'package:xcmobile/features/stock_disponible/pre_section/pre_item.dart';

class PreDeclareSection extends StatelessWidget {
  const PreDeclareSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historiqueActivation.data.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final item = historiqueActivation.data[index];
        return PreItem(item);
      },
    );
  }
}
