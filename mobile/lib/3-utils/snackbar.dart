import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/main.dart';

class AppSnackBar {
  void showSnackBar(BuildContext context,
      {String? title,
      String? description,
      SnackBarAction? action,
      Duration duration = const Duration(seconds: 5),
      bool noAction = false,
      double? width,
      String? notificationImage}) {
    if (title == null) {
      return;
    }
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: duration,
        elevation: 2,
        backgroundColor: AppColors.primary.withOpacity(.9),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: notificationImage != null
                  ? Image.network(
                      notificationImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    )
                  : Container(
                    //padding: const EdgeInsets.all(10),
                    color: AppColors.white.withOpacity(0.3),
                    child: Image.asset(
                        "assets/logos/tt.png",
                        width: 40,
                        height: 40,
                      ),
                  ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    //textAlign: TextAlign.justify,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                  ),
                  description!=null ? Text(
                    description,
                    //textAlign: TextAlign.justify,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                  ) :const  SizedBox(),
                ],
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).colorScheme.primaryContainer,
          label: "Fermer",
          onPressed: () {},
        ),
      ));
    } catch (e) {
      log('err :$e');
      log('Failed to show Snackbar with title:$title');
    }
  }

  void showNotification(
      {String? title,
      String? body,
      Duration duration = const Duration(seconds: 5),
      double? width,
      String? notificationImage,
      bool topNotification = true}) {
    final currentContext = overlayKey.currentState?.context;
    final currentState = overlayKey.currentState;

    if (currentContext == null) {
      log("current context is null");
      return;
    }
    if (currentState == null) {
      log("current state is null");
      return;
    }

    final theme = Theme.of(currentContext);

    showTopSnackBar(
        overlayKey.currentState!,
        curve: Curves.easeOut,
        snackBarPosition:
            topNotification ? SnackBarPosition.top : SnackBarPosition.bottom,
        animationDuration: const Duration(milliseconds: 250),
        displayDuration: const Duration(seconds: 5),
        dismissType: DismissType.onSwipe,
        Container(
          clipBehavior: Clip.hardEdge,
          //height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: kDefaultBoxShadow,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  notificationImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.network(
                            notificationImage,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          "assets/logos/tt.png",
                          width: 50,
                          height: 50,
                        ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                            visible: title != null,
                            child: Text(title!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.9)))),
                        Visibility(
                            visible: body != null,
                            child: Text(
                              body!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.6)),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: 50,
                height: 2,
                color: Colors.white.withOpacity(0.5),
              )
            ],
          ),
        ));
  }
}
