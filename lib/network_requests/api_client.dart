import 'package:bandapp/network_requests/app_endpoints.dart';
import 'package:bandapp/network_requests/app_requests_enums.dart';
import 'package:bandapp/network_requests/enums.dart';

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

    var response = await apiWrapper.makeRequest(
        AppEndpoints.CODEAUTH, Request.post, getNumberData, '', isLoading, {
      'Content-type': 'application/json',
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

    var response = await apiWrapper.makeRequest(
        AppEndpoints.USER_REGIS, Request.post, getUserData, '', isLoading, {
      'Content-type': 'application/json',
    });
    return response;
  }

  Future userEditApi({
    required getCode,
    required name,
    required email,
    required firstDay,
    required secondDay,
    required token,
    required bool isLoading,
  }) async {
    var getUserData = {
      AppRequestsEnums.CODE_TYPE: getCode,
      AppRequestsEnums.NAME_TYPE: name,
      AppRequestsEnums.EMAIL_TYPE: email,
      AppRequestsEnums.FIRST_DAY: firstDay,
      AppRequestsEnums.SECOND_DAY: secondDay,
    };

    var response = await apiWrapper.makeRequest(
        AppEndpoints.UPDATE_PROFILE_API,
        Request.post,
        getUserData,
        '',
        isLoading,
        {'Content-type': 'application/json','Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future getProfileApi({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.GET_PROFILE_API,
        Request.get,
        "",
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
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

    var response = await apiWrapper.makeRequest(
        AppEndpoints.USER_SELECT_DAY,
        Request.post,
        getUserData,
        '',
        isLoading,
        {'Content-type': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future getIntroData({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.GET_INTRO_API,
        Request.get,
        "",
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future getBandProgressData({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.BAND_PROGRESS_LIST,
        Request.get,
        "",
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future getHomeData({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.HOME_API,
        Request.get,
        "",
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future getSessionData({
    required int getID,
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.GET_SESSION_DETAIL_API}?id=$getID",
        Request.get,
        "",
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future getBandPositionData({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.BANDS_POSITION_API,
        Request.get,
        "",
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future createExerciseApi({
    required sesionId,
    required exerciseTypeid,
    required sessionType,
    required bandpostionId,
    required reps,
    required beyondFailure,
    required notes,
    required power,
    required bands,
    required token,
    required bool isLoading,
  }) async {
    var getExerciseData = {
      AppRequestsEnums.SESSION_ID: sesionId,
      AppRequestsEnums.EXERCISE_TYPE_ID: exerciseTypeid,
      AppRequestsEnums.SESSION_TPE: sessionType,
      AppRequestsEnums.BAND_POSITION_ID: bandpostionId,
      AppRequestsEnums.REPS: reps,
      AppRequestsEnums.BEYOND_FAILURE: beyondFailure,
      AppRequestsEnums.NOTES: notes,
      AppRequestsEnums.POWER: power,
      AppRequestsEnums.BANDS: bands,
    };

    var response = await apiWrapper.makeRequest(
        AppEndpoints.CREATE_EXERCISE_API,
        Request.post,
        getExerciseData,
        '',
        isLoading, {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future editExerciseLogApi({
    required sesionId,
    required exerciseTypeid,
    required sessionTypehere,
    required bandpostionId,
    required reps,
    required beyondFailure,
    required notes,
    required power,
    required bands,
    required getID,
    required token,
    required bool isLoading,
  }) async {
    var getExerciseData = {
      AppRequestsEnums.SESSION_ID: sesionId,
      AppRequestsEnums.EXERCISE_TYPE_ID: exerciseTypeid,
      AppRequestsEnums.SESSION_TPE: sessionTypehere,
      AppRequestsEnums.BAND_POSITION_ID: bandpostionId,
      AppRequestsEnums.REPS: reps,
      AppRequestsEnums.BEYOND_FAILURE: beyondFailure,
      AppRequestsEnums.NOTES: notes,
      AppRequestsEnums.POWER: power,
      AppRequestsEnums.BANDS: bands,
    };

    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.EDIT_LOG_API}?id=$getID",
        Request.post,
        getExerciseData,
        '',
        isLoading, {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future getPreviousSessionData({
    required int getID,
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.GET_PREVIOUS_SESSION_DETAIL_API}?id=$getID",
        Request.get,
        "",
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future endSessionAPi({
    required sessionId,
    required totalTime,
    required notes,
    required token,
    required bool isLoading,
  }) async {
    var getUserData = {
      AppRequestsEnums.SESSIONIDEND: sessionId,
      AppRequestsEnums.TOTALTIMEEND: totalTime.toString(),
      AppRequestsEnums.NOTESEND: notes,
    };

    var response = await apiWrapper.makeRequest(
        AppEndpoints.END_SESSION_API,
        Request.post,
        getUserData,
        '',
        isLoading,
        {'Content-type': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future weeklyCycleAPi({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.WEEKLY_CYCLE_API,
        Request.get,
        '',
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future overallPerformanceAPi({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.OVERALL_PERFORMANCE_API,
        Request.get,
        '',
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future yearlyCycleAPi({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.YEARLY_CYCLE_API,
        Request.get,
        '',
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future monthlyCycleAPi({
    required startDate,
    required endDate,
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.MONTHLY_CYCLE_API}?start_date=$startDate&end_date=$endDate",
        Request.get,
        '',
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }
}
