// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'package:bandapp/model/response_model.dart';
import 'package:bandapp/network_requests/enums.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;


/// API WRAPPER to call all the APIs and handle the error status codes
class ApiWrapper {
  final String _baseUrl =
      'https://pedantic-heisenberg.65-1-2-185.plesk.page/api/';

  var dio = Dio(
    BaseOptions(
      
      baseUrl: 'https://pedantic-heisenberg.65-1-2-185.plesk.page/api/',
      connectTimeout: 100000,
      sendTimeout: 10000,
      receiveTimeout: 100000,
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
      },
      responseType: ResponseType.plain,
    ),
  );

  /// Method to make all the requests inside the app like GET, POST, PUT, Delete
  Future<ResponseModel> makeRequest(String url, Request request, dynamic data,
      String urlCheck, bool isLoading, Map<String, String>? headers) async {
    /// To see whether the network is available or not
    if (await Utility.isNetworkAvailable()) {
      switch (request) {

        /// Method to make the Get type request
        case Request.get:
          {
            var uri = _baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = await http
                  .get(
                    Uri.parse(uri),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Utility.closeDialog();
              Utility.printILog(uri);
              return _returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request timed out"}', hasError: true);
            }
          }
        case Request.post:

          /// Method to make the Post type request
          {
            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.showLoader();
              final response = await http
                  .post(
                    Uri.parse(uri),
                    body: jsonEncode(data),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Utility.closeDialog();
              Utility.printILog(uri);
              print("response.....${response.body}");
              return _returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request timed out"}', hasError: true);
            }
          }
        case Request.put:

          /// Method to make the Put type request
          {
            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.showLoader();
              final response = await http
                  .put(
                    Uri.parse(uri),
                    body: data,
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Utility.closeDialog();
              Utility.printILog(uri);
              return _returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request timed out"}', hasError: true);
            }
          }
        case Request.patch:

          /// Method to make the Patch type request
          {
            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.showLoader();
              final response = await http
                  .patch(
                    Uri.parse(uri),
                    body: jsonEncode(data),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Utility.closeDialog();
              Utility.printILog(uri);
              return _returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request timed out"}',
                  hasError: true,
                  errorCode: 1000);
            }
          }
        case Request.delete:

          /// Method to make the Delete type request
          {
            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.showLoader();

              final response = await http
                  .delete(
                    Uri.parse(uri),
                    body: data,
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Utility.closeDialog();
              Utility.printILog(uri);
              Utility.printLog(response.body);
              return _returnResponse(response);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request timed out"}', hasError: true);
            }
          }

        case Request.multipart:
          {
            var uri = _baseUrl + url;
            if (isLoading) Utility.showLoader();
            try {
              final response = http.MultipartRequest("POST", Uri.parse(uri));
              response.headers.addAll(headers!);
              if (url == "register") {
                if (urlCheck == 'VenueRegister') {
                  response.fields['user_type'] = data['user_type'];
                  response.fields['country_code'] = data['country_code'];

                  response.fields['first_name'] = data['first_name'];
                  response.fields['last_name'] = data['last_name'];
                  response.fields['user_name'] = data['user_name'];
                  response.fields['designation'] = data['designation'];
                  response.fields['website'] = data['website'];
                  response.fields['phone'] = data['phone'];
                  response.fields['social_login_id'] = data['social_login_id'];

                  if (data['file_url'] != '') {
                    response.files.add(await http.MultipartFile.fromPath(
                        'file_url', data['file_url']));
                  }
                } else {
                  response.fields['user_type'] = data['user_type'];
                  response.fields['country_code'] = data['country_code'];

                  response.fields['first_name'] = data['first_name'];
                  response.fields['last_name'] = data['last_name'];
                  response.fields['user_name'] = data['user_name'];
                  response.fields['gender'] = data['gender'];
                  response.fields['phone'] = data['phone'];
                  response.fields['social_login_id'] = data['social_login_id'];
                  response.fields['login_type'] = data['login_type'];

                  if (data['file_url'] != '') {
                    response.files.add(await http.MultipartFile.fromPath(
                        'file_url', data['file_url']));
                  }
                }
              } else if (url == "edit-customer-profile") {
                response.fields['first_name'] = data['first_name'];
                response.fields['last_name'] = data['last_name'];
                response.fields['user_name'] = data['user_name'];
                response.fields['age'] = data['age'];
                response.fields['gender'] = data['gender'];
                response.fields['phone'] = data['phone'];
                response.fields['email'] = data['email'];
                response.fields['my_go_to_round'] = data['my_go_to_round'];

                if (data['file_url'] == '') {
                  response.fields['image_url'] = data['image_url'];
                  response.fields['file_url'] = data['file_url'];
                } else {
                  response.files.add(await http.MultipartFile.fromPath(
                      'file_url', data['file_url']));
                }
              } else if (url == "create-group") {
                response.fields['name'] = data['name'];
                response.fields['user_ids'] = data['user_ids'];
                if (data['image'] != '') {
                  response.files.add(await http.MultipartFile.fromPath(
                      'image', data['image']));
                }
              } else if (url == "v2/build-business-profile-with-logo") {
                response.fields['name_of_bar_or_club'] =
                    data['name_of_bar_or_club'];
                response.fields['bar_club_address'] = data['bar_club_address'];
                response.fields['capacity'] = data['capacity'];
                response.fields['cover'] = data['cover'];
                response.fields['wait_time'] = data['wait_time'];
                response.fields['wristband_available'] =
                    data['wristband_available'];
                response.fields['country_code'] = data['country_code'];
                response.fields['phone'] = data['phone'];
                response.fields['line_skip_available'] =
                    data['line_skip_available'];

                if (data['club_logo'] == '') {
                  response.files.add(await http.MultipartFile.fromPath(
                      'club_logo', data['club_logo']));
                } 
              } else if (url == "edit-profile") {
                response.fields['first_name'] = data['first_name'];
                response.fields['last_name'] = data['last_name'];
                response.fields['user_name'] = data['user_name'];
                response.fields['designation'] = data['designation'];
                response.fields['website'] = data['website'];

                if (data['file_url'] == '') {
                  response.fields['image_url'] = data['image_url'];
                  response.fields['file_url'] = data['file_url'];
                } else {
                  response.files.add(await http.MultipartFile.fromPath(
                      'file_url', data['file_url']));
                }
              }

              final streamedResponse = await response.send();
              final responseX =
                  await http.Response.fromStream(streamedResponse);
              print("response code ${responseX.body}");
              Utility.closeDialog();
              Utility.printILog(uri);
              return _returnResponse(responseX);
            } on TimeoutException catch (_) {
              Utility.closeDialog();
              return ResponseModel(
                  data: '{"message":"Request timed out"}', hasError: true);
            }
          }
      }
    }

    /// If there is no network available then instead of print can show the no internet widget too
    else {
      return ResponseModel(
        data:
            '{"message":"No internet, please enable mobile data or wi-fi in your phone settings and try again"}',
        hasError: true,
        errorCode: 1000,
      );
    }
  }

  /// Method to return the API response based upon the status code of the server
  ResponseModel _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return ResponseModel(
            data: response.body,
            hasError: false,
            errorCode: response.statusCode);
      case 401:
      case 400:
      case 406:
      case 409:
      case 500:
      case 522:
        return ResponseModel(
            data: response.body,
            hasError: true,
            errorCode: response.statusCode);

      default:
        return ResponseModel(data: response.body, hasError: true, errorCode: 0);
    }
  }
}
