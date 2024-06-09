import 'dart:io';
import 'package:dio/dio.dart';
import 'package:project_train/core/model/work_model.dart';

part '../abstract/network_cache_manager.dart';

final class NetworkService extends NetworkCacheManager {
  NetworkService(super.dio);

  @override
  Future<Map<String, dynamic>?> login({required Map<String, dynamic> userData}) async {
    final response = await _dio.post(_login, data: userData);
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is Map<String, dynamic>) return response.data;
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> backupData({required Map<String, dynamic> data}) async {
    final response = await _dio.post(_backup, data: data);
    if (response.statusCode == HttpStatus.ok) {
      if (response.data is Map<String, dynamic>) return response.data;
    }
    return null;
  }

  @override
  Future<List<WorkModel>?> fetchData({required Map<String, dynamic> data}) async {
    final response = await _dio.post(_fetchData, data: data);
    print(response);
    if (response.statusCode == HttpStatus.ok) {
      final responses = response.data;
      if (responses is List) return responses.map((e) => WorkModel.fromJson(e)).toList();
    }
    return null;
  }

}