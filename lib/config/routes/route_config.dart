import 'package:flutter/material.dart';
import 'package:practical_project/features/home/view/producr_detail_screen.dart';

import '../../features/home/model/product_model.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/splash/view/splash_screen.dart';

class RouteConfig {
  /// first screen to open in the application.
  static const String root = '/';

  /// splash screen.
  static const String splashScreen = '/splashScreen';

  /// Home screen
  static const String homeScreen = '/homeScreen';

  /// Product detail screen
  static const String productDetailScreen = '/productDetailScreen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    String routeName = settings.name ?? RouteConfig.root;
    switch (routeName) {
      case RouteConfig.root:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case RouteConfig.homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      case RouteConfig.productDetailScreen:
        return MaterialPageRoute(
          builder: (context) {
            Products product = settings.arguments as Products;
            return ProductDetailScreen(
              product: product,
            );
          },
        );
    }
    return null;
  }
}
