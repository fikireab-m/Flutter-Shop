import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';

class SearchBox extends StatelessWidget {
  final TextEditingController controller;
  const SearchBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.0,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: "Search",
            filled: true,
            fillColor: ColorConst.lightCardColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                color: Theme.of(context).cardColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            suffixIcon: const Icon(
              IconlyLight.search,
              color: ColorConst.lightIconsColor,
            )),
      ),
    );
  }
}
