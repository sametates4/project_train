part of '../service/network_service.dart';

abstract class NetworkCacheManager {
  late final Dio _dio;

  NetworkCacheManager(Dio dio) {
    _dio = dio;
  }

  final _login = "/login";
  final _backup = "/insertData";
  final _fetchData = "/getUserData";

  Future<Map<String, dynamic>?> login({required Map<String, dynamic> userData});

  Future<Map<String, dynamic>?> backupData({required Map<String, dynamic> data});

  Future<List<WorkModel>?> fetchData({required Map<String, dynamic> data});
}
