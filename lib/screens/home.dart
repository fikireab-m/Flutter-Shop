import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/screens/categories_screen.dart';
import 'package:flutter_shop/screens/products_screen.dart';
import 'package:flutter_shop/widgets/page_layout.dart';
import 'package:flutter_shop/widgets/sale_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
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

  @override
  void didChangeDependencies() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Navigator.of(context).push(
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const ProductsScreen(),
          ),
        );
      }
    });
    super.didChangeDependencies();
  }

  List<Product> cartItems = [];
  @override
  Widget build(BuildContext context) {
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
                  type: PageTransitionType.leftToRightWithFade,
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
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ShopingCart(cartItems: cartItems),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout_outlined),
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<Product>>(
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
              return PageLayout(
                products: products,
                bgWidget: SizedBox(
                  child: Swiper(
                    itemCount: 3,
                    itemBuilder: (context, index) {
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
                scrollController: _scrollController,
              );
            }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
              type: PageTransitionType.bottomToTop,
              child: const ProductsScreen(),
            ));
          },
          label: const Text("View all products"),
          icon: const Icon(Icons.arrow_forward),
          backgroundColor: lightCardColor,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      ),
    );
  }
}
