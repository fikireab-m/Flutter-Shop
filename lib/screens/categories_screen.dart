import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_shop/consts/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
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
                      imageUrl: "https://placeimg.com/640/480/any",
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Category name",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        backgroundColor: lightCardColor.withOpacity(0.5),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
