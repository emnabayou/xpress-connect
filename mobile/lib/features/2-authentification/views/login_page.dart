import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/2-widgets/background_container.dart';
import 'package:xcmobile/2-widgets/xc_circular_progress_indicator.dart';
import 'package:xcmobile/2-widgets/xc_image.dart';
import 'package:xcmobile/3-utils/custom_text_field.dart';
import 'package:xcmobile/features/2-authentification/providers/login_change_notifier.dart';

class LoginPage extends ConsumerWidget {
  static const String route = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    final isLoading = ref.watch(loginChangeNotifer).isLoading;
    final handleSubmit = ref.read(loginChangeNotifer).handleSubmit;
    final formKey = ref.read(loginChangeNotifer).formKey;

    return Scaffold(
      appBar: AppBar(
        title: XCImage.asset(imageUrl: "assets/logos/tt.png", width: 70),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundContainer(
        child: SafeArea(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Authentification',
                        style: textTheme.headlineLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      const CustomTextField(
                        label: 'Username',
                        hint: 'Enter your username',
                        icon: Icons.person,
                        isRequired: true,
                      ),
                      const SizedBox(height: 15),
                      const CustomTextField(
                        label: 'Password',
                        hint: '******',
                        icon: Icons.key,
                        isRequired: true,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: FilledButton(
                            onPressed: () => handleSubmit(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                    visible: isLoading,
                                    child: const XCCircularProgressIndicator(
                                      size: 20,
                                      color: AppColors.white,
                                    )),
                                const SizedBox(width: 7),
                                Text(
                                  'S’authentifier',
                                  style: textTheme.titleMedium!.copyWith(
                                      color: theme.colorScheme.onPrimary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
