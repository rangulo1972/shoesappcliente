import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/utils/responsive.dart';

SizedBox spacing40Heigth = const SizedBox(height: 40);
SizedBox spacing30Height = const SizedBox(height: 30);
SizedBox spacing20Height = const SizedBox(height: 20);
SizedBox spacing18Height = const SizedBox(height: 18);
SizedBox spacing16Height = const SizedBox(height: 16);
SizedBox spacing14Height = const SizedBox(height: 14);
SizedBox spacing12Height = const SizedBox(height: 12);
SizedBox spacing10Height = const SizedBox(height: 10);
SizedBox spacing8Height = const SizedBox(height: 8);
SizedBox spacing6Height = const SizedBox(height: 6);
SizedBox spacing4Height = const SizedBox(height: 4);
SizedBox spacing2Height = const SizedBox(height: 2);

SizedBox spacing2Width = const SizedBox(width: 2);
SizedBox spacing4Width = const SizedBox(width: 4);
SizedBox spacing6Width = const SizedBox(width: 6);
SizedBox spacing8Width = const SizedBox(width: 8);
SizedBox spacing10Width = const SizedBox(width: 10);
SizedBox spacing12Width = const SizedBox(width: 12);
SizedBox spacing14Width = const SizedBox(width: 14);
SizedBox spacing16Width = const SizedBox(width: 16);
SizedBox spacing18Width = const SizedBox(width: 18);
SizedBox spacing20Width = const SizedBox(width: 20);
SizedBox spacing30Width = const SizedBox(width: 30);
SizedBox spacing40Width = const SizedBox(width: 40);

Center loadingWidget = const Center(
  child: SizedBox(
    width: 50,
    height: 50,
    child: CupertinoActivityIndicator(
      radius: 20,
      color: BrandColor.secondaryColor,
    ),
  ),
);

Stack backgroundWidget(BuildContext context) => Stack(
      children: [
        Positioned(
          top: -ResponsiveUI.pDiagonal(context, 0.2),
          left: -ResponsiveUI.pDiagonal(context, 0.05),
          child: Transform.rotate(
            angle: pi / 3.5,
            child: Container(
              height: ResponsiveUI.pDiagonal(context, 0.48),
              width: ResponsiveUI.pDiagonal(context, 0.48),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                gradient: const LinearGradient(
                  colors: [
                    BrandColor.secondaryColor,
                    BrandColor.primaryColor,
                  ],
                ),
                color: Colors.amber,
                boxShadow: [
                  BoxShadow(
                    color: BrandColor.primaryColor.withOpacity(0.6),
                    blurRadius: 12,
                    offset: const Offset(6, 6),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

SnackBar snackBarError(String message) => SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: [
          Expanded(
            child: H5(
              text: message,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
