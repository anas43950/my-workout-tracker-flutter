import 'dart:io';

import 'package:dio/dio.dart';
import 'package:workout_tracker/data/api/endpoints.dart';
import 'package:workout_tracker/router.dart';
import 'package:workout_tracker/utils/constants.dart';
import 'package:workout_tracker/utils/extensions.dart';
import 'package:workout_tracker/utils/network_request_interseptor.dart';
import 'package:workout_tracker/utils/shared_preferences_utils.dart';

class ApiService {
  ApiService._();

  static final Dio _dio = Dio()
    ..interceptors.addAll([
      NetworkRequestInterceptor(),
    ]);

  static Map<String, dynamic> headers() {
    final token = SharedPrefUtils.getString(AppStrings.token);
    return {
      if (token != null) "Authorization": "Bearer $token",
      "Accept": "application/json",
    };
  }

  static void _handleUnauthenticated() async {
    await SharedPrefUtils.clear();
    Constants.navigatorKey.currentContext!.clearStackAndNavigate(Routes.login);
  }

  static Future<Map<String, dynamic>> post({
    required String endpoint,
    dynamic parameter,
    Options? options,
  }) async {
    try {
      late FormData formData;

      if (parameter is Map<String, dynamic>) {
        Map<String, dynamic> formMap = {};

        parameter.forEach((key, value) {
          if (value is File) {
            formMap[key] = MultipartFile.fromFileSync(value.path, filename: value.path.split('/').last);
          } else if (value is List<File>) {
            formMap[key] = value
                .map((file) => MultipartFile.fromFileSync(file.path, filename: file.path.split('/').last))
                .toList();
          } else {
            formMap[key] = value;
          }
        });

        formData = FormData.fromMap(formMap, ListFormat.multiCompatible);
      } else {
        throw ArgumentError('Invalid parameter type. Expected Map<String, dynamic>.');
      }

      final response = await _dio.post(
        ApiEndpoints.baseUrl + endpoint,
        data: formData,
        options: Options(contentType: "multipart/form-data", headers: headers()),
      );

      var resp = response.data;
      if (resp['errors'] ?? false) {
        throw ApiException(resp['message'].toString());
      }

      return Map.from(resp);
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 401) {
        _handleUnauthenticated();
      }

      if (e.response?.statusCode == 422) {
        final result = e.response?.data;
        throw ValidationException(result['message']);
      }
      if (e.response?.statusCode == 503) {
        throw "server-not-available";
      }

      throw ApiException(
        e.error is SocketException ? "no-internet" : "Something went wrong with error ${e.response?.statusCode}",
      );
    } on ApiException catch (e) {
      throw ApiException(e.errorMessage);
    } on ValidationException catch (e) {
      throw ValidationException(e.errorMessage);
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  static Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    bool? useBaseUrl,
    bool addContentLanguage = true,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.baseUrl + endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers()),
      );

      if (response.data['error'] == true) {
        throw ApiException(response.data['message'].toString());
      }
      return Map.from(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        _handleUnauthenticated();
      }
      if (e.response?.statusCode == 503) {
        throw "server-not-available";
      }
      throw ApiException(
        e.error is SocketException ? "no-internet" : "Something went wrong with error ${e.response?.statusCode}",
      );
    } on ApiException catch (e) {
      throw ApiException(e.errorMessage);
    } catch (e, st) {
      throw ApiException(st.toString());
    }
  }
}

class ApiException implements Exception {
  ApiException(this.errorMessage);

  dynamic errorMessage;

  @override
  String toString() {
    return errorMessage.toString();
  }
}

class ValidationException implements Exception {
  String errorMessage;

  ValidationException(this.errorMessage);

  @override
  String toString() {
    return errorMessage.toString();
  }
}
