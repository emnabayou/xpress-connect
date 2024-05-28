import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/features/historique_activation/models/historique_model.dart';

class DSAItem extends StatelessWidget {
  final HistoriqueModel item;
  const DSAItem(this.item,{super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
          leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.sim_card_outlined,
                color: AppColors.primary,
              )),
          title: Text(item.numClient),
          trailing:  TextButton(child: const Text("Activer"),onPressed: () {
              log("activer");
          },),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Importée le ${item.dateOperation}",
                style: AppTextStyles.bodySm.copyWith(fontSize: 13),
              ),
            ],
          ),
          
          onTap: () {},
        );
  }
}