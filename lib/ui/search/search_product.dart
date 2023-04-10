import 'package:flutter/material.dart';
import 'package:shoesappclient/models/product_model.dart';

import 'package:shoesappclient/ui/general/brand_color.dart';

import 'package:shoesappclient/ui/widgets/item_search_widget.dart';

class SearchProduct extends SearchDelegate {
  List<ProductModel> products;

  SearchProduct({
    required this.products,
  });

  List<String> names = [
    "Elvis",
    "Daniel",
    "Julio",
    "Roberto",
    "María",
    "Diego",
    "Juan",
    "Melissa",
    "Wilson",
    "Eli",
    "Oliver",
  ];

  @override
  String get searchFieldLabel => "Buscar producto...";

  @override
  TextStyle get searchFieldStyle => TextStyle(
        fontSize: 16,
        color: BrandColor.primaryFontColor.withOpacity(0.80),
      );

  @override
  InputDecorationTheme get searchFieldDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withOpacity(0.04),
        hintStyle: TextStyle(
          fontSize: 14,
          color: BrandColor.primaryFontColor.withOpacity(0.6),
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
      );

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: BrandColor.primaryFontColor.withOpacity(0.8),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          fillColor: Colors.black.withOpacity(0.04),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ProductModel> result = products
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return ItemSearchWidget(model: result[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> suggestion = products
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestion.length,
      itemBuilder: (context, index) {
        return ItemSearchWidget(
          model: suggestion[index],
        );
      },
    );
  }
}
