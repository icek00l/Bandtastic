// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bandapp/network_requests/enums.dart';
import 'package:bandapp/utility/Utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class ApiWrapper {
  final String _baseUrl =
      'https://bold-maxwell.65-1-2-185.plesk.page/public/api/';

  Future makeRequest(String url, Request request, dynamic data,
      String urlCheck, bool isLoading, Map<String, String>? headers) async {
    if (await Utility.isNetworkAvailable()) {
      switch (request) {

        case Request.get:
        {
            var uri = _baseUrl + url;
            if (isLoading) Utility.onLoading();
            try {
              final response = await http
                  .get(
                    Uri.parse(uri),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              // Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              Utility.printILog(uri);
              return response;
            } on TimeoutException catch (_) {
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              return const Response();
            }
          }
        case Request.post:

          /// Method to make the Post type request
          {
            final ioc = HttpClient();
            ioc.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;

            final httpObj = IOClient(ioc);

            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.onLoading();
              final response = await httpObj
                  .post(
                    Uri.parse(uri),
                    body: jsonEncode(data),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');

              Utility.printILog(uri);
              return response;
            } on Exception catch (_) {
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              return const Response();
            }
          }
        case Request.put:

          /// Method to make the Put type request
          {
            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.onLoading();
              final response = await http
                  .put(
                    Uri.parse(uri),
                    body: data,
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              Utility.printILog(uri);
              return response;
            } on TimeoutException catch (_) {
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              return const Response();
            }
          }
        case Request.patch:

          /// Method to make the Patch type request
          {
            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.onLoading();
              final response = await http
                  .patch(
                    Uri.parse(uri),
                    body: jsonEncode(data),
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              Utility.printILog(uri);
              return response;
            } on TimeoutException catch (_) {
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');

              return const Response();
            }
          }
        case Request.delete:

          /// Method to make the Delete type request
          {
            var uri = _baseUrl + url;
            try {
              if (isLoading) Utility.onLoading();

              final response = await http
                  .delete(
                    Uri.parse(uri),
                    body: data,
                    headers: headers,
                  )
                  .timeout(const Duration(seconds: 60));
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              Utility.printILog(uri);
              Utility.printLog(response.body);
              return response;
            } on TimeoutException catch (_) {
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              return const Response();
            }
          }

        case Request.multipart:
          {
            var uri = _baseUrl + url;
            if (isLoading) Utility.onLoading();
            try {
              final response = http.MultipartRequest("POST", Uri.parse(uri));
              response.headers.addAll(headers!);

              final streamedResponse = await response.send();
              final responseX =
                  await http.Response.fromStream(streamedResponse);
              print("response code ${responseX.body}");
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              Utility.printILog(uri);
              return responseX;
            } on TimeoutException catch (_) {
              Navigator.of(Get.context!, rootNavigator: true).pop('dialog');
              return const Response();
            }
          }
      }
    }

    /// If there is no network available then instead of print can show the no internet widget too
    else {
      return const Response(
        statusText:
            '{"message":"No internet, please enable mobile data or wi-fi in your phone settings and try again"}',
      );
    }
  }

  /// Method to return the API response based upon the status code of the server
 
}
