import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/constants/paths.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/widgets/page_layout.dart';
import 'package:flutter_shop/widgets/search_box.dart';
import 'package:page_transition/page_transition.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<ProductsScreen> {
  final ScrollController _scrollController = ScrollController();
  late TextEditingController _textEditingController;
  List<Product> products = [];
  int limit = 10;
  Future<void> getProducts() async {
    products = await APIHandler.getProducts(
      limit: limit.toString(),
    );
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        limit += 10;
        await getProducts();
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    getProducts();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  List<Product> cartItems = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          shadowColor: shadowColor,
          centerTitle: false,
          title: const Text('Products'),
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
        body: products.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PageLayout(
                products: products,
                extentHeight: 120,
                bgWidget: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.bgImg),
                      // opacity: 0.5,
                      colorFilter: ColorFilter.srgbToLinearGamma(),
                      opacity: 0.6,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 16.0,
                      ),
                      child: SearchBox(controller: _textEditingController),
                    ),
                  ),
                ),
                scrollController: _scrollController,
              ),
      ),
    );
  }
}
