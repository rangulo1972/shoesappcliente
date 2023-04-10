import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';
import 'package:shoesappclient/ui/pages/explore_page.dart';
import 'package:shoesappclient/ui/pages/home_page.dart';
import 'package:shoesappclient/ui/pages/marcas_page.dart';
import 'package:shoesappclient/ui/pages/profile_page.dart';
import 'package:shoesappclient/utils/asset_data.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int indexPage = 0;
  List<Widget> pages = [
    HomePage(),
    ExplorePage(),
    MarcasPage(),
    Center(
      child: Text("Favoritos"),
    ),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPage,
        onTap: (value) {
          indexPage = value;
          setState(() {});
        },
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedItemColor: BrandColor.primaryFontColor,
        unselectedItemColor: BrandColor.primaryFontColor.withOpacity(0.45),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconHome,
              height: 22,
              color: indexPage == 0
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconExplorer,
              height: 22,
              color: indexPage == 1
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Explorar",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconMarcas,
              height: 22,
              color: indexPage == 2
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Marcas",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconFavorito,
              height: 22,
              color: indexPage == 3
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetData.iconPerfil,
              height: 22,
              color: indexPage == 4
                  ? BrandColor.primaryFontColor
                  : BrandColor.primaryFontColor.withOpacity(0.45),
            ),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
