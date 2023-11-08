import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_project/config/extension/extension.dart';
import 'package:practical_project/config/routes/route_config.dart';
import 'package:practical_project/features/home/model/product_model.dart';
import 'package:practical_project/features/home/view/cart_screen.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  context.read<HomeProvider>().toggleCart();
                },
                icon: const Icon(
                  CupertinoIcons.cart,
                  color: Colors.black,
                ))
          ],
          title: const Text(
            "Shopping App",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
        return SafeArea(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: homeProvider.isCartIsOpen
                        ? const Border(
                            right: BorderSide(color: Colors.black),
                          )
                        : null,
                  ),
                  child: SizedBox(
                    width: homeProvider.isCartIsOpen
                        ? constraints.maxWidth / 1.5
                        : constraints.maxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                                homeProvider.categoryList.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    homeProvider.selectCategory(index);
                                  },
                                  child: Chip(
                                      backgroundColor:
                                          homeProvider.selectedCategoryIndex ==
                                                  index
                                              ? const Color(0xFF129575)
                                              : Colors.grey.shade300,
                                      label: Text(
                                        homeProvider.categoryList[index],
                                        style: TextStyle(
                                          color: homeProvider
                                                      .selectedCategoryIndex ==
                                                  index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      )),
                                ),
                              );
                            }),
                          ),
                        ),
                        if (homeProvider.productList.isNotEmpty) ...{
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Wrap(
                                  children: homeProvider.productList
                                      .map(
                                        (e) => GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  RouteConfig
                                                      .productDetailScreen,
                                                  arguments: e);
                                            },
                                            child:
                                                productCard(e, homeProvider)),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ),
                        } else ...{
                          const Expanded(
                            child: Center(
                              child: Text("No products found"),
                            ),
                          )
                        }
                      ],
                    ),
                  ),
                ),
                if (homeProvider.isCartIsOpen) ...{const CartScreen()}
              ],
            );
          }),
        );
      }),
    );
  }

  Widget productCard(Products products, HomeProvider homeProvider) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = (MediaQuery.sizeOf(context).width - 32) / 3 - 30;
      double height = 320;

      if (constraints.maxWidth > 710.7) {
        height = 200.hPr(context);
      }
      return Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.9,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: products.thumbnail ?? '',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    products.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    products.brand ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "₹",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      Text(
                        products.price.toString(),
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹${(products.price! / (100 - (products.discountPercentage ?? 0)) * 100).toStringAsFixed(2).toString()}",
                    style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        products.rating.toString(),
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.yellow.shade700,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.025,
                  left: 10,
                  right: 10),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    homeProvider.addToCart(products);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade700,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ),
      );
    });
  }
}
