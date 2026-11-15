import 'package:flutter/foundation.dart';

import '../../data/repositories/cafe_info_repository.dart';
import '../../domain/models/cafe_info.dart';

/// ViewModel fitur buatan sendiri: Kabar & promo cafe.
class InfoViewModel extends ChangeNotifier {
  InfoViewModel(this._repository);

  final CafeInfoRepository _repository;

  bool isLoading = false;
  String? error;
  List<CafeInfo> items = const [];
  String _query = '';

  List<CafeInfo> get filteredItems {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return items;
    return items
        .where((item) =>
            item.title.toLowerCase().contains(query) ||
            item.summary.toLowerCase().contains(query))
        .toList();
  }

  void search(String query) {
    _query = query;
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      items = await _repository.getInfo();
    } catch (exception) {
      error = exception.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
