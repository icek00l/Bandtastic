import 'package:bandapp/model/response_model.dart';
import 'package:bandapp/network_requests/app_endpoints.dart';
import 'package:bandapp/network_requests/app_requests_enums.dart';
import 'package:bandapp/network_requests/enums.dart';

import 'api_wrapper.dart';

class ApiClient {
  ApiWrapper apiWrapper = ApiWrapper();

  Future<ResponseModel> checkUniqueCode({
    required getCode,
    required bool isLoading,
  }) async {
    var getNumberData = {
      AppRequestsEnums.CODE_TYPE: getCode,
    };

    var response = await apiWrapper.makeRequest(AppEndpoints.CODEAUTH,
        Request.post, getNumberData, '', isLoading, {
      'Content-Type': 'application/json',
    });
    return response;
  }

  Future<ResponseModel> userRegister({
    required getCode,
    required name,
    required email,
    required bool isLoading,
  }) async {
    var getUserData = {
      AppRequestsEnums.CODE_TYPE: getCode,
      AppRequestsEnums.NAME_TYPE: name,
      AppRequestsEnums.EMAIL_TYPE: email,
    };

    var response = await apiWrapper.makeRequest(AppEndpoints.USER_REGIS,
        Request.post, getUserData, '', isLoading, {
      'Content-Type': 'application/json',
    });
    return response;
  }


}
