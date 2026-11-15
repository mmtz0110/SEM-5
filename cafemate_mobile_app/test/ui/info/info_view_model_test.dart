import 'package:flutter_test/flutter_test.dart';

import 'package:cafemate/data/repositories/cafe_info_repository.dart';
import 'package:cafemate/data/services/cafemate_service.dart';
import 'package:cafemate/ui/info/info_view_model.dart';

void main() {
  InfoViewModel buildViewModel() =>
      InfoViewModel(CafeInfoRepository(CafeMateService()));

  test('InfoViewModel loads at least five CafeMate information items',
      () async {
    final viewModel = buildViewModel();

    await viewModel.load();

    expect(viewModel.isLoading, isFalse);
    expect(viewModel.error, isNull);
    expect(viewModel.items, hasLength(5));
    expect(viewModel.items.first.title, 'Promo kopi sore');
  });

  test('InfoViewModel filters items by query', () async {
    final viewModel = buildViewModel();

    await viewModel.load();
    viewModel.search('akhir pekan');

    expect(viewModel.filteredItems, hasLength(1));
    expect(viewModel.filteredItems.first.title, 'Jam buka akhir pekan');
  });
}
