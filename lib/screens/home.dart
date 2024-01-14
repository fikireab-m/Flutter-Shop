import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/screens/categories_screen.dart';
import 'package:flutter_shop/screens/products_screen.dart';
import 'package:flutter_shop/widgets/appbar_icons.dart';
import 'package:flutter_shop/widgets/product_widget.dart';
import 'package:flutter_shop/widgets/products_grid.dart';
import 'package:flutter_shop/widgets/sale_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Product>> getProducts() async {
    final products = await APIHandler.getProducts(limit: "4");
    return products;
  }

  @override
  void initState() {
    getProducts();
    setState(() {});
    super.initState();
  }

  List<Product> cartItems = [];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          shadowColor: shadowColor,
          centerTitle: false,
          title: const Text('Home'),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const CategoriesScreen(),
                ),
              );
            },
            icon: const Icon(Icons.category_outlined),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: ShopingCart(cartItems: cartItems),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout_outlined),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Product>>(
              future: getProducts(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                final products = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (ctx, index) {
                            return const SaleWidget();
                          },
                          autoplay: true,
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.white,
                              activeColor: Colors.red,
                            ),
                          ),
                          // control: const SwiperControl(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Show all products",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                              ),
                            ),
                            const Spacer(),
                            AppIconBtn(
                              function: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const ProductsScreen(),
                                  ),
                                );
                              },
                              icon: IconlyBold.arrowRight2,
                            ),
                          ],
                        ),
                      ),
                      ProductGrid(products: products),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
