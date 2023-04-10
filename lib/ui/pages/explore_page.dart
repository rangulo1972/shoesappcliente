import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/search/search_product.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';
import 'package:shoesappclient/ui/widgets/item_products_widget.dart';

class ExplorePage extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: firestoreService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  //expandedHeight: 70,
                  toolbarHeight: 70,
                  shadowColor: BrandColor.primaryColor,
                  //collapsedHeight: 70,
                  //titleSpacing: 16,
                  backgroundColor: BrandColor.primaryColor,
                  //expandedHeight: 180,
                  title: TextField(
                    onTap: () async {
                      await showSearch(
                        context: context,
                        delegate: SearchProduct(products: products),
                      );
                    },
                    cursorColor: BrandColor.secondaryFontColor,
                    style: const TextStyle(
                        fontSize: 14, color: BrandColor.secondaryFontColor),
                    //enabled: false,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Buscar producto...",
                      hintStyle: const TextStyle(
                          fontSize: 14, color: BrandColor.secondaryFontColor),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.35),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 18,
                        color: BrandColor.secondaryFontColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    child: H5(
                      text: "Nuestros Productos",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ])),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ItemProductsWidget(
                        model: products[index],
                      );
                    },
                    childCount: products.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    childAspectRatio: 0.9,
                  ),
                ),
              ],
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
