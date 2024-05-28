// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:xcmobile/1-core/app_colors.dart';
import 'package:xcmobile/1-core/app_text_styles.dart';
import 'package:xcmobile/1-core/config.dart';
import 'package:xcmobile/1-core/xc_boxes.dart';
import 'package:xcmobile/2-widgets/background_container.dart';
import 'package:xcmobile/2-widgets/xc_circular_progress_indicator.dart';
import 'package:xcmobile/3-utils/snackbar.dart';
import 'package:xcmobile/features/3-navigation/navigation_page.dart';

class TermsAndConditions extends StatefulWidget {
  static const String route = "/terms";
  final bool fromInsideApp;
  const TermsAndConditions({this.fromInsideApp = false, super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool acceptedTerms =
      XCBoxes.settingsBox.get("acceptedTerms", defaultValue: false);

  bool? checked1 = false;
  bool? checked2 = false;
  bool? checked3 = false;

  bool isLoading = false;
  _allChecked() {
    return checked1 == true && checked2 == true && checked3 == true;
  }

  _acceptTerms() async {
    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    await XCBoxes.settingsBox.put("acceptedTerms", true);
    setState(() => isLoading = false);
    if (widget.fromInsideApp) {
      AppSnackBar().showSnackBar(context, title: "Vous avez accepter les conditions d'utilisation!");
      Navigator.pop(context);
      return;
    }
    AppSnackBar().showSnackBar(context, title: "Vous êtes connecté!");
    Navigator.popAndPushNamed(context, HomePage.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: acceptedTerms
          ? AppBar(
              backgroundColor: Colors.transparent,
            )
          : null,
      extendBodyBehindAppBar: true,
      body: BackgroundContainer(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
              .copyWith(top: 50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ArabicText(
                    "قواعد وشروط الاستعمال",
                    style: AppTextStyles.h1,
                  ),
                  const ArabicText(
                    "يلتزم كلّ عون يتاح له في إطار القيام بالمهام المناطة بعهدته استعمال تجهيزات اعلامية و/أو الولوج للنظم المعلوماتية التابعة للشركة، بالتقيد بالقواعد والشروط التالية :",
                  ),
                  const SizedBox(height: 10),
                  const ArabicText(
                    "النفاذ إلى النظم المعلوماتية للشركة من قبل كل عون يكون باستعمال الوسائل التي تتيحها له المصالح المختصّة بالشركة والمتمثلة في اسم المستعمل (login) وكلمة العبور (mot de passe)",
                    withDot: true,
                  ),
                  const ArabicText(
                    "استخدام كل عون لاسم المستعمل ولكلمة العبور المسندين له من قبل الشركة بصفة شخصية وحصريا لغرض انجاز المهام المكلّف بها بالمصالح التي يرجع إليها بالنظر.",
                    withDot: true,
                  ),
                  const ArabicText(
                    "الحفاظ على السرية المطلقة لاسم المستعمل ولكلمة العبور والامتناع عن اتاحتهما، تحت أي ظرف أو لأي سبب كان، للغير سواء من بين أعوان الشركة او خارجها.",
                    withDot: true,
                  ),
                  const ArabicText(
                    "الاشعار الفوري بأي خلل يطرأ على استعمال اسم المستعمل وكلمة العبور وبأي استغلال لهما في غير محله، خاصة من طرف الغيروبكل ما قد تتمّ ملاحظته من إشكاليات أو صعوبات. يكون الاشعار عبر الرابط التالي : ",
                    withDot: true,
                  ),
                  const Divider(),
                  const ArabicText(
                    "كل عون يخالف القواعد والشروط المبينة أعلاه يعرّض نفسه للمساءلة الإدارية والتتبعات القانونية طبقا للتشريع الجاري به العمل",
                  ),
                  const SizedBox(height: 10),
                  !acceptedTerms
                      ? Column(
                          children: [
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const ArabicText(
                                "اطّلعت ووافقت على التقيّد بالشروط المذكورة بهذه الوثيقة",
                              ),
                              value: checked1,
                              onChanged: (value) =>
                                  setState(() => checked1 = value),
                            ),
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const ArabicText(
                                "احتفظت، بعد التأكيد، بنسخة ورقية من هذه الوثيقة لكل غاية قانونية",
                              ),
                              value: checked2,
                              onChanged: (value) =>
                                  setState(() => checked2 = value),
                            ),
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const ArabicText(
                                "قمت، بعد التأكيد، بطباعة نسخة ورقية من هذه الوثيقة وقمت بإيداعها لدى رئيسي المباشر",
                              ),
                              value: checked3,
                              onChanged: (value) =>
                                  setState(() => checked3 = value),
                            ),
                            const SizedBox(height: 10),
                            FilledButton(
                                onPressed: _allChecked() ? _acceptTerms : null,
                                style: FilledButton.styleFrom(
                                  fixedSize: Size(
                                      widthFromPercentage(context, 100), 50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("تأكيد"),
                                    const SizedBox(width: 10),
                                    Visibility(
                                        visible: isLoading,
                                        child:
                                            const XCCircularProgressIndicator(
                                          color: AppColors.white,
                                          size: 18,
                                        )),
                                  ],
                                )),
                          ],
                        )
                      : const SizedBox(),
                  TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        fixedSize: Size(widthFromPercentage(context, 100), 50),
                      ),
                      child: const Text("طباعة"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArabicText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool withDot;
  const ArabicText(this.text, {this.style, this.withDot = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "${withDot ? "\u2022 " : ""}$text",
      style: style,
      textDirection: TextDirection.rtl,
    );
    /*return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text,
            style: style,
            textDirection: TextDirection.rtl,
          ),
        ),
        withDot ? Container(width: 10,height: 10,color: Colors.red,) : const SizedBox(),
      ],
    );*/
  }
}
