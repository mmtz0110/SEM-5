import '../../domain/models/cafe_info.dart';
import '../services/cafemate_service.dart';

class CafeInfoRepository {
  CafeInfoRepository(this._service);
  final CafeMateService _service;

  Future<List<CafeInfo>> getInfo() => _service.fetchInfo();
}
