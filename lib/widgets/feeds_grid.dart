import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';

import 'feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  final List<Product> products;
  const FeedsGridWidget({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 0.6),
        itemBuilder: (ctx, index) {
          return FeedsWidget(
            product: products[index],
          );
        });
  }
}
