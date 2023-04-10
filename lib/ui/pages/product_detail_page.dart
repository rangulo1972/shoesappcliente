import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_discount_widget.dart';
import 'package:shoesappclient/ui/widgets/item_size_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';
import 'package:shoesappclient/utils/calculate.dart';
import 'package:shoesappclient/utils/responsive.dart';

class ProductDetailPage extends StatelessWidget {
  ProductModel model;

  ProductDetailPage({
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: model.image,
                height: ResponsiveUI.pDiagonal(context, 0.37),
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.asset(AssetData.iconPlaceHolder);
                },
                progressIndicatorBuilder: (context, url, progress) {
                  return loadingWidget;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.discount > 0
                        ? ItemDiscountWidget(discount: model.discount)
                        : const SizedBox(),

                    spacing4Height,
                    H4(
                      text: model.brand,
                      color: BrandColor.primaryFontColor.withOpacity(0.6),
                    ),
                    //spacing8Height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: H2(
                            text: model.name,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            H6(
                              text: model.discount > 0
                                  ? model.price.toString()
                                  : "",
                              color:
                                  BrandColor.primaryFontColor.withOpacity(0.68),
                              textDecoration: TextDecoration.lineThrough,
                            ),
                            H4(
                              text:
                                  "S/. ${Calculate.getPrice(model.price, model.discount).toStringAsFixed(2)}",
                              fontWeight: FontWeight.w800,
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    spacing16Height,
                    H5(
                      text: "Tallas disponibles",
                      color: BrandColor.primaryFontColor.withOpacity(0.6),
                    ),
                    spacing12Height,
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: model.sizes
                          .map((e) => ItemSizeWidget(
                                size: e,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.transparent,
              height: 100,
              child: Row(
                children: [
                  H2(
                    text:
                        "S/. ${Calculate.getPrice(model.price, model.discount).toStringAsFixed(2)}",
                  ),
                  spacing16Width,
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColor.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          AssetData.iconWhatsApp,
                          color: Colors.white,
                        ),
                        label: H5(
                          text: "Obtener ahora",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
