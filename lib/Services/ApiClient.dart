import 'dart:io';
import 'package:crmnir/Services/AuthServices.dart';
import 'package:crmnir/Services/LocalStorage.dart';
import 'package:crmnir/utilities/Api.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache_lts/dio_http_cache_lts.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  String host = Api.baseUrl;
  BaseOptions? baseOptions;
  Dio? dio;
  SharedPreferences? prefs;

  Future<Map<String, String>> getHeaders() async {
    final userToken = await AuthServices.getAuthBearerToken();
      print("userToken: $userToken");
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $userToken",
    };
  }

  HttpService() {
    LocalStorageService.getPrefs();

    baseOptions = BaseOptions(
      baseUrl: host,
      validateStatus: (status) {
        return status != null && status <= 500;
      },
      // connectTimeout: 300,
    );
    dio = Dio(baseOptions);
    dio!.interceptors.add(getCacheManager().interceptor);
  }


  DioCacheManager getCacheManager() {
    return DioCacheManager(
      CacheConfig(
        baseUrl: host,
        defaultMaxAge: Duration(days: 7),
      ),
    );
  }

  //for get api calls
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";

    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
            headers: await getHeaders(),
          );

    Response response;

    try {
      response = await dio!.get(
        uri,
        options: mOptions,
        queryParameters: queryParameters,
      );
    } on DioException catch (error) {
      response = formatDioExecption(error);
    }

    return response;
  }

  //for post api calls
  Future<Response> post(
    String url,
    body, {
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";

    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
            headers: await getHeaders(),
          );

    Response response;
    try {
      response = await dio!.post(
        uri,
        data: body,
        options: mOptions,
      );
    } on DioException catch (error) {
      response = formatDioExecption(error);
    }

    return response;
  }

  //for post api calls with file upload
  Future<Response> postWithFiles(
    String url,
    body, {
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    //preparing the post options if header is required
    final mOptions = !includeHeaders
        ? null
        : Options(
            headers: await getHeaders(),
          );

    Response response;
    try {
      response = await dio!.post(
        uri,
        data: body is FormData ? body : FormData.fromMap(body),
        options: mOptions,
      );
    } on DioException catch (error) {
      response = formatDioExecption(error);
    }

    return response;
  }

  //for put api calls with file upload
  Future<Response> putWithFiles(
    String url,
    body, {
    bool includeHeaders = true,
  }) async {
    //preparing the api uri/url
    String uri = "$host$url";
    //preparing the post options if header is required
    final mOptions = !includeHeaders  
        ? null
        : Options(
            headers: await getHeaders(),
        );

    Response response;
    try {
      response = await dio!.put(
        uri,
        data: body is FormData ? body : FormData.fromMap(body),
        options: mOptions,
      );
    } on DioException catch (error) { 
      response = formatDioExecption(error);
    }

    return response;
  }

  //for patch api calls
  Future<Response> patch(String url, Map<String, dynamic> body) async {
    String uri = "$host$url";
    Response response;

    try {
      response = await dio!.patch(
        uri,
        data: body,
        options: Options(
          headers: await getHeaders(),
        ),
      );
    } on DioException catch (error) {
      response = formatDioExecption(error);
    }

    return response;
  }

  // put api calls
  Future<Response> put(String url, Map<String, dynamic> body) async {
    String uri = "$host$url";
    Response response;

    try {
      response = await dio!.put(
        uri,
        data: body,
        options: Options(
          headers: await getHeaders(),
        ),
      );
    } on DioException catch (error) {
      response = formatDioExecption(error);
    }

    return response;
  }
        

  //for delete api calls
  Future<Response> delete(
    String url,
  ) async {
    String uri = "$host$url";

    Response response;
    try {
      response = await dio!.delete(
        uri,
        options: Options(
          headers: await getHeaders(),
        ),
      );
    } on DioException catch (error) {
      response = formatDioExecption(error);
    }
    return response;
  }

  Response formatDioExecption(DioException ex) {
    var response = Response(requestOptions: ex.requestOptions);
    print("type ==> ${ex.type}");
    response.statusCode = 400;
    String? msg = response.statusMessage;

    try {
      if (ex.type == DioExceptionType.connectionTimeout) {
        msg =
            "Connection timeout"
                .tr;
      } else if (ex.type == DioExceptionType.sendTimeout) {
        msg =
            "Timeout".tr;
      } else if (ex.type == DioExceptionType.receiveTimeout) {
        msg =
            "Timeout".tr;
      } else if (ex.type == DioExceptionType.badResponse) {
        msg =
            "Connection timeout"
                .tr;
      } else {
        msg = "Please check your internet connection and try again".tr;
      }
      response.data = {"message": msg};
    } catch (error) {
      response.statusCode = 400;
      msg = "Please check your internet connection and try again".tr;
      response.data = {"message": msg};
    }

    throw msg;
  }

  //NEUTRALS
  Future<Response> getExternal(
    String url, {
    Map<String, dynamic>? queryParameters,
    String? token,

  }) async {
    return dio!.get(
      url,
      queryParameters: queryParameters,
      options: Options(
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader:
              "Bearer $token",
        },
      ),
    );
  }

  Future<Response> postExternal(
    String url,
    body, {
    String? token,
  }) async {
    return dio!.post(
      url,
      data: body,
      options: Options(
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.authorizationHeader:
              "Bearer $token",
        },
      ),
    );
  }

}