// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/xc_boxes.dart';
import 'package:xcmobile/2-widgets/xc_modal.dart';
import 'package:xcmobile/3-utils/snackbar.dart';
import 'package:xcmobile/features/2-authentification/providers/login_change_notifier.dart';
import 'package:xcmobile/features/2-authentification/views/terms_and_conditions.dart';
import 'package:xcmobile/features/3-navigation/providers/navigation_change_notifier.dart';
import 'package:xcmobile/features/profile_page/profile_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  _handleClearCache() async {
    await XCBoxes.settingsBox.clear();
    AppSnackBar()
        .showSnackBar(context, title: "Données de navigation supprimé!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _SingleSection(
              title: "Mon Profil",
              children: [ProfileSection()],
            ),
            _SingleSection(
              title: "Général",
              children: [
                _CustomListTile(
                  title: "Termes & Conditions",
                  icon: CupertinoIcons.doc_plaintext,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TermsAndConditions(fromInsideApp: true),
                      )),
                ),
                _CustomListTile(
                  title: "Supprimer les données de navigation",
                  icon: Icons.delete_sweep_outlined,
                  trailing: const SizedBox(),
                  onTap: _handleClearCache,
                ),
                _CustomListTile(
                  title: "Version",
                  icon: CupertinoIcons.device_phone_portrait,
                  trailing: Text(
                    XCBoxes.deviceInfoBox
                        .get('version', defaultValue: 'undefined'),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  showDivider: false,
                )
              ],
            ),
            _SingleSection(
              children: [
                _CustomListTile(
                  title: "Déconnexion ",
                  icon: Icons.logout,
                  showDivider: false,
                  onTap: () => XCModal().openDialog(context,
                      topBarTitle: "Deconnexion",
                      image: Image.asset(
                        "assets/images/exit.png",
                        height: 60,
                      ),
                      title:
                          "Êtes-vous sûr de vouloir vous déconnecter ? Vous devrez vous reconnecter pour utiliser l'application à nouveau.",
                      cancelTitle: "Annuler",
                      confirmTitleColor: AppColors.white,
                      //confirmButtonColor: AppColors.primary,
                      confirmIcon: const Icon(
                        Icons.logout,
                        color: AppColors.white,
                        size: 15,
                      ),
                      confirmButtonColor: AppColors.primary,
                      confirmTitle: "Se déconnecter", onConfirm: () {
                    ref.read(navigationChangeNotifier).reset();
                    ref.read(loginChangeNotifer).logout(context);
                  }),
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final void Function()? onTap;
  final bool showDivider;

  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      this.showDivider = true,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          leading: Icon(
            icon,
            color: AppColors.primary,
          ),
          trailing: trailing ??
              const Icon(
                CupertinoIcons.forward,
                size: 18,
                color: AppColors.grey,
              ),
          onTap: onTap,
        ),
        Visibility(
          visible: showDivider,
          child: const Divider(
            color: AppColors.grey,
            height: 3,
            thickness: 0.5,
          ),
        )
      ],
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        title != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title?.toUpperCase() ?? "",
                  style: TextStyle(
                      color: AppColors.black.withAlpha(150), fontSize: 16),
                ),
              )
            : const SizedBox(height: 16),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: AppColors.iconColor.withOpacity(0.2), blurRadius: 10)
          ], color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
