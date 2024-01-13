import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:flutter_shop/widgets/search_box.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: shadowColor,
        title: const Text('All Products'),
      ),
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    SearchBox(controller: _textEditingController),
                    const SizedBox(height: 8),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 0.0,
                                mainAxisSpacing: 0.0,
                                childAspectRatio: 0.7),
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                            value: products[index],
                            child: const ProductsWidget(),
                          );
                        }),
                    if (_isLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
    );
  }
}
