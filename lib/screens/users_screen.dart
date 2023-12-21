import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text("Users")),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: FancyShimmerImage(
                  height: size.width * 0.15,
                  width: size.width * 0.15,
                  errorWidget: const Icon(
                    IconlyBold.danger,
                    color: Colors.red,
                    size: 28,
                  ),
                  imageUrl: "https://placeimg.com/640/480/any",
                  boxFit: BoxFit.fill,
                ),
                title: const Text("User name"),
                subtitle: const Text("Email@email.com"),
                trailing: Text(
                  "User role",
                  style: TextStyle(
                    color: lightIconsColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }));
  }
}
