import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/features/historique_activation/models/historique_model.dart';

class PreItem extends StatelessWidget {
  final HistoriqueModel item;
  const PreItem(this.item,{super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
          leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.tertiaryContainer.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.sim_card_outlined,
                color: AppColors.tertiary,
              )),
          title: Text(item.numClient),
          trailing: const SizedBox(),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date d'opération: ${item.dateOperation}",
                style: AppTextStyles.bodySm.copyWith(fontSize: 13),
              ),
            ],
          ),
          onTap: () {},
        );
  }
}