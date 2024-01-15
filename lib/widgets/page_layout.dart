import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class PageLayout extends StatelessWidget {
  final Widget? appBarTitle;
  final Widget? leading;
  final Widget bgWidget;
  final List<Product> products;
  const PageLayout({
    super.key,
    this.appBarTitle,
    required this.products,
    this.leading,
    required this.bgWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: constraints.maxHeight / 3,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: leading,
            flexibleSpace: FlexibleSpaceBar(
              title: appBarTitle,
              background: bgWidget,
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth ~/ 180,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ChangeNotifierProvider.value(
                  value: products[index],
                  child: const ProductsWidget(),
                );
              },
              childCount: products.length,
            ),
          ),
        ],
      );
    });
  }
}
