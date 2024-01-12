import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Network/APIMethods.dart';
import 'package:uds_employee/Utils/AppAlertController.dart';

class HomeScreenEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetOfferLetterevent extends HomeScreenEvent{
  BuildContext context;

  GetOfferLetterevent(this.context);

}
class GetCheckinStatusEvent extends HomeScreenEvent{
  BuildContext context;

  GetCheckinStatusEvent(this.context);
}

class UpdateAttendanceEvent extends HomeScreenEvent{
  BuildContext context;
  var payload;

  UpdateAttendanceEvent(this.context,this.payload);
}

class CheckOutAttendanceEvent extends HomeScreenEvent{
  String attendanceId;
  var payload;
  BuildContext context;

  CheckOutAttendanceEvent(this.attendanceId, this.payload, this.context);
}
class HomeScreenState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetOfferLetterLoadingState extends HomeScreenState{

}
class GetOfferLetterSuccessState extends HomeScreenState{
  var data;

  GetOfferLetterSuccessState(this.data);
}
class GetOfferLetterErrorState extends HomeScreenState{
  String error;

  GetOfferLetterErrorState(this.error);
}

class GetCheckInStatusLoadingstate extends HomeScreenState{

}
class GetCheckInStatusSuccessState extends HomeScreenState{
  var data;

  GetCheckInStatusSuccessState(this.data);
}
class GetCheckInStatusErrorState extends HomeScreenState{
  String error;

  GetCheckInStatusErrorState(this.error);
}



class UpdateAttendanceLoadingState extends HomeScreenState{

}
class UpdateAttendanceSuccessState extends HomeScreenState{
  var data;

  UpdateAttendanceSuccessState(this.data);
}
class UpdateAttendanceErrorState extends HomeScreenState{
  String  error;

  UpdateAttendanceErrorState(this.error);
}


class CheckOutAttendanceLoadingState extends HomeScreenState{

}
class CheckOutAttendanceSuccessState extends HomeScreenState{
  var data;

  CheckOutAttendanceSuccessState(this.data);
}
class CheckOutAttendanceErrorState extends HomeScreenState{
  String error;

  CheckOutAttendanceErrorState(this.error);
}


class HomeScreenBloc extends Bloc<HomeScreenEvent,HomeScreenState>{

  HomeScreenBloc():super(GetOfferLetterLoadingState());


  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    yield GetOfferLetterLoadingState();

    if(event is GetOfferLetterevent){
      yield await _getOfferLetter(event);
    }
    if(event is UpdateAttendanceEvent){
      yield await _updateAttendance(event);
    }
    if(event is GetCheckinStatusEvent){
      yield await _getCheckIn(event);
    }
    if(event is CheckOutAttendanceEvent){
      yield await _checkOutAttendance(event);
    }

  }

  Future<HomeScreenState> _getOfferLetter(GetOfferLetterevent event) async {
    var state;

    await APIManager().getOfferLetter(

        successBlock: (data){

          state=GetOfferLetterSuccessState(data);
        },

        failureBlock: (exception){
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context);
          state=GetOfferLetterErrorState(exception.toString());
        });
    print(state);
    return state;
  }
  Future<HomeScreenState> _getCheckIn(GetCheckinStatusEvent event) async {
    var state;

    await APIManager().chekInstatus(

        successBlock: (data){

          state=GetCheckInStatusSuccessState(data);
        },

        failureBlock: (exception){
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context);
          state=GetCheckInStatusErrorState(exception.toString());
        });
    print(state);
    return state;
  }

  Future<HomeScreenState>  _updateAttendance(UpdateAttendanceEvent event) async{
    var state;
    await APIManager().updateAttendance(

        payload: event.payload,
        successBlock: (data){
          state=UpdateAttendanceLoadingState();
          state=UpdateAttendanceSuccessState(data);


        },
        failureBlock: (exception){
          state=UpdateAttendanceErrorState(exception.toString());
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context!);

        });
    return state;
  }

  Future<HomeScreenState> _checkOutAttendance(CheckOutAttendanceEvent event) async{
    var state;
    await APIManager().checkOut(payload: event.payload, attendanceId: event.attendanceId, successBlock: (data){
      state=CheckOutAttendanceLoadingState();
      state=CheckOutAttendanceSuccessState(data);


    }, failureBlock: (exception){
      state=CheckOutAttendanceErrorState(exception.toString());
      AppAlertController().showAlert(message: exception.toString(), inContext: event.context);
    });

    print(state);
    return state;
  }




}