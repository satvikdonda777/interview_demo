import 'package:provider/provider.dart';

import '../../features/home/provider/home_provider.dart';

class Providers {
  static List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
    ),
  ];
}
