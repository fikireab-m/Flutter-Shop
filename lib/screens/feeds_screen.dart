import 'package:flutter/material.dart';
import 'package:flutter_shop/models/product.dart';

import '../widgets/feeds_widget.dart';

class FeedsScreen extends StatelessWidget {
  final List<Product> products;
  const FeedsScreen({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 4,
        title: const Text('All Products'),
      ),
      body: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 0.7),
          itemBuilder: (ctx, index) {
            return FeedsWidget(
              product: products[index],
            );
          }),
    );
  }
}
