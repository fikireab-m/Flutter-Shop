import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/models/cart.dart';
import 'package:flutter_shop/models/product.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              const BackButton(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.category!.name}.',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Text(
                            '${product.title}',
                            textAlign: TextAlign.start,
                            style: titleStyle,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: RichText(
                            text: TextSpan(
                                text: '\$',
                                style: const TextStyle(
                                    fontSize: 25,
                                    color: Color.fromRGBO(33, 150, 243, 1)),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${product.price}',
                                      style: const TextStyle(
                                          color: ColorConst.lightTextColor,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.4,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return FancyShimmerImage(
                      width: double.infinity,
                      imageUrl: product.images![index],
                      boxFit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: product.images!.length,
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
              const SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Description', style: titleStyle),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      '${product.description}',
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<CartModel>().addToCart(product);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConst.lightIconsColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 24.0,
                          ),
                          foregroundColor: ColorConst.whiteTextColor),
                      icon: const Icon(Icons.add_shopping_cart_outlined),
                      label: const Text(
                        "Add To Cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
