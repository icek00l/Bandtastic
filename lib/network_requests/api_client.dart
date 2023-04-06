import 'package:bandapp/model/response_model.dart';
import 'package:bandapp/network_requests/app_endpoints.dart';
import 'package:bandapp/network_requests/app_requests_enums.dart';
import 'package:bandapp/network_requests/enums.dart';
import 'package:get/get_connect.dart';

import 'api_wrapper.dart';

class ApiClient {
  ApiWrapper apiWrapper = ApiWrapper();

  Future checkUniqueCode({
    required getCode,
    required getBoxType,
    required bool isLoading,
  }) async {
    var getNumberData = {
      AppRequestsEnums.CODE_TYPE: getCode,
      AppRequestsEnums.BOX_TYPE: getBoxType,
    };

    var response = await apiWrapper.makeRequest(AppEndpoints.CODEAUTH,
        Request.post, getNumberData, '', isLoading, {
      'Content-Type': 'application/json',
    });
    return response;
  }

  Future userRegister({
    required getCode,
    required getType,
    required name,
    required email,
    required bool isLoading,
  }) async {
    var getUserData = {
      AppRequestsEnums.CODE_TYPE: getCode,
      AppRequestsEnums.BOX_TYPE: getType,
      AppRequestsEnums.NAME_TYPE: name,
      AppRequestsEnums.EMAIL_TYPE: email,
    };

    var response = await apiWrapper.makeRequest(AppEndpoints.USER_REGIS,
        Request.post, getUserData, '', isLoading, {
      'Content-Type': 'application/json',
    });
    return response;
  }

  Future userSelectDay({
    required firstDay,
    required secondDay,
    required token,
    required bool isLoading,
  }) async {
    var getUserData = {
      AppRequestsEnums.FIRST_DAY: firstDay,
      AppRequestsEnums.SECOND_DAY: secondDay,
    };

    var response = await apiWrapper.makeRequest(AppEndpoints.USER_SELECT_DAY,
        Request.post, getUserData, '', isLoading, {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }

}
