import 'package:flutter_test/flutter_test.dart';

import 'package:cafemate/data/repositories/order_repository.dart';
import 'package:cafemate/data/services/cafemate_service.dart';
import 'package:cafemate/domain/models/cafmate_order.dart';

void main() {
  test('setRemovedFromCart moves an order out of the cart and lowers the badge',
      () async {
    final repository = OrderRepository(CafeMateService());
    await repository.load();
    final order = repository.cartOrders.first;
    final badgeBefore = repository.pendingBadgeCount;

    var notifications = 0;
    repository.addListener(() => notifications++);

    repository.setRemovedFromCart(order.id, true);

    expect(notifications, 1);
    expect(repository.cartOrders, hasLength(badgeBefore - 1));
    expect(repository.cartOrders.any((item) => item.id == order.id), isFalse);
    expect(repository.removedOrders.single.id, order.id);
    expect(repository.removedOrders.single.isRemovedFromCart, isTrue);
    expect(repository.pendingBadgeCount, badgeBefore - 1);
  });

  test('setRemovedFromCart(false) restores the order to the cart', () async {
    final repository = OrderRepository(CafeMateService());
    await repository.load();
    final order = repository.cartOrders.first;
    final badgeBefore = repository.pendingBadgeCount;

    repository.setRemovedFromCart(order.id, true);
    repository.setRemovedFromCart(order.id, false);

    expect(repository.removedOrders, isEmpty);
    expect(repository.cartOrders.any((item) => item.id == order.id), isTrue);
    expect(repository.pendingBadgeCount, badgeBefore);
  });

  test('removing and restoring keeps the original order status', () async {
    final repository = OrderRepository(CafeMateService());
    await repository.load();
    final order = repository.cartOrders
        .firstWhere((item) => item.status == CafmateOrderStatus.locked);

    repository.setRemovedFromCart(order.id, true);
    expect(repository.removedOrders.single.status, CafmateOrderStatus.locked);

    repository.setRemovedFromCart(order.id, false);
    final restored =
        repository.cartOrders.firstWhere((item) => item.id == order.id);
    expect(restored.status, CafmateOrderStatus.locked);
  });

  test('concurrent load calls share one request', () async {
    final repository = OrderRepository(CafeMateService());

    await Future.wait([repository.load(), repository.load()]);

    expect(repository.cartOrders, hasLength(5));
  });
}
