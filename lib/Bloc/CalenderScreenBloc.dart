import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

import '../Network/APIMethods.dart';
import '../Screens/Attendance/Calender/CalendarScreen.dart';
import '../Utils/AppAlertController.dart';

class CalenderEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetCalenderEvent extends CalenderEvent{
  String? year;
  String? month;
  BuildContext context;
  GetCalenderEvent(this.context, this.year, this.month);

}

// class UpdateAttendanceEvent extends CalenderEvent{
//   BuildContext context;
//   var payload;
//
//   UpdateAttendanceEvent(this.context,this.payload);
// }
class GetShiftTimingEvent extends CalenderEvent{
  String year;
  String month;
  String day;
  BuildContext context;

  GetShiftTimingEvent(this.year, this.month, this.day, this.context);
}





class CalenderState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetCalenderInitialState extends CalenderState{


}
class GetCalenderLoadingState extends CalenderState{


}
class GetCalenderSuccessState extends CalenderState{
  var data;

  GetCalenderSuccessState(this.data);
}
class GetCalenderErrorState extends CalenderState{
  String error;

  GetCalenderErrorState(this.error);
}
// class UpdateAttendanceLoadingState extends CalenderState{
//
// }
// class UpdateAttendanceSuccessState extends CalenderState{
//   var data;
//
//   UpdateAttendanceSuccessState(this.data);
// }
// class UpdateAttendanceErrorState extends CalenderState{
//   String  error;
//
//   UpdateAttendanceErrorState(this.error);
// }

class GetShiftTimingLoadingState extends CalenderState{

}
class GetShiftTimingSuccessState extends CalenderState{
  var data;

  GetShiftTimingSuccessState(this.data);
}
class GetShiftTimingErrorState extends CalenderState{
  String error;

  GetShiftTimingErrorState(this.error);
}




class CalenderBloc extends Bloc<CalenderEvent, CalenderState>{
  CalenderBloc():super(GetCalenderInitialState());

  Stream<CalenderState> mapEventToState(CalenderEvent event) async* {
    yield GetCalenderLoadingState();
    if(event is GetCalenderEvent){
      yield await _getCalenderApi(event);
    }
    // if(event is UpdateAttendanceEvent){
    //   yield await _updateAttendance(event);
    // }
    if(event is GetShiftTimingEvent){
      yield await _getShiftData(event);
    }



  }

  Future<CalenderState> _getCalenderApi(GetCalenderEvent event) async {
    var state;

    await APIManager().getCalenderApi(
        year: event.year!, month: event.month!,

        successBlock: (data) {

          state = GetCalenderSuccessState(data);

        },
        failureBlock: (exception) {
          print("exception-81");
          print(exception);
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context);
          state = GetCalenderErrorState(exception.toString());
        }, );
    return state;
  }

  // Future<CalenderState>  _updateAttendance(UpdateAttendanceEvent event) async{
  //   var state;
  //   await APIManager().updateAttendance(
  //
  //       payload: event.payload,
  //       successBlock: (data){
  //         state=UpdateAttendanceLoadingState();
  //         state=UpdateAttendanceSuccessState(data);
  //
  //
  //       },
  //       failureBlock: (exception){
  //         state=UpdateAttendanceErrorState(exception.toString());
  //         AppAlertController().showAlert(message: exception.toString(), inContext: event.context!);
  //
  //       });
  //   return state;
  // }

  Future<CalenderState> _getShiftData(GetShiftTimingEvent event) async{
    var state;
    await APIManager().getShiftTIming(
        year: event.year,
        month: event.month,
        day: event.day,
        successBlock: (data){
          state=GetShiftTimingLoadingState();
          state=GetShiftTimingSuccessState(data);

        },
        failureBlock: (exception){
          state=GetShiftTimingErrorState(exception.toString());
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context!);

        });
    return state;
  }


  





}