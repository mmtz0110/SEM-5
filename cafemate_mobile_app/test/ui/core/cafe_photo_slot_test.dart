import 'package:cafemate/ui/core/cafe_photo_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows an honest placeholder when no photo asset is supplied',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CafePhotoSlot(label: 'Tambahkan foto cafe'),
        ),
      ),
    );

    expect(find.text('Tambahkan foto cafe'), findsOneWidget);
    expect(find.byIcon(Icons.add_a_photo_outlined), findsOneWidget);
  });
}
