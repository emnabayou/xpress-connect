import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data_plus/sim_data.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/2-widgets/xc_circular_progress_indicator.dart';
import 'package:xcmobile/3-utils/custom_text_field.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  String simCards = "";
  bool isLoadingProfile = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    fetchPhoneNumber();
  }

  fetchPhoneNumber() async {
    final hasPhonePermission = await Permission.phone.isGranted;
    log("hasPhonePermission : $hasPhonePermission");
    try {
      SimData simData = await SimDataPlugin.getSimData();
      for (var s in simData.cards) {
        log('Serial number: ${s.serialNumber}');
      }
      setState(() {
        simCards = simData.cards.firstOrNull?.serialNumber ?? "unknown";
      });
    } catch (e) {
      log("error! code: $e");
    }
  }

  _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => isLoadingProfile = true);
    _formKey.currentState!.save();

    await Future.delayed(const Duration(seconds: 2));
    log("success");
    setState(() => isLoadingProfile = false);
  }

  @override
  Widget build(BuildContext context) {
    const initials = "YM";
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                initials.toUpperCase(),
                style:
                    const TextStyle(color: AppColors.iconColor, fontSize: 27),
              ))),
          Text(
            "Youssef marzouk",
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          Text(
            "youssef.marzouk@tunisietelecom.com",
            style: AppTextStyles.body,
          ),
          Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Email",
                      hint: "Email",
                      readOnly: true,
                      icon: Icons.mail_outline_rounded,
                      initialValue: "youssef.marzouk@tunisietelecom.com",
                      withMargin: true,
                    ),
                    CustomTextField(
                      label: "Prénom",
                      hint: "Votre prénom",
                      icon: Icons.person_outline_rounded,
                      initialValue: "Youssef",
                      withMargin: true,
                      readOnly: true,
                      onSaved: (String? value) {
                        //setState(() => user.firstName = value!);
                      },
                    ),
                    CustomTextField(
                      label: "Nom",
                      hint: "Votre nom",
                      icon: Icons.person_outline_rounded,
                      initialValue: "Marzouk",
                      readOnly: true,
                      withMargin: true,
                      onSaved: (String? value) {
                        //setState(() => user.lastName = value!);
                      },
                    ),
                    CustomTextField(
                      label: "Login",
                      hint: "Login",
                      icon: Icons.code,
                      initialValue: "0000000054",
                      readOnly: true,
                      withMargin: true,
                    ),
                    CustomTextField(
                      label: "Rôle",
                      hint: "Rôle",
                      icon: Icons.admin_panel_settings_outlined,
                      initialValue: "POS Indirect",
                      readOnly: true,
                      withMargin: true,
                    ),
                    InkWell(
                      onTap: !isLoadingProfile ? _submitForm : null,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              color: !isLoadingProfile
                                  ? AppColors.primary
                                  : AppColors.primary.withOpacity(.3),
                              borderRadius: BorderRadius.circular(30)),
                          child: isLoadingProfile
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const XCCircularProgressIndicator(
                                    size: 25,
                                  ))
                              : Row(mainAxisSize: MainAxisSize.min, children: [
                                  Icon(Icons.save,
                                      color: !isLoadingProfile
                                          ? Colors.white
                                          : Colors.white.withOpacity(.3)),
                                  Text(
                                    "Modifier",
                                    style: AppTextStyles.body.copyWith(
                                        color: !isLoadingProfile
                                            ? Colors.white
                                            : Colors.white.withOpacity(.3)),
                                  )
                                ])),
                    )
                    //DrawerButton()
                    //TextButton(onPressed: onPressed, child: child)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
