import 'package:flutter/material.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:provider/provider.dart';

import '../widgets/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
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
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 4,
        title: const Text('All Products'),
      ),
      body: products.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
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
                            value: products[index], child: const FeedsWidget());
                      }),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
    );
  }
}
