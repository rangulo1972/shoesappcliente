import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/types.dart';

class CommonInputWidget extends StatelessWidget {
  String label;
  String hintText;
  String icon;
  TextEditingController controller;
  InputTypeEnum inputType;

  CommonInputWidget({
    required this.label,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H5(
          text: "  $label:",
          fontWeight: FontWeight.w600,
        ),
        spacing2Height,
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: inputType == InputTypeEnum.phone
                ? TextInputType.phone
                : inputType == InputTypeEnum.email
                    ? TextInputType.emailAddress
                    : TextInputType.text,
            maxLength: inputType == InputTypeEnum.phone ? 9 : null,
            decoration: InputDecoration(
              counterText: "",
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                color: BrandColor.primaryFontColor.withOpacity(0.6),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              prefixIcon: SvgPicture.asset(
                icon,
                fit: BoxFit.scaleDown,
                color: BrandColor.primaryFontColor.withOpacity(0.50),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return "Campo Obligatorio";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
