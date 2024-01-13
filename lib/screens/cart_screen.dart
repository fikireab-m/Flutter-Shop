import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/products_screen.dart';
import 'package:page_transition/page_transition.dart';

class ShopingCart extends StatelessWidget {
  final List<Product> cartItems;
  const ShopingCart({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Cart Items")),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: shadowColor,
                    size: 128,
                  ),
                  const Text(
                    "You didn't add any product",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const ProductsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Goto products",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: FancyShimmerImage(
                    height: size.width * 0.15,
                    width: size.width * 0.15,
                    errorWidget: const Icon(
                      IconlyBold.danger,
                      color: Colors.red,
                      size: 28,
                    ),
                    imageUrl: cartItems[index].images![0],
                    boxFit: BoxFit.fill,
                  ),
                  title: Text("${cartItems[index].title}"),
                  subtitle: Text("${cartItems[index].category}"),
                  trailing: Text(
                    "${cartItems[index].price}",
                    style: TextStyle(
                      color: lightIconsColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
    );
  }
}
