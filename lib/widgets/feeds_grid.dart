import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:provider/provider.dart';

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
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: products[index],
            child: const FeedsWidget(),
          );
        });
  }
}
