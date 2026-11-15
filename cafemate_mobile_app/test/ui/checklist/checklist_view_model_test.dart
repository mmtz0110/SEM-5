import 'package:flutter_test/flutter_test.dart';

import 'package:cafemate/data/repositories/order_repository.dart';
import 'package:cafemate/data/repositories/product_repository.dart';
import 'package:cafemate/data/services/cafemate_service.dart';
import 'package:cafemate/ui/checklist/checklist_view_model.dart';
import 'package:cafemate/ui/home/home_view_model.dart';

void main() {
  late OrderRepository repository;
  late ChecklistViewModel checklistViewModel;
  late HomeViewModel homeViewModel;

  setUp(() {
    final service = CafeMateService();
    repository = OrderRepository(service);
    checklistViewModel = ChecklistViewModel(repository);
    homeViewModel = HomeViewModel(ProductRepository(service), repository);
  });

  tearDown(() {
    checklistViewModel.dispose();
    homeViewModel.dispose();
    repository.dispose();
  });

  test('checking an order moves it to Selesai, out of Beranda, and lowers badge',
      () async {
    await checklistViewModel.load();
    await homeViewModel.load();

    final order = checklistViewModel.cartOrders.first;
    final badgeBefore = checklistViewModel.pendingCount;
    final berandaBefore = homeViewModel.pendingCartOrders.length;

    expect(berandaBefore, badgeBefore);

    checklistViewModel.setRemoved(order, true);

    // Pindah ke bagian Selesai di halaman Checklist.
    expect(
      checklistViewModel.removedOrders.map((item) => item.id),
      contains(order.id),
    );
    // Hilang dari daftar keranjang.
    expect(
      checklistViewModel.cartOrders.any((item) => item.id == order.id),
      isFalse,
    );
    // Hilang dari daftar keranjang di Beranda.
    expect(
      homeViewModel.pendingCartOrders.any((item) => item.id == order.id),
      isFalse,
    );
    expect(homeViewModel.pendingCartOrders, hasLength(berandaBefore - 1));
    // Badge tab Checklist berkurang.
    expect(checklistViewModel.pendingCount, badgeBefore - 1);
    expect(repository.pendingBadgeCount, badgeBefore - 1);
  });

  test('Beranda is notified when the action repository changes', () async {
    await homeViewModel.load();
    var notifications = 0;
    homeViewModel.addListener(() => notifications++);
    final order = homeViewModel.pendingCartOrders.first;

    checklistViewModel.setRemoved(order, true);

    expect(notifications, greaterThan(0));
    expect(
      homeViewModel.pendingCartOrders.any((item) => item.id == order.id),
      isFalse,
    );
  });

  test('unchecking an order returns it to the cart and the badge grows', () async {
    await checklistViewModel.load();
    final order = checklistViewModel.cartOrders.first;
    final badgeBefore = checklistViewModel.pendingCount;

    checklistViewModel.setRemoved(order, true);
    checklistViewModel.setRemoved(order, false);

    expect(checklistViewModel.removedOrders, isEmpty);
    expect(
      checklistViewModel.cartOrders.any((item) => item.id == order.id),
      isTrue,
    );
    expect(checklistViewModel.pendingCount, badgeBefore);
  });
}
