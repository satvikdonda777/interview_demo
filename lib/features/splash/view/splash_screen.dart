import 'package:flutter/material.dart';
import 'package:practical_project/features/home/provider/home_provider.dart';
import 'package:practical_project/widgets/dialogs/dialogs.dart';
import 'package:provider/provider.dart';

import '../../../config/routes/route_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DialogUtility.loadingDialog(context);
      await context.read<HomeProvider>().getAllProducts(context);
      Navigator.pushNamedAndRemoveUntil(
          context, RouteConfig.homeScreen, (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Shopping App",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.0746,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
