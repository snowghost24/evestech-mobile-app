import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
// import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

const String appToken = "TOKEN";

mixin HttpInstance {
  final client = InterceptedClient.build(
    interceptors: [
      _InstanceApiInterceptor(),
      // _LoggerInterceptor(),
    ],
    // retryPolicy: _ExpiredTokenRetryPolicy(),
  );

  Future<dynamic> get(path, [params = const {}]) async {
    try {
      return client.get('${Constants.API_ROOT}$path'.toUri(), params: params);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(path, {body, params}) async {
    try {
      var responseData = await client.post('${Constants.API_ROOT}$path'.toUri(),
          body: json.encode(body), params: params);
      if (responseData.statusCode == 200) {
        return responseData;
      } else {
        return Future.error(
          responseData.body,
          StackTrace.fromString("${responseData.body}"),
        );
      }
    } catch (e) {
      print("caught on e");
      rethrow;
    }
  }

  Future<dynamic> put(path, {body, params}) async {
    try {
      return client.post('${Constants.API_ROOT}$path'.toUri(),
          body: json.encode(body), params: params);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(path, {body, params}) async {
    try {
      return client.post('${Constants.API_ROOT}$path'.toUri(),
          body: json.encode(body), params: params);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchOrgs(int? id) async {
    var finalResponse;
    try {
      final response = await client.get(Constants.API_ROOT.toUri());

      print('fetchOrgs response $response');
      if (response.statusCode == 200) {
        print("response is 200");
        finalResponse = json.decode(response.body);
      } else {}
    } on SocketException {
      return Future.error('No Internet connection 😑');
    } on FormatException {
      return Future.error('Bad response format 👎');
    } on Exception catch (error) {
      print(error);
      return Future.error('Unexpected error 😢');
    }
    print(finalResponse);
    return finalResponse;
  }
}

class _InstanceApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final cache = await SharedPreferences.getInstance();
      final storedToken = cache.getString(appToken);

      // data.params['orgId'] = 'metric';
      data.headers[HttpHeaders.acceptHeader] = "*/*";
      data.headers[HttpHeaders.contentTypeHeader] = "application/json";
      if (storedToken != null) {
        data.headers[HttpHeaders.authorizationHeader] = 'Bearer $storedToken';
      }
    } catch (e) {
      print("request intercepted _InstanceApiInterceptor error");
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(appToken)) {
        prefs.remove(appToken);
      }
    }
    return data;
  }
}

//TODO: set up logs here
// class _LoggerInterceptor implements InterceptorContract {
//   @override
//   Future<RequestData> interceptRequest({required RequestData data}) async {
//     print("----- Request -----");
//     print(data.toString());
//     return data;
//   }

//   @override
//   Future<ResponseData> interceptResponse({required ResponseData data}) async {
//     print("----- Response -----");
//     print(data.toString());
//     return data;
//   }
// }




//TODO: set up retry here
// class _ExpiredTokenRetryPolicy extends RetryPolicy {
//   @override
//   int get maxRetryAttempts => 2;

//   @override
//   bool shouldAttemptRetryOnException(Exception reason) {
//     print(reason);

//     return false;
//   }

//   @override
//   Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
//     if (response.statusCode == 401) {
//       print("Retrying request...");
//       final cache = await SharedPreferences.getInstance();

//       cache.setString(appToken, OPEN_WEATHER_API_KEY);

//       return true;
//     }

//     return false;
//   }
// }
