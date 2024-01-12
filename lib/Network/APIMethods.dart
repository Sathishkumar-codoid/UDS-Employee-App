import 'package:http/http.dart' as HTTP;
import 'package:uds_employee/Network/APIEngine.dart';
import 'package:uds_employee/Network/APIManager.dart';
typedef SuccessCompletionBlock = void Function(dynamic);
typedef FailureCompletionBlock = void Function(Exception);
class APIManager{
  Future? sendOTP(
      {required var payload,
        required SuccessCompletionBlock successBlock,
        required FailureCompletionBlock failureBlock,
        bool showIndicator = true}) async {
    var response = await APIEngine().performRequest(
        APIRequestType.POST, APIUrlManager.PhoneNumberVerifyUrl,
        isWithToken: false, payload: payload, showIndicator: showIndicator);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;
  }

  Future? verifyOTP(
      {required var payload,
        required SuccessCompletionBlock successBlock,
        required FailureCompletionBlock failureBlock,
        bool showIndicator = true}) async {
    var response = await APIEngine().performRequest(
        APIRequestType.POST, APIUrlManager.otpVerifyUrl,
        isWithToken: false, payload: payload, showIndicator: showIndicator);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;
  }

  Future? getOfferLetter(
      {
        required SuccessCompletionBlock successBlock,
        required FailureCompletionBlock failureBlock,
        bool showIndicator = true}) async {
    var response = await APIEngine().performRequest(
        APIRequestType.GET, APIUrlManager.employeOfferLetter,
        isWithToken: true, showIndicator: showIndicator);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;
  }

  Future? getCalenderApi(
      {
        required String year,
        required String month,
        required SuccessCompletionBlock successBlock,
        required FailureCompletionBlock failureBlock,
        bool showIndicator = true}) async {
    var response = await APIEngine().performRequest(
        APIRequestType.GET, '${APIUrlManager.getCalenderUrl}?year=$year&month=$month',
        isWithToken: true, showIndicator: showIndicator);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;
  }

  Future? getShiftTIming(
      {
        required String year,
        required String month,
        required String day,
        required SuccessCompletionBlock successBlock,
        required FailureCompletionBlock failureBlock,
        bool showIndicator = true}) async {
    var response = await APIEngine().performRequest(
        APIRequestType.GET, '${APIUrlManager.getShiftTiming}?year=$year&month=$month&day=$day',
        isWithToken: true, showIndicator: showIndicator);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;
  }



  Future? updateAttendance({
    required var payload,
    required SuccessCompletionBlock successBlock,
    required FailureCompletionBlock failureBlock,
})   async {

  var response = await APIEngine().performRequest(
  APIRequestType.POST, APIUrlManager.attendanceUpdate,
  isWithToken: true, payload: payload);
  _handleResponseCallBack(response, successBlock, failureBlock);

  return response;

}

  Future? chekInstatus({
 //   required var payload,
    required SuccessCompletionBlock successBlock,
    required FailureCompletionBlock failureBlock,
  })   async {

    var response = await APIEngine().performRequest(
        APIRequestType.GET, APIUrlManager.checkinStatus,
        isWithToken: true);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;

  }


  Future? checkOut({
       required var payload,
    required String attendanceId,
    required SuccessCompletionBlock successBlock,
    required FailureCompletionBlock failureBlock,
  })   async {

    var response = await APIEngine().performRequest(
        APIRequestType.PUT, '${APIUrlManager.getCalenderUrl}$attendanceId/',
        isWithToken: true,payload: payload);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;

  }



  Future? applyleave({
    required var payload,
    required SuccessCompletionBlock successBlock,
    required FailureCompletionBlock failureBlock,
  })   async {

    var response = await APIEngine().performRequest(
        APIRequestType.POST, APIUrlManager.applyLeave,
        isWithToken: true,payload: payload);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;

  }


  Future? leaveStatus({
    required String userId,
    required String status,
    required SuccessCompletionBlock successBlock,
    required FailureCompletionBlock failureBlock,
  })   async {

    var response = await APIEngine().performRequest(
        APIRequestType.GET, '${APIUrlManager.applyLeave}?user=$userId&status=$status',
        isWithToken: true,);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;

  }


  Future? leavetypeList({
    required SuccessCompletionBlock successBlock,
    required FailureCompletionBlock failureBlock,
  })   async {
    var response = await APIEngine().performRequest(
      APIRequestType.GET, APIUrlManager.leaveTypes,
      isWithToken: true,);
    _handleResponseCallBack(response, successBlock, failureBlock);

    return response;

  }



  void _handleResponseCallBack(
      APIResponse response,
      SuccessCompletionBlock successBlock,
      FailureCompletionBlock failureBlock) {
    switch (response.status) {
      case APIResponseStatus.SUCCESS:
        successBlock(response.data);
        break;
      case APIResponseStatus.FAILED:
        failureBlock(response.exception!);
        break;
    }
  }
}