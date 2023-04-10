import 'package:flutter/material.dart';
import 'package:shoesappclient/models/brand_model.dart';
import 'package:shoesappclient/services/remote/firestore_service.dart';
import 'package:shoesappclient/ui/pages/brand_filter_page.dart';
import 'package:shoesappclient/ui/widgets/common_text.dart';
import 'package:shoesappclient/ui/widgets/common_widget.dart';

import 'package:shoesappclient/ui/widgets/item_brand_widget.dart';

class MarcasPage extends StatelessWidget {
  //const MarcasPage({super.key});
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: firestoreService.getBrand(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<BrandModel> brands = snapshot.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  floating: true,
                  toolbarHeight: 80,
                  centerTitle: true,
                  title: H5(
                    text: "Nuestras Marcas",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(14),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: brands
                        .map((e) => ItemBrandWidget(
                              model: e,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BrandFilterPage(
                                      model: e,
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ),
                ),
              ],
            );
          }
          return loadingWidget;
        },
      ),
    );
  }
}
