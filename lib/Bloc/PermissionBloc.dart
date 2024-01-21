import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Network/APIEngine.dart';
import 'package:uds_employee/Network/APIMethods.dart';
import 'package:uds_employee/Utils/AppAlertController.dart';

abstract class PermissionEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PermissionApplyEvent extends PermissionEvent {
  BuildContext context;
  var payload;

  PermissionApplyEvent(this.context, this.payload);
}
class PermissionDetailsEvent extends PermissionEvent{
  String permissionID;
  BuildContext context;

  PermissionDetailsEvent(this.permissionID, this.context);
}
class PermissionHistoryEvent extends PermissionEvent{
  String status;
  String userId;
  BuildContext context;

  PermissionHistoryEvent(this.status, this.userId, this.context);
}

abstract class PermissionState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PermissionInitialState extends PermissionState {}

class PermissionApplyLoadingState extends PermissionState {}

class PermissionApplySuccessState extends PermissionState {
  var data;

  PermissionApplySuccessState(this.data);
}

class PermissionApplyErrorState extends PermissionState {
  String error;

  PermissionApplyErrorState(this.error);
}
class PermissionDetailsLoadingState extends PermissionState{

}
class PermissionDetailsSuccessState extends PermissionState{
  var data;

  PermissionDetailsSuccessState(this.data);
}
class PermissionDetailsErrorState extends PermissionState{
  String error;

  PermissionDetailsErrorState(this.error);
}
class PermissionHistoryLoadingState extends PermissionState{

}
class PermissionHistorySuccessState extends PermissionState{
  var data;

  PermissionHistorySuccessState(this.data);
}
class PermissionHistoryErrorState extends PermissionState{
  String error;

  PermissionHistoryErrorState(this.error);
}

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitialState());

  Stream<PermissionState> mapEventToState(PermissionEvent event) async* {
    yield PermissionInitialState();
    if(event is PermissionApplyEvent){
      yield await _permissionapply(event);
    }
    if(event is PermissionDetailsEvent){
      yield await _permissionDetails(event);
    }
    if(event is PermissionHistoryEvent){
      yield await _permissionHistory(event);
    }
  }

  Future<PermissionState> _permissionapply(PermissionApplyEvent event) async {
    var state;
    await APIManager().applyforPermission(
        payload: event.payload,
        successBlock: (data) {
          state=PermissionApplyLoadingState();
          if(data['status']['code']==200){
            state=PermissionApplySuccessState(data);
          }
        },
        failureBlock: (exception) {

          state=PermissionApplyErrorState(exception.toString());
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context);
        });
    return state;
  }

  Future<PermissionState>  _permissionDetails(PermissionDetailsEvent event) async{
    var state;
    await APIManager().getPermissionDetails(permissionId: event.permissionID, successBlock: (data){

      state=PermissionDetailsLoadingState();
      if(data['status']['code']==200){
        state=PermissionDetailsSuccessState(data);
      }

    }, failureBlock: (exception){
      state=PermissionDetailsErrorState(exception.toString());
      AppAlertController().showAlert(message: exception.toString(), inContext: event.context);
    });

    return state;
  }

  Future<PermissionState> _permissionHistory(PermissionHistoryEvent event) async{
    var state;
    await APIManager().getPermissionHistory(userId: event.userId, status: event.status, successBlock: (data){

      state=PermissionHistoryLoadingState();
      if(data['status']['code']==200){
        state=PermissionHistorySuccessState(data);
      }

    }, failureBlock: (exception){
      state=PermissionHistoryErrorState(exception.toString());
      AppAlertController().showAlert(message: exception.toString(), inContext: event.context);

    });
    return state;
  }
}
