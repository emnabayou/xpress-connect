import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:xcmobile/1-core/app_colors.dart';

class XCModal {
  openDialog(BuildContext context,
      {required String topBarTitle,
      Widget? image,
      String? title,
      bool showCancelBtn = true,
      FutureOr<void> Function()? onConfirm,
      String cancelTitle = "Cancel",
      String confirmTitle = "Confirm",
      Color confirmTitleColor = Colors.black,
      Color? confirmButtonColor,
      Widget confirmIcon = const SizedBox()}) {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (modalSheetContext) {
        return [
          WoltModalSheetPage(
              backgroundColor: Theme.of(context).cardColor,
              sabGradientColor: Theme.of(context).cardColor,
              trailingNavBarWidget: IconButton(
                padding: const EdgeInsets.all(20),
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(modalSheetContext).pop();
                },
              ),
              topBarTitle: Text(
                topBarTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              isTopBarLayerAlwaysVisible: true,
              child: Container(
                padding: const EdgeInsets.all(40).copyWith(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    image ?? const SizedBox(),
                    const SizedBox(height: 10),
                    Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: showCancelBtn,
                            child: Material(
                              //color: AppColors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    child: Text(
                                      cancelTitle,
                                      style: const TextStyle(
                                          color: AppColors.black),
                                    )),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Material(
                            color: confirmButtonColor ?? AppColors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {
                                Navigator.pop(context); //close the modal
                                onConfirm != null
                                    ? onConfirm()
                                    : log("modal closed");
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  child: Row(
                                    children: [
                                      confirmIcon,
                                      Text(
                                        confirmTitle,
                                        style: TextStyle(
                                            color: confirmTitleColor),
                                      ),
                                    ],
                                  )),
                            ),
                          )
                        ])
                  ],
                ),
              ))
        ];
      },
      modalTypeBuilder: (context) => WoltModalType.dialog,
      onModalDismissedWithBarrierTap: () {
        debugPrint('Closed modal sheet with barrier tap');
        Navigator.of(context).pop();
      },
      minDialogWidth: 350,
      minPageHeight: 0.0,
      maxPageHeight: 0.9,
    );
  }

  void openModal(BuildContext context,
      {required String topBarTitle,
      required Widget child,
      FutureOr<void> Function()? onCompleteCallback}) {
    WoltModalSheet.show(
      context: context,
      pageListBuilder: (modalSheetContext) {
        return [
          WoltModalSheetPage(
              backgroundColor: Theme.of(context).cardColor,
              sabGradientColor: Theme.of(context).cardColor,
              trailingNavBarWidget: IconButton(
                padding: const EdgeInsets.all(20),
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(modalSheetContext).pop();
                },
              ),
              topBarTitle: Text(
                topBarTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              isTopBarLayerAlwaysVisible: true,
              child: child)
        ];
      },
      modalTypeBuilder: (context) => WoltModalType.bottomSheet,
      onModalDismissedWithBarrierTap: () {
        debugPrint('Closed modal sheet with barrier tap');
        Navigator.of(context).pop();
      },
      minDialogWidth: 350,
      minPageHeight: 0.0,
      maxPageHeight: 0.9,
    );
  }
}
