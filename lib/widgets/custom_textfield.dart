import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Widget? icon;
  final Color colorContainer;
  final String? hintText;
  final String? errorText;
  final int? maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;

  const CustomTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.icon,
    this.hintText,
    this.colorContainer = const Color(0xFFFFFFFF),
    this.maxLines,
    this.maxLength,
    this.textInputAction,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: colorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          icon == null
              ? const SizedBox()
              : Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: const Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                  ),
                ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              textInputAction: textInputAction,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              maxLines: maxLines,
              maxLength: maxLength,
              style: Theme.of(context).textTheme.bodyText2,
              controller: controller,
              decoration: InputDecoration(
                errorText: errorText,
                errorStyle: Theme.of(context).textTheme.subtitle2,
                border: InputBorder.none,
                counterText: '',
                hintText: hintText,
                hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: const Color.fromARGB(255, 113, 113, 113),
                    ),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
