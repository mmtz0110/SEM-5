import 'package:flutter_test/flutter_test.dart';

import 'package:cafemate/data/cafmate_store.dart';
import 'package:cafemate/domain/models/cafmate_order.dart';

void main() {
  test('cancelling an order marks it cancelled without waste routing', () {
    final store = CafmateStore();
    final order = store.orders.first;

    store.cancelOrder(order);

    expect(store.orders.first.status, CafmateOrderStatus.cancelled);
    expect(store.reliabilityScore, 78);
  });
}
