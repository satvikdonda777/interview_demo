import 'package:flutter/material.dart';
import 'package:practical_project/features/home/model/product_model.dart';

import '../repository/home_repository.dart';

class HomeProvider extends ChangeNotifier {
  List<Products> productList = [];
  List<Products> tempList = [];
  List<Products> cartList = [];
  List<String> categoryList = ["All"];
  int selectedCategoryIndex = 0;
  bool isCartIsOpen = false;
  int currentIndex = 0;

  /// Change current index
  void onPageChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  ///Get product list by category
  void selectCategory(int index) {
    selectedCategoryIndex = index;
    if (selectedCategoryIndex == 0) {
      productList.clear();
      productList.addAll(tempList);
    } else {
      productList.clear();
      for (int i = 0; i < tempList.length; i++) {
        if (tempList[i].category == categoryList[index]) {
          productList.add(tempList[i]);
        }
      }
    }
    notifyListeners();
  }

  /// Toggle cart
  void toggleCart() {
    isCartIsOpen = !isCartIsOpen;
    notifyListeners();
  }

  /// Add product to cart
  void addToCart(Products product) {
    isCartIsOpen = true;
    if (cartList.isEmpty) {
      product = product.copyWith(quantity: 1);
      cartList.add(product);
    } else {
      int index = cartList.indexWhere((element) => element.id == product.id);
      if (index != -1) {
        cartList[index] = cartList[index].copyWith(
          quantity: cartList[index].quantity! + 1,
        );
        notifyListeners();
      } else {
        product = product.copyWith(quantity: 1);
        cartList.add(product);
      }
    }
    notifyListeners();
  }

  /// Remove product from cart
  void removeFromCart(Products product) {
    int index = cartList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      if (cartList[index].quantity! > 1) {
        cartList[index] =
            cartList[index].copyWith(quantity: cartList[index].quantity! - 1);
      } else {
        cartList.removeAt(index);
      }
    }
    notifyListeners();
  }

  /// Delete product from cart
  void deleteFromCart(Products product) {
    int index = cartList.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      cartList[index] = cartList[index].copyWith(quantity: 0);
      cartList.removeAt(index);
    }
    notifyListeners();
  }

  /// Fetch all products
  Future<void> getAllProducts(BuildContext context) async {
    try {
      ProductModel? productModel =
          await HomeRepository().getAllProducts(context);

      if (productModel != null && productModel.products != null) {
        productList.clear();
        tempList.clear();
        productList.addAll(productModel.products!);
        tempList.addAll(productList);

        for (int i = 0; i < productList.length; i++) {
          if (!categoryList.contains(productList[i].category)) {
            categoryList.add(productList[i].category ?? '');
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    notifyListeners();
  }
}
