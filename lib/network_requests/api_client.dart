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
        AppEndpoints.CODEAUTH, Request.post, getNumberData, '', true, {
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
        AppEndpoints.USER_REGIS, Request.post, getUserData, '', true, {
      'Content-type': 'application/json',
    });
    return response;
  }

  Future userEditApi({
    required getCode,
    required name,
    required email,
    required token,
    required bool isLoading,
  }) async {
    var getUserData = {
      AppRequestsEnums.CODE_TYPE: getCode,
      AppRequestsEnums.NAME_TYPE: name,
      AppRequestsEnums.EMAIL_TYPE: email,
    };

    var response = await apiWrapper.makeRequest(AppEndpoints.UPDATE_PROFILE_API,
        Request.post, getUserData, '', true, {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
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
        true,
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
        true,
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
        true,
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
        true,
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
        true,
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
        true,
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
        true,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future createExerciseApi({
    required sesionId,
    required exerciseTypeid,
    required getcycleid,
    required bandpostionId,
    required reps,
    required time,
    required notes,
    required power,
    required bands,
    required matfromvalue,
    required matTovalue,
    required token,
    required bool isLoading,
  }) async {
    var getExerciseData = {
      AppRequestsEnums.SESSION_ID: sesionId,
      AppRequestsEnums.EXERCISE_TYPE_ID: exerciseTypeid,
      AppRequestsEnums.cycle_id: getcycleid,
      AppRequestsEnums.BAND_POSITION_ID: bandpostionId,
      AppRequestsEnums.REPS: reps,
      AppRequestsEnums.time: time,
      AppRequestsEnums.NOTES: notes,
      AppRequestsEnums.POWER: power,
      AppRequestsEnums.BANDS: bands,
      AppRequestsEnums.matFrom: matfromvalue,
      AppRequestsEnums.matTo: matTovalue,
    };

    print("sdlkdlsk $getExerciseData");

    var response = await apiWrapper.makeRequest(
        AppEndpoints.CREATE_EXERCISE_API,
        Request.post,
        getExerciseData,
        '',
        true, {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    return response;
  }

  Future editExerciseLogApi({
    required sesionId,
    required exerciseTypeid,
    required getcycleid,
    required bandpostionId,
    required getTime,
    required notes,
    required matfromvalue,
    required matTovalue,
    required power,
    required bands,
    required getID,
    required token,
    required bool isLoading,
  }) async {
    var getExerciseData = {
      AppRequestsEnums.SESSION_ID: sesionId,
      AppRequestsEnums.EXERCISE_TYPE_ID: exerciseTypeid,
      AppRequestsEnums.cycle_id: getcycleid,
      AppRequestsEnums.BAND_POSITION_ID: bandpostionId,
      AppRequestsEnums.time: getTime,
      AppRequestsEnums.NOTES: notes,
      AppRequestsEnums.POWER: power,
      AppRequestsEnums.BANDS: bands,
      AppRequestsEnums.matFrom: matfromvalue,
      AppRequestsEnums.matTo: matTovalue,
    };
    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.EDIT_LOG_API}?id=$getID",
        Request.post,
        getExerciseData,
        '',
        true, {
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
        true,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future endSessionAPi({
    required sessionId,
    required getcycleid,
    required totalTime,
    required notes,
    required token,
    required bool isLoading,
  }) async {
    var getUserData = {
      AppRequestsEnums.SESSIONIDEND: sessionId,
      AppRequestsEnums.cycle_id: getcycleid,
      AppRequestsEnums.TOTALTIMEEND: totalTime.toString(),
      AppRequestsEnums.NOTESEND: notes,
    };

    var response = await apiWrapper.makeRequest(
        AppEndpoints.END_SESSION_API,
        Request.post,
        getUserData,
        '',
        true,
        {'Content-type': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future weeklyCycleAPi({
    required token,
    required sessionID,
    required cycleID,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
       "${AppEndpoints.WEEKLY_CYCLE_API}?s_id=$sessionID&cycle_id=$cycleID",
        Request.get,
        '',
        '',
        true,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future overallPerformanceAPi({
    required token,
    required sessionID,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.OVERALL_PERFORMANCE_API}?s_id=$sessionID",
        Request.get,
        '',
        '',
        true,
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
        true,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future monthlyCycleAPi({
    required cycleIDApi,
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.MONTHLY_CYCLE_API}?cycle_id=$cycleIDApi",
        Request.get,
        '',
        '',
        true,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }
  Future dayReviewApi({
    required sessionId,
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        "${AppEndpoints.dailycycle}?s_id=$sessionId",
        Request.get,
        '',
        '',
        true,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }

  Future getGeneralDataApi({
    required token,
    required bool isLoading,
  }) async {
    var response = await apiWrapper.makeRequest(
        AppEndpoints.getAppDataApi,
        Request.get,
        '',
        '',
        isLoading,
        {'Accept': 'application/json', 'Authorization': 'Bearer $token'});
    return response;
  }
}
