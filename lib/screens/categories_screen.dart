import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future<List<Category>> getCategories() async {
    final categories = await APIHandler.getCategories();
    return categories;
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: FutureBuilder<List<Category>>(
          future: getCategories(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final categories = snapshot.data!;
            return GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FancyShimmerImage(
                            height: size.width * 0.45,
                            width: size.width * 0.45,
                            errorWidget: const Icon(
                              IconlyBold.danger,
                              color: Colors.red,
                              size: 28,
                            ),
                            imageUrl: categories[index].image ?? "",
                            boxFit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: size.width * 0.45,
                            decoration: BoxDecoration(
                                color: const Color(0xFF000000).withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(4.0),
                                  bottomRight: Radius.circular(4.0),
                                )),
                            child: Text(
                              categories[index].name ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: whiteTextColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
