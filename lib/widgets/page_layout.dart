import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/products_screen.dart';
import 'package:flutter_shop/widgets/product_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PageLayout extends StatelessWidget {
  final double? extentHeight;
  final Widget? appBarTitle;
  final Widget? leading;
  final List<Widget>? appbarActions;
  final ScrollController? scrollController;
  final Widget bgWidget;
  final List<Product> products;
  const PageLayout({
    super.key,
    this.appBarTitle,
    required this.products,
    this.leading,
    required this.bgWidget,
    this.scrollController,
    this.extentHeight,
    this.appbarActions,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return CustomScrollView(
        controller: scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: false,
            expandedHeight: extentHeight ?? 488,
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: leading,
            actions: appbarActions,
            titleTextStyle: const TextStyle(color: ColorConst.lightTextColor),
            flexibleSpace: FlexibleSpaceBar(
              title: appBarTitle,
              background: bgWidget,
            ),
          ),
          SliverList.list(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular Products",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: const ProductsScreen(),
                              ),
                            ),
                        child: const Text(
                          "View All",
                          style: TextStyle(fontSize: 18.0),
                        ))
                  ],
                ),
              ),
            ],
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth ~/ 180,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              childAspectRatio:
                  constraints.maxWidth / constraints.maxHeight + 0.21,
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
