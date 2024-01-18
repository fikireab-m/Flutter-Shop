import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/models/cart.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/products_screen.dart';
import 'package:flutter_shop/widgets/icon_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ShopingCart extends StatelessWidget {
  const ShopingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Product> cartItems = context.watch<CartModel>().getCartItems;
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
              itemCount: cartItems.length + 1,
              itemBuilder: (ctx, index) {
                return index < cartItems.length
                    ? Card(
                        color: lightScaffoldColor,
                        surfaceTintColor: lightScaffoldColor,
                        elevation: 8.0,
                        child: ListTile(
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
                          title: Text(
                            "${cartItems[index].title}",
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${cartItems[index].category!.name}"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AppIconBtn(
                                    function: () {},
                                    icon: Icons.remove_outlined,
                                  ),
                                  Container(
                                    width: 64,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: lightCardColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: const Text(
                                      "1",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  AppIconBtn(
                                    function: () {},
                                    icon: Icons.add_outlined,
                                  )
                                ],
                              )
                            ],
                          ),
                          isThreeLine: true,
                          trailing: Text(
                            "\$${cartItems[index].price}",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: lightIconsColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 24.0,
                                  ),
                                  foregroundColor: whiteTextColor),
                              icon: const Icon(
                                  Icons.shopping_cart_checkout_outlined),
                              label: const Text(
                                "Checkout",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
              }),
    );
  }
}
