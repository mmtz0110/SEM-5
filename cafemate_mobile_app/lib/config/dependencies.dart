import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/cafe_info_repository.dart';
import '../data/repositories/order_repository.dart';
import '../data/repositories/product_repository.dart';
import '../data/services/cafemate_service.dart';
import '../ui/catalog/catalog_view_model.dart';
import '../ui/checklist/checklist_view_model.dart';
import '../ui/home/home_view_model.dart';
import '../ui/info/info_view_model.dart';

/// Semua Service, Repository, dan ViewModel didaftarkan di sini.
List<SingleChildWidget> buildDependencies() {
  return [
    Provider<CafeMateService>(create: (_) => CafeMateService()),
    Provider<ProductRepository>(
      create: (context) => ProductRepository(context.read<CafeMateService>()),
    ),
    ChangeNotifierProvider<OrderRepository>(
      create: (context) => OrderRepository(context.read<CafeMateService>()),
    ),
    Provider<CafeInfoRepository>(
      create: (context) => CafeInfoRepository(context.read<CafeMateService>()),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        context.read<ProductRepository>(),
        context.read<OrderRepository>(),
      ),
    ),
    ChangeNotifierProvider<CatalogViewModel>(
      create: (context) => CatalogViewModel(
        context.read<ProductRepository>(),
        context.read<OrderRepository>(),
      ),
    ),
    ChangeNotifierProvider<ChecklistViewModel>(
      create: (context) =>
          ChecklistViewModel(context.read<OrderRepository>()),
    ),
    ChangeNotifierProvider<InfoViewModel>(
      create: (context) =>
          InfoViewModel(context.read<CafeInfoRepository>()),
    ),
  ];
}
