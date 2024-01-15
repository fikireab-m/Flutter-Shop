import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/product_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: ProductDetails(product: product),
                    ),
                  );
                },
                child: FancyShimmerImage(
                  height: 180,
                  width: double.infinity,
                  errorWidget: const Icon(
                    IconlyBold.danger,
                    color: Colors.red,
                    size: 28,
                  ),
                  imageUrl: product.images![0],
                  boxFit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Text(
                  '${product.title}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: '\$',
                            style: const TextStyle(
                              color: Color.fromRGBO(33, 150, 243, 1),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${product.price}',
                                style: TextStyle(
                                  color: lightTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
