import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class PageLayout extends StatelessWidget {
  final double? extentHeight;
  final Widget? appBarTitle;
  final Widget? leading;
  final List<Widget>? appbarActions;
  final ScrollController scrollController;
  final Widget bgWidget;
  final List<Product> products;
  const PageLayout({
    super.key,
    this.appBarTitle,
    required this.products,
    this.leading,
    required this.bgWidget,
    required this.scrollController,
    this.extentHeight,
    this.appbarActions,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: extentHeight ?? constraints.maxHeight / 3,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: leading,
            actions: appbarActions,
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
