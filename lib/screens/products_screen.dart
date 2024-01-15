import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/widgets/icon_button.dart';
import 'package:flutter_shop/widgets/page_layout.dart';
import 'package:flutter_shop/widgets/products_grid.dart';
import 'package:flutter_shop/widgets/search_box.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../widgets/product_widget.dart';

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
  bool _isLoading = false;
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
        _isLoading = true;
        limit += 10;
        await getProducts();
        _isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    final sc = MediaQuery.of(context).size;
    return Scaffold(
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageLayout(
              products: products,
              bgWidget: Column(
                children: [
                  const Expanded(child: SizedBox()),
                  SearchBox(controller: _textEditingController),
                ],
              ),
              scrollController: _scrollController,
              extentHeight: 160.0,
              appBarTitle: const Text('All Products'),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
              appbarActions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const ShopingCart(cartItems: []),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_checkout_outlined),
                  ),
                ),
              ],
            ),
    );
  }
}
