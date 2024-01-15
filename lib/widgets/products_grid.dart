import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/widgets/product_widget.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: sc.width ~/ 180,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: const ProductsWidget(),
          );
        });
  }
}
