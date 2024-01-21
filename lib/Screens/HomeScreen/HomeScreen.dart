import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/CalenderScreenBloc.dart';
import 'package:uds_employee/Bloc/HomeScreenBloc.dart';
import 'package:uds_employee/Repository/APIToken.dart';

import 'package:uds_employee/Utils/AppAlertController.dart';

import '../../Allnavigations/AllBlocDirectory.dart';
import '../Attendance/Leave/LeaveScreen.dart';
import '../PDFScreen/PdfFileScreen.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  EmployeeData? _employeeData;
  String? pdfPath;
  bool isCheckIn = false;
  HomeShiftDataModel? shiftData;
  String? attendanceId;
  BuildContext? _blocContext;
  String? userId;
  Duration? remainingTime;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();

  }

  getUserId() async{
    print("get un");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id');

    });
    print('userid');
    print(userId);


  }




   String calculateTimer(DateTime shiftTime){

      DateTime now = DateTime.now();
      Duration difference = shiftTime.difference(now);

      setState(() {
        remainingTime = difference;
      });
return remainingTime.toString();

  }
  @override
  Widget build(BuildContext context) {
    return

      BlocProvider(
        create: (context){
          _blocContext=context;
          var bloc=HomeScreenBloc();
          bloc.add(GetOfferLetterevent(context));
          bloc.add(GetCheckinStatusEvent(context));
          return bloc;

         //   HomeScreenBloc()..add(GetCheckinStatusEvent(context));

    },
      child: BlocListener<HomeScreenBloc,HomeScreenState>(
        listener: (context,state){
          _blocContext=context;
          if(state is GetOfferLetterSuccessState){
            _employeeData=EmployeeData.fromJson(state.data['data']);
            print(_employeeData);
            var name=_employeeData!.userData.firstName;
            setName(name);



          }

          if(state is GetCheckInStatusSuccessState){
            print(state.data);
            if(state.data['data'].isNotEmpty){
              isCheckIn=state.data['data']['check_in'];
              if(state.data['data']['attendance_data'] !=null){
                print("object is not null");
                attendanceId=state.data['data']['attendance_data']['id'];
                print('attendanceId');
                print(attendanceId);
              }
              shiftData = HomeShiftDataModel.fromJson(state.data['data']);
            }


          }
          if(state is CheckOutAttendanceSuccessState){
            print('check in data');
            print(state.data);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                DashBoardScreen(index: 0,)));
          }

        },
        child: BlocBuilder<HomeScreenBloc,HomeScreenState>(
          builder: (context,state){
            return
            state is GetOfferLetterSuccessState || state is GetCheckInStatusSuccessState
              ?

              SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    shiftData !=null
                ?


                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset(AppConstant.profileIcon),
                        ),
                        Gap(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CommonUI().myText(text: "Welcome",fontWeight: FontWeight.w500 ,fontSize: 10.sp,letterSpacing: 1),
                            Gap(10),
                            Row(
                              children: [
                                CommonUI().myText(text: _employeeData!.userData.firstName.toString(),fontWeight: FontWeight.w500 ,fontSize: 14.sp,letterSpacing: 0.1),
                                Gap(10),
                                CommonUI().myText(text: _employeeData!.userData.userRole.description.toString(),fontWeight: FontWeight.w600 ,fontSize: 10.sp,letterSpacing: 0.1,color: AppTheme.primaryColor2),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),

                    // Gap(5.h),
                    // CommonUI().myText(text: "Job Offer Letter",fontWeight: FontWeight.w600,fontSize: 13.sp),
                    // Gap(2.h),
                    //  Padding(
                    //    padding: const EdgeInsets.all(8.0),
                    //    child: Container(
                    //    // width: 95.w,
                    //      decoration: BoxDecoration(
                    //        color: AppTheme.whiteColor,
                    //        borderRadius: BorderRadius.circular(5.0),
                    //        boxShadow: [
                    //          BoxShadow(
                    //            color: Colors.grey.withOpacity(0.8),
                    //            // spreadRadius: 1,
                    //            blurRadius: 4,
                    //            offset: const Offset(0,0), // changes the position of the shadow
                    //          ),
                    //        ],
                    //      ),
                    //     child: Padding(
                    //       padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           CommonUI().myText(text: "Name : ${_employeeData!.userData.firstName}"),
                    //           Gap(2.h),
                    //           CommonUI().myText(text: "Job : ${_employeeData!.userData.userRole.description}"),
                    //           Gap(2.h),
                    //           CommonUI().myText(text: "Salary: ${_employeeData!.offerLetter.grossSalary}"),
                    //           Gap(2.h),
                    //           Row(
                    //             mainAxisAlignment:MainAxisAlignment.end,
                    //             children: [
                    //               CommonUI.buttonContainer(
                    //                 height: 3.h,
                    //                   width: 20.w,
                    //
                    //                   onPressed: (){
                    //                     createFileOfPdfUrl()
                    //                         .then((value) {
                    //                       setState(() {
                    //                         pdfPath = value.path;
                    //                       });
                    //                     });
                    //                     AppAlertController()
                    //                         .showProgressIndicator();
                    //
                    //                     Future.delayed(
                    //                         Duration(seconds: 5), () {
                    //                       AppAlertController()
                    //                           .hideProgressIndicator();
                    //                       setState(() {
                    //                         Navigator.of(context).push(
                    //                             CustomPageRoute(
                    //                                 begin: const Offset(
                    //                                     1.0, 0.0),
                    //                                 end: Offset.zero,
                    //                                 duration: 1,
                    //                                 child: PDFScreen(
                    //                                   pdfPath: pdfPath!,
                    //                                 )));
                    //                       });
                    //                     });
                    //
                    //
                    //
                    //                   }, file: Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   Center(child: CommonUI().myText(text: "View",color: AppTheme.whiteColor))
                    //                 ],
                    //               ))
                    //
                    //             ],
                    //           )
                    //
                    //         ],
                    //       ),
                    //     ),
                    // ),
                    //  ),
                    Gap(5.h),
                    shiftData !=null ?   CommonUI().myText(text: "Today Shift",fontWeight: FontWeight.w600,fontSize: 13.sp): SizedBox(),
                    Gap(2.h),
                    shiftData !=null
                    ?


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                     //   width: 95.w,
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0,0), // changes the position of the shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // CommonUI().verticleAlign(width: 1.w),
                                    Image.asset(
                                      AppConstant.timerIcon,
                                      scale: 4,
                                    ),
                                    CommonUI().verticleAlign(width: 1.5.w),
                                    CommonUI().myTextL(
                                        text: "shift",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                    CommonUI().verticleAlign(width: 3.w),
                                    CommonUI().myText(
                                        text: DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(shiftData!.fromTime)).toString(),
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.FontGrey,
                                        fontSize: 11.sp),
                                    Gap(2.w),
                                    CommonUI().myText(text: "To",fontWeight: FontWeight.normal,
                                        color: AppTheme.FontGrey,
                                        fontSize: 9.sp),
                                    Gap(2.w),

                                    CommonUI().myText(
                                        text: DateFormat('hh:mm a').format(DateFormat("HH:mm:ss").parse(shiftData!.endTime)).toString(),
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.FontGrey,
                                        fontSize: 11.sp),
                                    Gap(16.w)
                                  ],
                                ),
                              ),
                              CommonUI().verticleAlign(height: 2.h),
                              Padding(
                                padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 0),
                                child: Row(
                                  children: [
                                    CommonUI().verticleAlign(width: 0.5.w),
                                    Image.asset(
                                      AppConstant.clientIcon,
                                      scale: 3,
                                    ),
                                    CommonUI().verticleAlign(width: 3.w),
                                    CommonUI().myText(
                                        text: "Client",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                    CommonUI().verticleAlign(width: 4.w),
                                    CommonUI().myText(
                                        text: shiftData!.branchData!.clientdData!.clientName.toString(),
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.FontGrey,
                                        fontSize: 12.sp),
                                  ],
                                ),
                              ),
                              CommonUI().verticleAlign(height: 2.h),
                              Padding(
                                padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 0),
                                child: Row(
                                  children: [
                                    CommonUI().verticleAlign(width: 0.5.w),
                                    Image.asset(
                                      AppConstant.locationIcon,
                                      scale: 4,
                                    ),
                                    CommonUI().verticleAlign(width: 3.w),
                                    CommonUI().myTextL(
                                        text: "zone",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                    CommonUI().verticleAlign(width: 4.w),
                                    CommonUI().myText(
                                        text: shiftData!.branchData!.zoneId.zoneName,
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.FontGrey,
                                        fontSize: 12.sp),
                                    CommonUI().myText(text: ",", fontWeight: FontWeight.normal,
                                        color: AppTheme.FontGrey,
                                        fontSize: 12.sp),
                                    CommonUI().myText(
                                        text: shiftData!.branchData!.regionId!.regionName,
                                        fontWeight: FontWeight.normal,
                                        color: AppTheme.FontGrey,
                                        fontSize: 12.sp),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(3.w, 1.h, 2.w, 2.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CommonUI().myText(
                                        text: "3 hrs 25 minutes",
                                        fontSize: 10.sp,
                                        color: AppTheme.FontGrey,
                                        fontWeight: FontWeight.normal),
                                  ],
                                ),
                              ),
                              CommonUI.buttonContainer(
                                  height: 4.h,
                                  width: 70.w,
                                  onPressed: (){

                                   isCheckIn==false? Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraScreen()))
                                   :
                                   showDialog<bool>(
                                               context: context,
                                               builder: (context) {
                                                 return AlertDialog(
                                                   shape: const RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                   title: CommonUI().myText(
                                                       text: 'UDS',
                                                       textAlign: TextAlign.center,
                                                       color: AppTheme.primaryColor2),
                                                   actionsAlignment: MainAxisAlignment.end,
                                                   content: CommonUI().myText(
                                                       text: 'Do you want to do OverTime!!',
                                                       fontWeight: FontWeight.normal,
                                                       textAlign: TextAlign.center,
                                                       color: AppTheme.primaryColor2,
                                                       maxLines: 2),
                                                   actions: [
                                                     TextButton(
                                                       onPressed: () {
                                                         DateTime now = DateTime.now();
                                                         String currentTime;
                                                        // currentTime = "${now.hour}:${now.minute}:${now.second}";
                                                         // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                                         var payload=OverTime(date: DateTime.now().toString().split(" ")[0], year: DateTime.now().year.toString(), month: DateTime.now().month.toString(), overDue: true);
                                                       //  CalenderBloc().add(CheckOutAttendanceEvent(attendanceId!,payload , context));
                                                         //HomeScreenBloc().add(CheckOutAttendanceEvent(attendanceId!,payload , context));
                                                         BlocProvider.of<HomeScreenBloc>(_blocContext!).add(CheckOutAttendanceEvent(attendanceId!,payload , context));

                                                       },
                                                       child: CommonUI().myText(
                                                         text: 'Yes',
                                                       ),
                                                     ),
                                                     TextButton(
                                                       onPressed: () {
                                                         // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                                         DateTime now = DateTime.now();
                                                         String currentTime;
                                                          currentTime = "${now.hour}:${now.minute}:${now.second}";
                                                          print('currentTime');
                                                          print(currentTime);
                                                          var payload=CheckOut(date:  DateTime.now().toString().split(" ")[0], year: DateTime.now().year.toString(), month: DateTime.now().month.toString(), checkOutTime: DateTime.now().toString());

                                                      //   HomeScreenBloc().add(CheckOutAttendanceEvent(attendanceId!,payload , context));
                                                         BlocProvider.of<HomeScreenBloc>(_blocContext!).add(CheckOutAttendanceEvent(attendanceId!,payload , context));

                                                        // CalenderBloc().add(CheckOutAttendanceEvent(attendanceId!,payload , context));
                                                       },
                                                       child: CommonUI().myText(
                                                         text: 'No',
                                                       ),
                                                     ),
                                                   ],
                                                 );
                                               },
                                             );

                                  }, file: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isCheckIn==false?
                                  CommonUI().myText(text: "Check-In",
                                    color: AppTheme.whiteColor

                                  )
                                  :
                                  CommonUI().myText(text: "Check-Out",
                                      color: AppTheme.whiteColor

                                  )
                                  ,
                                  Gap(1.w),
                                  Image.asset(AppConstant.rightArrowIcon, color: AppTheme.whiteColor, scale: 3,)
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ) : SizedBox(),
                    Gap(4.h),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveScreen(userId: userId,)));

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                        //  width: 90.w,
                          decoration: BoxDecoration(
                            color: AppTheme.whiteColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                // spreadRadius: 1,
                                blurRadius: 4,
                                offset: const Offset(0,0), // changes the position of the shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Gap(2.w),
                               CommonUI().myText(text: "APPLY LEAVE"),
                                Spacer(),
                                Image.asset(AppConstant.rightArrowIcon,scale: 2,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(4.h),
                    // CommonUI().myText(text: "LEAVE STATUS"),
                    //
                    // Gap(2.h),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     //  width: 90.w,
                    //     decoration: BoxDecoration(
                    //       color: AppTheme.whiteColor,
                    //       borderRadius: BorderRadius.circular(5.0),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.8),
                    //           // spreadRadius: 1,
                    //           blurRadius: 4,
                    //           offset: const Offset(0,0), // changes the position of the shadow
                    //         ),
                    //       ],
                    //     ),
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Gap(2.w),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             children: [
                    //               CommonUI().myText(text: "Casual Leave"),
                    //               Gap(2.w),
                    //               CommonUI().myText(text: "12-01-2024",fontSize: 9.sp),
                    //             ],
                    //           ),
                    //           Spacer(),
                    //          CommonUI.buttonContainer(
                    //            height: 3.5.h,
                    //              width: 20.w,
                    //              gradientsecond: AppTheme.primaryColor2,
                    //              gradientfirst: AppTheme.primaryColor2,
                    //
                    //
                    //              onPressed: (){}, file: Row(
                    //            mainAxisAlignment: MainAxisAlignment.center,
                    //            crossAxisAlignment: CrossAxisAlignment.center,
                    //            children: [
                    //              CommonUI().myText(text: 'Pending',color: AppTheme.whiteColor,fontSize: 9.sp)
                    //            ],
                    //
                    //          ))
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),



                  ],
                ) : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    Row(
                    children: [
                    CircleAvatar(
                    child: Image.asset(AppConstant.profileIcon),
              ),
                Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonUI().myText(text: "Welcome",fontWeight: FontWeight.w500 ,fontSize: 10.sp,letterSpacing: 1),
                    Gap(10),
                    Row(
                      children: [
                        CommonUI().myText(text: _employeeData!.userData.firstName.toString(),fontWeight: FontWeight.w500 ,fontSize: 14.sp,letterSpacing: 0.1),
                        Gap(10),
                        CommonUI().myText(text: _employeeData!.userData.userRole.description.toString(),fontWeight: FontWeight.w600 ,fontSize: 10.sp,letterSpacing: 0.1,color: AppTheme.primaryColor2),
                      ],
                    ),
                  ],
                )
                ],
              ),

            Gap(5.h),
            CommonUI().myText(text: "Job Offer Letter",fontWeight: FontWeight.w600,fontSize: 13.sp),
            Gap(2.h),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
               // width: 95.w,
                 decoration: BoxDecoration(
                   color: AppTheme.whiteColor,
                   borderRadius: BorderRadius.circular(5.0),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.withOpacity(0.8),
                       // spreadRadius: 1,
                       blurRadius: 4,
                       offset: const Offset(0,0), // changes the position of the shadow
                     ),
                   ],
                 ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonUI().myText(text: "Name : ${_employeeData!.userData.firstName}"),
                      Gap(2.h),
                      CommonUI().myText(text: "Job : ${_employeeData!.userData.userRole.description}"),
                      Gap(2.h),
                      CommonUI().myText(text: "Salary: ${_employeeData!.offerLetter.grossSalary}"),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.end,
                        children: [
                          CommonUI.buttonContainer(
                            height: 3.h,
                              width: 20.w,

                              onPressed: (){
                                createFileOfPdfUrl()
                                    .then((value) {
                                  setState(() {
                                    pdfPath = value.path;
                                  });
                                });
                                AppAlertController()
                                    .showProgressIndicator();

                                Future.delayed(
                                    Duration(seconds: 5), () {
                                  AppAlertController()
                                      .hideProgressIndicator();
                                  setState(() {
                                    Navigator.of(context).push(
                                        CustomPageRoute(
                                            begin: const Offset(
                                                1.0, 0.0),
                                            end: Offset.zero,
                                            duration: 1,
                                            child: PDFScreen(
                                              pdfPath: pdfPath!,
                                            )));
                                  });
                                });



                              }, file: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: CommonUI().myText(text: "View",color: AppTheme.whiteColor))
                            ],
                          ))

                        ],
                      )

                    ],
                  ),
                ),
            ),
             ),
          ]
                    ),
              ),
            )

                :Image.asset(AppConstant.noDataIcon);
          },
        ),
      ),
    );



  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print(_employeeData!.offerLetter.letterId.mediaUrl);
    print(_employeeData!.offerLetter.letterId.mediaUrl);
    try {
      final url = _employeeData!.offerLetter.letterId.mediaUrl;
      final filename = url?.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url!));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');

    }

    return completer.future;
  }
}
