import 'package:flutter/material.dart';

import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/services/local/sp_global.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_offer_widget.dart';
import 'package:shoesappclient/ui/widgets/item_products_widget.dart';

class HomePage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final String nombre = SPGlobal().name;

  @override
  Widget build(BuildContext context) {
    //print(":::$nombre");//para verificar si trae nombre el SPGlobal
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: firestoreService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data;

            List<ProductModel> productsDiscount = [];
            //**------------1ra forma------------------ */
            for (var item in products) {
              if (item.discount > 0) {
                productsDiscount.add(item);
              }
            }
            //**------------2da forma--------------------- */
            // productsDiscount =
            //     products.where((element) => element.discount > 0).toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: BrandColor.primaryColor,
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spacing40Heigth,
                          H1(
                            text: "Hey $nombre, bienvenido nuevamente",
                            height: 1.15,
                          ),
                          spacing10Height,
                          H5(text: "Tenemos las mejoras ofertas siempre"),
                          spacing6Height,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: productsDiscount.map((e) {
                                //   String idBrand = e.brand;
                                // String newBrand = brands
                                //       .where((element) => element.id == idBrand)
                                //       .first
                                //       .name;
                                //   e.brand = newBrand;
                                return ItemOfferWidget(model: e);
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        H5(
                          text: "Últimos ingresos",
                          fontWeight: FontWeight.w700,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: BrandColor.primaryColor.withOpacity(1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              H6(
                                text: "Ver todo",
                                color: BrandColor.secondaryFontColor,
                              ),
                              const Icon(
                                Icons.arrow_right,
                                size: 18,
                                color: BrandColor.secondaryFontColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      childAspectRatio: 0.95,
                    ),
                    itemBuilder: (context, index) {
                      // String idBrand = products[index].brand;

                      // String newBrand = brands
                      //     .where((element) => element.id == idBrand)
                      //     .first
                      //     .name;
                      // products[index].brand = newBrand;
                      return ItemProductsWidget(
                        model: products[index],
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Center(
            child: loadingWidget,
          );
        },
      ),
    );
  }
}
