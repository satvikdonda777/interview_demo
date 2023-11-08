import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_project/config/extension/extension.dart';
import 'package:practical_project/features/home/model/product_model.dart';
import 'package:practical_project/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, HomeProvider homeProvider, child) {
      return homeProvider.cartList.isEmpty
          ? const Expanded(child: Center(child: Text("Cart is empty")))
          : Expanded(
              child: ListView.builder(
                itemCount: homeProvider.cartList.length,
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                itemBuilder: (context, index) {
                  Products products = homeProvider.cartList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade100.withOpacity(0.1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10)),
                            child: CachedNetworkImage(
                              imageUrl: homeProvider.cartList[index].thumbnail!,
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.hPr(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 4.0,
                            right: 4.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products.title ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
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
                                        fontSize: 8),
                                  ),
                                  Text(
                                    products.price.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.hPr(context)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100.wPr(context),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    height: 33,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            homeProvider
                                                .removeFromCart(products);
                                          },
                                          child: Container(
                                              width: 30.wPr(context),
                                              height: 30.hPr(context),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      const BorderRadius
                                                          .horizontal(
                                                          left: Radius.circular(
                                                              10))),
                                              child: products.quantity == 1
                                                  ? const Icon(
                                                      CupertinoIcons.delete,
                                                      size: 15,
                                                    )
                                                  : const Center(
                                                      child: Text(
                                                      '-',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ))),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              products.quantity.toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            homeProvider.addToCart(products);
                                          },
                                          child: Container(
                                            width: 30.wPr(context),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                right: Radius.circular(10),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '+',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      homeProvider.deleteFromCart(products);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey.shade400)),
                                      child: const Text("Delete"),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: 'Total price : ',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        text: (products.price! *
                                                products.quantity!)
                                            .toString(),
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
    });
  }
}
