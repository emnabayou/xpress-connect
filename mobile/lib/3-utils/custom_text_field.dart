import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xcmobile/1-core/app_colors.dart';

class CustomTextField extends ConsumerStatefulWidget {
  final String? label;
  final String? hint;
  final IconData? icon;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final bool isRequired;
  final bool readOnly;
  final bool isPassword;
  final bool isnumber;
  final TextEditingController? controller;
  final bool isTransparent;
  final bool withMargin;
  const CustomTextField(
      {super.key,
      this.label,
      this.hint,
      this.icon,
      this.initialValue,
      this.onSaved,
      this.onChanged,
      this.controller,
      this.isRequired = true,
      this.readOnly = false,
      this.isPassword = false,
      this.isnumber = false,
      this.isTransparent = false,
      this.withMargin = false});

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isTransparent) {
      return TextFormField(
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0.0),
          labelText: widget.label,
          fillColor: Colors.transparent,
          hintText: widget.hint,
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                )
              : null,
        ),
        controller: widget.controller,
        initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        obscureText: (widget.isPassword && !visible),
        keyboardType:
            widget.isnumber ? TextInputType.number : TextInputType.text,
        validator: (String? value) {
          if (widget.isRequired == false) {
            return null;
          }
          if (value != null && value.isEmpty) {
            return "Ce champ est obligatoire";
          }
          return null;
        },
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
      );
    }
    return Container(
      margin: EdgeInsets.only(bottom: widget.withMargin ? 10 : 0),
      child: Stack(
        children: [
          TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0.0),
                labelText: widget.label,
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.inputStoke)),
                hintText: widget.hint,
                prefixIcon: widget.icon != null
                    ? Icon(
                        widget.icon,
                      )
                    : null,
              ),
              controller: widget.controller,
              initialValue: widget.initialValue,
              readOnly: widget.readOnly,
              obscureText: (widget.isPassword && !visible),
              keyboardType:
                  widget.isnumber ? TextInputType.phone : TextInputType.text,
              validator: (String? value) {
                if (widget.isRequired == false) {
                  return null;
                }
                if (value != null && value.isEmpty) {
                  return "Ce champ est obligatoire";
                }
                if (widget.isnumber &&
                    !(value!.length >= 8 && value.length <= 12)) {
                  return 'Numéro de téléphone non valide';
                }
                return null;
              },
              onChanged: widget.onChanged,
              onSaved: widget.onSaved),
          widget.isPassword
              ? Positioned(
                  right: 0,
                  child: IconButton(
                      onPressed: () => setState(() => visible = !visible),
                      icon: visible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
