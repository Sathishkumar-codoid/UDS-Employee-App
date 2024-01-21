import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/LoginBloc.dart';
import 'package:uds_employee/Repository/APIToken.dart';
import 'package:uds_employee/Screens/DashBoard/DashBoardScreen.dart';

import '../../Allnavigations/AllBlocDirectory.dart';

class OTPScreen extends StatefulWidget {
   OTPScreen({Key? key,required this.phonenumber}) : super(key: key);
   String phonenumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController _phoneController=TextEditingController();
  final TextEditingController _otpEditingController=TextEditingController();

  final _timerStream = StreamController<int>.broadcast();
  int? timerCounter;
  Timer? _resendCodeTimer;
  static const _timerDuration = 30;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneController.text=widget.phonenumber;
    activeCounter();

  }

  dispose() {
    _timerStream.close();
    _resendCodeTimer?.cancel();

    super.dispose();
  }
  activeCounter() {
    _resendCodeTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_timerDuration - timer.tick > 0) {
        _timerStream.sink.add(_timerDuration - timer.tick);
      } else {
        _timerStream.sink.add(0);
        _resendCodeTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc();

      },
    child: BlocListener<LoginBloc,LoginState>(
    listener: (context,state){
      if(state is VerifyOTPSuccessState){
        print(state.data);
        var token=state.data['session']['token'];
        setToken(token);
        print('token has setted');
        print(token);
        print(state.data['data']['id']);
        var userid=state.data['data']['id'];
        setUserId(userid);
        print(userid);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));
      }

    },
      child:  BlocBuilder<LoginBloc,LoginState>(
      builder: (context,state){

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 49.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.primaryColor1, AppTheme.primaryColor2],
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5.w, 12.h, 5.w, 2.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 6.5.h,
                              width: 15.w,
                              child: Image.asset(AppConstant.logoIcon),
                            ),
                            CommonUI().verticleAlign(height: 5.h),
                            Container(
                                height: 8.h,
                                // width: 30.w,
                                // color: Colors.yellow,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(1.w, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CommonUI().myTextL(
                                          text: "welcome",
                                          fontSize: 20.sp,
                                          color: AppTheme.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.visible),
                                      CommonUI().verticleAlign(height: 2.h),
                                      CommonUI().myTextL(
                                          text: "signin",
                                          fontSize: 12.sp,
                                          color: AppTheme.whiteColor,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.visible)
                                    ],
                                  ),
                                )),
                            CommonUI().verticleAlign(height: 1.h),


                            Row(
                              children: [
                                Image.asset(AppConstant.globeicon,scale: 10.8,),
                                CommonUI().verticleAlign(width: 3.w),
                                CommonUI().myTextL(
                                    text: "chooselanguage",
                                    fontSize: 10.sp,
                                    color: AppTheme.whiteColor,

                                    fontWeight: FontWeight.w500),
                                CommonUI().verticleAlign(width: 4.w),
                                GestureDetector(
                                  child: Row(
                                    children: [
                                      // CommonUI().myText(text: selectedValue!,
                                      //     color: AppTheme.whiteColor),
                                      CommonUI().verticleAlign(width: 1.w),
                                      Image.asset(AppConstant.downarrowicon,
                                        color: AppTheme.whiteColor,)
                                    ],
                                  ),

                                  onTap: (){

                                    // AppOptionsViewer(
                                    //     inContext: context,
                                    //     options: _allLanguages,
                                    //     initialOption: dropdownController?.text,
                                    //     initialOptions: _allLanguages,
                                    //     whenUserSelected: (value) {
                                    //       setState(() {
                                    //         dropdownController?.text = value;
                                    //         if (value == "English") {
                                    //           selectedValue = "English";
                                    //           selectedLanguage = "0";
                                    //           LocaleNotifier.of(context)?. change("en");
                                    //         } else if (value == "Hindi") {
                                    //           selectedValue = "Hindi";
                                    //           selectedLanguage = "1";
                                    //           LocaleNotifier.of(context)?. change("hi");
                                    //         }
                                    //
                                    //       });
                                    //     }).showMenu();
                                  },),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset(
                        AppConstant
                            .spiralimage, // Replace with the path to your image asset
                        scale: 1.3,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 55.h,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonUI().myTextL(
                            text: "emailorphone",
                            textAlign: TextAlign.start),
                        Gap(20,crossAxisExtent: 10,),
                        CommonUI.formField(
                          editingController: _phoneController,
                          hinttext: "",
                          maxLength: 10,
                          enabled: false,
                          prefix: '+91',
                        ),
                        Gap(20,crossAxisExtent: 10,),
                        Row(
                          children: [
                            Spacer(),
                            CommonUI().myText(text: "OTP Sent Successfully",fontSize: 10.sp)
                          ],
                        ),
                        Gap(2.h,crossAxisExtent: 10,),
                        CommonUI().myText(text: "Enter OTP"),
                        Gap(2.h,crossAxisExtent: 10,),
                        otpField(context),
                        Gap(2.h,crossAxisExtent: 10,),

                        Center(child: CommonUI().myText(text: "Haven\'t Received the OTP Yet")),
                        Gap(2.h,crossAxisExtent: 10,),

                        StreamBuilder(
                          stream: _timerStream.stream,
                          builder: (BuildContext ctx,
                              AsyncSnapshot snapshot) {
                            return SizedBox(
                                width: 300,
                                height:40,
                                child: TextButton(
                                  onPressed:
                                  snapshot.data == 0
                                      ? () {
                                    var payload=SendOTP(phoneNumber:widget.phonenumber.toString());
                                    BlocProvider.of<LoginBloc>(context)
                                        .add((SendOTPEvent(payload,context)));
                                    _timerStream
                                        .sink
                                        .add(
                                        30);
                                    activeCounter();
                                  }
                                      : null,
                                  child: Center(
                                      child: snapshot
                                          .data ==
                                          0
                                          ?  CommonUI().myText(text: 'RESEND OTP',fontSize:15,color: AppTheme.primaryColor2)
                                          : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: <
                                            Widget>[
                                          Text(
                                            ' You can resend OTP in  ${snapshot.hasData ? snapshot.data.toString() : 30} seconds ',
                                            style: const TextStyle(
                                                color:
                                                AppTheme.primaryColor2),
                                          ),
                                        ],
                                      )),
                                ));
                          },
                        ),
                        Gap(2.h,crossAxisExtent: 10,),
                        Center(
                          child: CommonUI.buttonContainer(onPressed: () {
                            var payload=VerifyOTP(phoneNumber: _phoneController.text.toString(), otp: _otpEditingController.text.toString());

                            BlocProvider.of<LoginBloc>(context)
                                .add((VerifyOTPEvent(payload,context)));


                          },
                              height: 4.h,width: 30.w,
                              file: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CommonUI().myText(text: "Verify",color: AppTheme.whiteColor)
                                ],
                              )
                            //  text: 'Login',height: 4.h,width: 30.w
                          ),
                        )




                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
      ),
    )

    );
      
      
      

  }
  Widget otpField(BuildContext buildContext) {
    return

      PinCodeTextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        length: 6,
        textStyle: TextStyle(
          color: AppTheme.blackColor,
          fontSize:16,

        ),
        obscureText: false,
        autovalidateMode: AutovalidateMode.disabled,
        animationType: AnimationType.fade,
        cursorColor: AppTheme.primaryColor1,

        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(20), // Set the curved border radius
          borderWidth: 0.5, // Set the border width
          fieldHeight: 50,
          fieldWidth: (60 / 5).w,
          inactiveColor: AppTheme.LightGrey,
          activeColor: AppTheme.primaryColor2,
        ),
        animationDuration: const Duration(milliseconds: 300),
        controller: _otpEditingController,
        onCompleted: (value) {
          var payload=VerifyOTP(phoneNumber: _phoneController.text.toString(), otp: _otpEditingController.text.toString());

          BlocProvider.of<LoginBloc>(buildContext)
              .add((VerifyOTPEvent(payload,buildContext)));

        },
        onChanged: (value) {

        },
        beforeTextPaste: (text) {
          return true;
        },
        appContext: context,
      );
  }
}
