import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';
import 'package:xcmobile/features/historique_activation/models/historique_model.dart';

class HistoriqueItem extends StatelessWidget {
  final HistoriqueModel item;
  const HistoriqueItem(this.item, {super.key});

  _handleImage(String statut) {
    switch (statut) {
      case "encours":
        return XCImage.asset(imageUrl: 'assets/logos/progress.png');
      case "error":
        return XCImage.asset(imageUrl: 'assets/logos/error.png');
      case "done":
        return XCImage.asset(imageUrl: 'assets/logos/success.png');
      default:
    }
  }

  _handleMessage(String statut) {
    switch (statut) {
      case "encours":
        return Text(item.texte,
            style: AppTextStyles.bodySm.copyWith(color: AppColors.primary));
      case "error":
        return Text(item.texte,
            style: AppTextStyles.bodySm.copyWith(color: AppColors.error));
      case "done":
        return Text(item.texte,
            style: AppTextStyles.bodySm.copyWith(color: Colors.green));
      default:
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDSA = item.simDSA.contains('OUI') ? true : false;

    return ExpansionTile(
      leading: _handleImage(item.statut),
      title: Text(item.numClient),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date d'opération: ${item.dateOperation}"),
          _handleMessage(item.statut),
        ],
      ),
      children: [
        ListTile(
            title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SIM: ${item.sim}",
              style: AppTextStyles.body,
            ),
            Text(
              "numero POS: ${item.numeroPOS}",
              style: AppTextStyles.bodySm,
            ),
            Text(
              "Canal: ${item.canal}",
              style: AppTextStyles.bodySm,
            ),
            Text(
              "SIM DSA: ${isDSA ? "Oui" : "Non"}",
              style: AppTextStyles.bodySm,
            ),
          ],
        )),
      ],
    );
  }
}
