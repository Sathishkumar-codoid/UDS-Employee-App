import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Network/APIMethods.dart';
import '../Utils/AppAlertController.dart';

class LoginEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SendOTPEvent extends LoginEvent{
  var payload;
  BuildContext context;

  SendOTPEvent(this.payload,this.context);

}
class VerifyOTPEvent extends LoginEvent{
  var payload;
  BuildContext context;

  VerifyOTPEvent(this.payload, this.context);
}

class LoginState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SendOTPLoadingState extends LoginState{


}
class SendOTPSuccessState extends LoginState{
  var data;

  SendOTPSuccessState(this.data);
}
class SendOTPErrorState extends LoginState{
  String error;

  SendOTPErrorState(this.error);
}
class VerifyOTPLoadingState extends LoginState{

}
class VerifyOTPSuccessState extends LoginState{
  var data;

  VerifyOTPSuccessState(this.data);
}
class VerifyOTPErrorState extends LoginState{
  String error;

  VerifyOTPErrorState(this.error);
}


class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc():super(SendOTPLoadingState());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield SendOTPLoadingState();
    if(event is SendOTPEvent){
      yield await _sendOTP(event);
    }
    if(event is VerifyOTPEvent){
      yield await _verifyOTP(event);
    }



  }

  Future<LoginState> _sendOTP(SendOTPEvent event) async {
    var state;


    await APIManager().sendOTP(
        payload: event.payload,

        successBlock: (data) {

          //terms_condition

          state = SendOTPSuccessState(data);
          //AppAlertController().hideProgressIndicator();

        },
        failureBlock: (exception) {
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context);
          state = SendOTPErrorState(exception.toString());
        });
    return state;
  }

  Future<LoginState> _verifyOTP(VerifyOTPEvent event) async {
    var state;


    await APIManager().verifyOTP(
        payload: event.payload,

        successBlock: (data) {


          state = VerifyOTPSuccessState(data);


        },
        failureBlock: (exception) {
          AppAlertController().showAlert(message: exception.toString(), inContext: event.context);

          state = VerifyOTPErrorState(exception.toString());
        });
    return state;
  }



}