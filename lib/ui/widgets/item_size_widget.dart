import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';

class ItemSizeWidget extends StatelessWidget {
  double size;

  ItemSizeWidget({
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color:Colors.amber,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.95,
          color: BrandColor.primaryFontColor.withOpacity(0.30),
        ),
      ),
      height: 50,
      width: 60,
      alignment: Alignment.center,
      child: H4(
        text: size.toString(),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
