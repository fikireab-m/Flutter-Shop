import "package:fancy_shimmer_image/fancy_shimmer_image.dart";
import "package:flutter/material.dart";
import "package:flutter_iconly/flutter_iconly.dart";
import "package:flutter_shop/constants/colors.dart";
import "package:flutter_shop/models/cart.dart";
import "package:flutter_shop/models/product.dart";
import "package:flutter_shop/screens/product_details_screen.dart";
import "package:page_transition/page_transition.dart";
import "package:provider/provider.dart";

class ProductListView extends StatelessWidget {
  final List<Product> products;
  const ProductListView({super.key, required this.products});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        return SizedBox(
          width: 140,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: ProductDetails(product: products[i]),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: ColorConst.lightCardColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConst.lightBackgroundColor,
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: FancyShimmerImage(
                      height: 140,
                      width: double.infinity,
                      errorWidget: const Icon(
                        IconlyBold.danger,
                        color: Colors.red,
                        size: 28,
                      ),
                      imageUrl: products[i].images![0],
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      '${products[i].title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 4),
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
                                    text: '${products[i].price}',
                                    style: const TextStyle(
                                      color: ColorConst.lightTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CartModel>().addToCart(products[i]);
                          },
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
      },
      separatorBuilder: (context, i) {
        return const SizedBox(width: 12);
      },
      itemCount: products.length,
    );
  }
}
