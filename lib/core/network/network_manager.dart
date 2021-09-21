import 'package:dio/dio.dart';
import 'package:nestle_app/core/application/app_session.dart';
import 'package:nestle_app/core/base/model/base_model.dart';
import 'package:nestle_app/core/constants/base_settings.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager? get instance {
    if (_instance == null) {
      _instance = NetworkManager._init();
    }
    return _instance;
  }

  NetworkManager._init() {
    final baseOptions = BaseOptions(baseUrl: BaseSettings.BASE_API_URL);
    _dio = Dio(baseOptions);
  }

  setHeader() {
    Map<String, dynamic> headers = Map<String, dynamic>();

    if (AppSession.instance!.getAccessToken() != "") {
      headers["Authorization"] = "Bearer " + AppSession.instance!.getAccessToken();
      _dio!.options.headers = headers;
    }
  }

  setCustomHeader(String accessToken) {
    Map<String, dynamic> headers = Map<String, dynamic>();

    headers["Authorization"] = "Bearer " + accessToken;
    
    _dio!.options.headers = headers;
  }

  Dio? _dio;

  Future dioPost<T extends BaseModel<T>>(String path, T model, dynamic data) async {
    try {
      final response = await _dio!.post(path, data: data);
      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e)).toList();
        } else if (responseBody is Map<String, dynamic>) {
          return model.fromJson(responseBody);
        }
        return responseBody;
      }
    } on DioError catch (e) {
      print(e.message);
      return null;
    }
  }

  Future dioGet<T extends BaseModel<T>>(String path, T model) async {
    try {
      final response = await _dio!.get(path);
      if (response.statusCode == 200) {
        final responseBody = response.data;
        if (responseBody is List) {
          return responseBody.map((e) => model.fromJson(e)).toList();
        } else if (responseBody is Map<String, dynamic>) {
          return model.fromJson(responseBody);
        }
        return responseBody;
      }
    } on DioError catch (e) {
      print(e.message);
      return null;
    }
  }

  Future dioGetNoMode(String path) async {
    try {
      final response = await _dio!.get(path);
      if (response.statusCode == 200) {
        final responseBody = response.data;
        return responseBody;
      }
    } on DioError catch (e) {
      print(e.message);
      return null;
    }
  }
}
