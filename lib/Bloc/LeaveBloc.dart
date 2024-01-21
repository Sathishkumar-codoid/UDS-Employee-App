import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Network/APIMethods.dart';
import 'package:uds_employee/Utils/AppAlertController.dart';

import '../Allnavigations/AllBlocDirectory.dart';
import '../Network/APIManager.dart';

abstract class LeaveEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LeaveTypeListEvent extends LeaveEvent {
  BuildContext context;

  LeaveTypeListEvent(this.context);
}

class LeaveStatusEvent extends LeaveEvent {
  String userId;
  String status;
  BuildContext context;

  LeaveStatusEvent(this.context, this.userId, this.status);
}

class LeaveApplyEvent extends LeaveEvent {
  File certificate;
  var payload;
  BuildContext context;
  String token;

  LeaveApplyEvent(this.payload, this.context,this.token,this.certificate);
}


class GetLeaveDetailsEvent extends LeaveEvent{
  String leaveID;
  BuildContext? context;

  GetLeaveDetailsEvent(this.leaveID, this.context);
}
abstract class LeaveState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LeaveTypeListLoadingState extends LeaveState {}

class LeaveTypeListSuccessState extends LeaveState {
  var data;

  LeaveTypeListSuccessState(this.data);
}

class LeaveTypeListErrorState extends LeaveState {
  String error;

  LeaveTypeListErrorState(this.error);
}

class LeaveStatusLoadingState extends LeaveState {}

class LeaveStatusSuccessState extends LeaveState {
  var data;

  LeaveStatusSuccessState(this.data);
}

class LeaveStatusErrorState extends LeaveState {
  String error;

  LeaveStatusErrorState(this.error);
}

class LeaveApplyLoadingState extends LeaveState {}

class LeaveApplySuccessState extends LeaveState {
  var data;

  LeaveApplySuccessState(this.data);
}

class LeaveApplyErrorState extends LeaveState {
  String error;

  LeaveApplyErrorState(this.error);
}
class GetLeaveDetailsLoadingState extends LeaveState{

}
class GetLeaveDetailsSuccessState extends LeaveState{
  var data;

  GetLeaveDetailsSuccessState(this.data);
}

class GetLeaveDetailsErrorState extends LeaveState{
  String error;

  GetLeaveDetailsErrorState(this.error);
}

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveTypeListLoadingState());
  @override
  Stream<LeaveState> mapEventToState(LeaveEvent event) async* {
    yield LeaveTypeListLoadingState();
    if (event is LeaveTypeListEvent) {
      yield await _getLeaveTypeList(event);
    }

    if (event is LeaveStatusEvent) {
      yield await _getLeaveStaus(event);
    }

    if (event is LeaveApplyEvent) {
      yield await _applyLeave(event);
    }

    if(event is GetLeaveDetailsEvent){
      yield await _getLeaveDetails(event);
    }
  }

  Future<LeaveState> _getLeaveTypeList(LeaveTypeListEvent event) async {
    var state;

    await APIManager().leavetypeList(successBlock: (data) {
      state = LeaveTypeListLoadingState();
      if (data['status']['code'] == 200) {
        state = LeaveTypeListSuccessState(data['data']);
      }
    }, failureBlock: (exception) {
      state = LeaveTypeListErrorState(exception.toString());
      AppAlertController()
          .showAlert(message: exception.toString(), inContext: event.context);
    });

    print(state);
    return state;
  }

  Future<LeaveState> _getLeaveStaus(LeaveStatusEvent event) async {
    var state;
    await APIManager().leaveStatus(
        userId: event.userId,
        status: event.status,
        successBlock: (data) {
          state = LeaveStatusLoadingState();
          state = LeaveStatusSuccessState(data);
        },
        failureBlock: (exception) {
          state = LeaveStatusErrorState(exception.toString());

          AppAlertController().showAlert(
              message: exception.toString(), inContext: event.context!);
        });
    return state;
  }

  Future<LeaveState> _applyLeave(LeaveApplyEvent event) async {
    var state;
    print('event.certificate');
    print(event.certificate.path);
    print(event.certificate.path.isNotEmpty);

    try{
      Dio dio = new Dio();

      var formData = FormData.fromMap({
        "data": jsonEncode(event.payload),
      });
      if(event.certificate.path.isNotEmpty){
        print('scle is printed');
        formData.files.add(MapEntry("certificate" , await MultipartFile.fromFile(event.certificate.path) ));
     //   formData.files.add("certificate",await MultipartFile.fromFile(event.certificate.path));
      }
      dio.options.contentType = Headers.multipartFormDataContentType;
      Response response;
      print(formData.fields);
     // print(formData.);
      print(formData.files.isNotEmpty);


      response = await dio.request(
          APIUrlManager.applyLeave
          ,
          data: formData,
          options: Options(
            method: 'POST',

            headers: {

              'contentType': Headers.formUrlEncodedContentType,
              'Authorization':
              'Bearer ${event.token}'
            },
          ));
      print('response111111');
      print(response);

      if (response.statusCode == 200) {
        state=LeaveApplySuccessState(response.data);



      } else {
        print('Failed to upload files. Status code: ${response.statusMessage }');
        print('Failed to upload files. Status code: ${response.statusCode}');
        AppAlertController().showAlert(message: response.statusMessage!, inContext: event.context);
      }

    }catch(error){

      print('error');
      if(error is DioException){

        AppAlertController().showAlert(message: error.response!.data['status']['message'], inContext: event.context);
        state=LeaveApplyErrorState(error.response!.data['status']['message']);
      }else{
        AppAlertController().showAlert(message: error.toString(), inContext: event.context);
        state=LeaveApplyErrorState(error.toString());

      }

     // print(error.response.statusMessage);





    }
    print('state 12232323');
    print(state);

    return state;
  }

  Future<LeaveState>  _getLeaveDetails(GetLeaveDetailsEvent event) async{
    var state;
    await APIManager().leaveDetails(userId: event.leaveID, successBlock: (data){
      state=GetLeaveDetailsLoadingState();
      if(data['status']['code']==200){
        state=GetLeaveDetailsSuccessState(data['data']);
      }
    }, failureBlock: (exception){
      state=GetLeaveDetailsErrorState(exception.toString());
      AppAlertController().showAlert(message: exception.toString(), inContext: event.context!);
    });
    return state;
  }
}
