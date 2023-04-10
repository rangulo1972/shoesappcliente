import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shoesappclient/models/brand_model.dart';

import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class ItemBrandWidget extends StatelessWidget {
  //const ItemBrandWidget({super.key});
  //String brands;
  BrandModel model;
  VoidCallback onTap;

  ItemBrandWidget({required this.model, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        //color: Colors.amber,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: model.image,
            //
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return Image.asset(AssetData.iconPlaceHolder);
            },
            progressIndicatorBuilder: (context, url, progress) {
              return loadingWidget;
            },
          ),
        ),
      ),
    );
  }
}
