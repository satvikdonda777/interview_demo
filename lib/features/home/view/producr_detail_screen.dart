import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_project/features/home/model/product_model.dart';
import 'package:practical_project/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Products product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black)),
          title: Text(
            widget.product.title ?? '',
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Stack(
                    children: [
                      PageView(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (value) {
                          homeProvider.onPageChange(value);
                        },
                        children: List.generate(widget.product.images!.length,
                            (index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey.shade300),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        widget.product.images![index]),
                                    fit: BoxFit.contain)),
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width,
                          );
                        }),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                widget.product.images!.length, (index) {
                              return Container(
                                height: 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                width: 8,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            homeProvider.currentIndex == index
                                                ? Colors.blue
                                                : Colors.grey.shade500),
                                    shape: BoxShape.circle,
                                    color: homeProvider.currentIndex == index
                                        ? Colors.blue
                                        : Colors.white),
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        widget.product.title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        child: Text(
                          widget.product.description ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.product.brand ?? '',
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
                            widget.product.price.toString(),
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
                        "₹${(widget.product.price! / (100 - (widget.product.discountPercentage ?? 0)) * 100).toStringAsFixed(2).toString()}",
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
                            widget.product.rating.toString(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.025,
                            left: 10,
                            right: 10),
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                            onPressed: () {
                              homeProvider.addToCart(widget.product);
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
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
