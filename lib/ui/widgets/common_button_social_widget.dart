import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';

class CommonButtonSocialWidget extends StatelessWidget {
  String text;
  Color color;
  String? icon;

  CommonButtonSocialWidget({
    required this.text,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: icon != null
            ? SvgPicture.asset(
                icon!,
                color: Colors.white,
              )
            : const SizedBox(),
        label: H5(
          text: text,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
