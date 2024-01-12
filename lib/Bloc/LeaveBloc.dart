import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Network/APIMethods.dart';
import 'package:uds_employee/Utils/AppAlertController.dart';

import '../Allnavigations/AllBlocDirectory.dart';


abstract class LeaveEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LeaveTypeListEvent extends LeaveEvent{
  BuildContext context;

  LeaveTypeListEvent(this.context);


}

abstract class LeaveState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LeaveTypeListLoadingState extends LeaveState{

}
class LeaveTypeListSuccessState extends LeaveState{

  var data;

  LeaveTypeListSuccessState(this.data);
}
class LeaveTypeListErrorState extends LeaveState{
  String error;

  LeaveTypeListErrorState(this.error);
}


class LeaveBloc extends Bloc<LeaveEvent,LeaveState>{
  LeaveBloc():super(LeaveTypeListLoadingState());
  @override
  Stream<LeaveState> mapEventToState(LeaveEvent event) async* {
    yield LeaveTypeListLoadingState();
    if(event is LeaveTypeListEvent){
      yield await _getLeaveTypeList(event);
    }


  }
  Future<LeaveState> _getLeaveTypeList(LeaveTypeListEvent event) async {
    var state;
    
    await APIManager().leavetypeList( successBlock:
    (data){
      state=LeaveTypeListLoadingState();
      if(data['status']['code']==200){
        state=LeaveTypeListSuccessState(data['data']);
      }

    }, failureBlock: (exception){
      state=LeaveTypeListErrorState(exception.toString());
      AppAlertController().showAlert(message: exception.toString(), inContext: event.context);


    });



    print(state);
    return state;
  }

}