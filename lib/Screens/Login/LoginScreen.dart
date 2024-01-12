

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/LoginBloc.dart';
import 'package:uds_employee/Screens/DashBoard/DashBoardScreen.dart';
import 'package:uds_employee/Screens/Login/OTPScreen.dart';


import '../../Allnavigations/AllBlocDirectory.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController _controllerPhone=TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();

  bool _obscureText=false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc();

        },
      child: BlocListener<LoginBloc,LoginState>(
        listener: (context,state){
          if(state is SendOTPSuccessState){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(phonenumber: _controllerPhone.text.toString(),)));


          }
        },
        child: BlocBuilder<LoginBloc,LoginState>(
          builder: (context,state){
            return     Scaffold(
              body:
              SingleChildScrollView(
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
                      child:Form(
                        key:formKey ,
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
                                  editingController: _controllerPhone,
                                  hinttext: "",
                                  maxLength: 10,
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.number,
                                  validator:
                                      (value) {
                                    if (value!.isNotEmpty && value.length==10) {
                                      return null;
                                    }


                                    return "Please Enter valid Email or PhoneNumber";
                                  }
                              ),
                              Gap(10.h,crossAxisExtent: 10,),

                              Center(
                                child: CommonUI.buttonContainer(onPressed: () {
                                  var form=formKey.currentState;

                                  if (form?.validate() ?? true) {
                                    var payload=SendOTP(phoneNumber: _controllerPhone.text.toString());
                                    BlocProvider.of<LoginBloc>(context)
                                        .add((SendOTPEvent(payload,context)));

                                  }

                                },
                                    height: 4.h,width: 30.w,
                                    file: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CommonUI().myText(text: "Send OTP",color: AppTheme.whiteColor)
                                      ],
                                    )
                                  //  text: 'Login',height: 4.h,width: 30.w
                                ),
                              )

                            ],
                          ),
                        ),
                      ) ,
                    ),





                  ],
                ),
              ),
            ) ;
          },
        ),
      ),


    );




   }



}
