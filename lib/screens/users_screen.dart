import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_shop/constants/colors.dart';
import 'package:flutter_shop/data/api_call.dart';
import 'package:flutter_shop/models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Future<List<User>> getUsers() async {
    final users = await APIHandler.getUsers();
    return users;
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: const Text("Users")),
        body: FutureBuilder<List<User>>(
            future: getUsers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final users = snapshot.data!;
              return ListView.builder(
                  itemCount: users.length,
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
                        imageUrl: users[index].avatar!,
                        boxFit: BoxFit.fill,
                      ),
                      title: Text("${users[index].name}"),
                      subtitle: Text("${users[index].email}"),
                      trailing: Text(
                        "${users[index].role}",
                        style: TextStyle(
                          color: lightIconsColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  });
            }));
  }
}
