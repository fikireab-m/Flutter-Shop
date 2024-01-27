import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/cart.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/screens/categories_screen.dart';
import 'package:flutter_shop/screens/product_details_screen.dart';
import 'package:flutter_shop/screens/products_screen.dart';
import 'package:flutter_shop/widgets/horizontal_scroll.dart';
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
  final ScrollController _scrollController = ScrollController();
  Future<List<Product>> getProducts() async {
    final products = await APIHandler.getProducts(limit: "10");
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
          shadowColor: ColorConst.shadowColor,
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
                      child: const ShopingCart(),
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 220,
                      child: Swiper(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const SaleWidget();
                        },
                        autoplay: true,
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                            color: ColorConst.whiteTextColor,
                            activeColor: ColorConst.lightIconsColor,
                          ),
                        ),
                        // control: const SwiperControl(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Latest Products",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: 221.0,
                        child: ProductListView(products: products),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Popular Products",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                                onPressed: () => Navigator.of(context).push(
                                      PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: const ProductsScreen(),
                                      ),
                                    ),
                                child: const Text(
                                  "View All",
                                  style: TextStyle(fontSize: 18.0),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 140,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(products.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: ProductDetails(
                                          product: products[index]),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: ColorConst.lightCardColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              ColorConst.lightBackgroundColor,
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0,
                                          offset: Offset(2.0, 2.0),
                                        )
                                      ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: FancyShimmerImage(
                                          height: 100,
                                          width: double.infinity,
                                          errorWidget: const Icon(
                                            IconlyBold.danger,
                                            color: Colors.red,
                                            size: 28,
                                          ),
                                          imageUrl: products[index].images![0],
                                          boxFit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Text(
                                          '${products[index].title}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8, bottom: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: RichText(
                                                text: TextSpan(
                                                    text: '\$',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          33, 150, 243, 1),
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '${products[index].price}',
                                                        style: const TextStyle(
                                                          color: ColorConst
                                                              .lightTextColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                context
                                                    .read<CartModel>()
                                                    .addToCart(products[index]);
                                              },
                                              icon: const Icon(Icons
                                                  .add_shopping_cart_outlined),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
