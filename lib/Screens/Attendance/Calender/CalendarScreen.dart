import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/PermissionBloc.dart';
import 'package:uds_employee/Screens/Attendance/cameraFile.dart';
import 'package:uds_employee/Utils/AppThemeManager.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';
import '../../../Bloc/CalenderScreenBloc.dart';
import '../Leave/LeaveApply.dart';

class CalenderScreen extends StatefulWidget {
  CalenderScreen({Key? key, required this.value, this.leaveType,this.leaveTypeID})
      : super(key: key);
  String value;
  String? leaveType;
  String? leaveTypeID;

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  String _selectedDate = DateTime.now().toString();
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  TextEditingController _dutyController = TextEditingController();
  TextEditingController _permissionFromController = TextEditingController();
  TextEditingController _permissionToController = TextEditingController();
  List<GetCalenderData> calenderDataList = [];
  bool viweCalendar = false;
  int? changedmonth;
  int? changedYear;
  DateRangePickerController? _controller;
  DateTime? _initialDisplayDate;
  int count = 1;
  int dateofmONTH = DateTime.now().month;
  String userId='';


  @override
  void initState() {
    super.initState();
    selecteddate.clear();
    _selectedDate = DateTime.now().toString();
    _controller = DateRangePickerController();
    _initialDisplayDate = DateTime.now();
    getUserId();
  }

  getUserId() async{
    print("get un");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('id')!;

    });
    print('userid');
    print(userId);

  }


  List<DateTime> selecteddate = [];
  List<DateTime> presentDates = [];

  List<DateTime> absentDates = [];

  List<DateTime> weekOffDates = [];

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = args.value.startDate != null
            ? '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}'
            : '';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();

        selecteddate.clear();

        selecteddate.add(args.value);

        if (DateTime.now().toString().split(' ')[0] ==
            _selectedDate.toString().split(' ')[0]) {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => CameraScreen()));
        }
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
        selecteddate.clear();
        selecteddate.addAll(args.value);
        //   selecteddate.re
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return CalenderBloc()
            ..add(GetCalenderEvent(context, DateTime.now().year.toString(),
                DateTime.now().month.toString()));
        },
        child: BlocListener<CalenderBloc, CalenderState>(listener:
            (context, state) {
          if (state is GetCalenderSuccessState) {
            calenderDataList.clear();
            presentDates.clear();
            absentDates.clear();
            weekOffDates.clear();
            for (int i = 0; i < state.data['data'].length; i++) {
              calenderDataList
                  .add(GetCalenderData.fromJson(state.data['data']['data'][i]));
            }

            for (int i = 0; i < calenderDataList.length; i++) {
              if (calenderDataList[i].present) {
                presentDates.add(calenderDataList[i].date);
              }
              if (calenderDataList[i].leave) {
                absentDates.add(calenderDataList[i].date);
              }
              if (calenderDataList[i].weekoff) {
                weekOffDates.add(calenderDataList[i].date);
              }
            }
          }
        }, child:
            BlocBuilder<CalenderBloc, CalenderState>(builder: (context, state) {
          return

              // state is GetCalenderLoadingState
              //   ?
              // _buildShimmer(context)
              // :
              state is GetCalenderSuccessState
                  ? Scaffold(
                      backgroundColor: AppTheme.whiteColor,
                      appBar: AppBar(
                        elevation: 0,
                        backgroundColor: AppTheme.whiteColor,
                        automaticallyImplyLeading: false,
                        title: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CommonUI().myText(
                                text: 'CALENDER',
                                textAlign: TextAlign.start,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                letterSpacing: 0.2),
                          ],
                        ),
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 95.w,
                                  height: 50.h,
                                  child: Card(
                                    elevation: 2,
                                    shadowColor: AppTheme.themeLightGrey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: const BorderSide(
                                            color: AppTheme.themeLightGrey,
                                            width: 0.1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SfDateRangePicker(
                                        viewSpacing: 0.1,
                                        headerHeight: 40,
                                        controller: _controller,
                                        todayHighlightColor:
                                            AppTheme.todayColor,
                                        selectionShape:
                                            DateRangePickerSelectionShape
                                                .rectangle,
                                        selectionColor: AppTheme.todayColor,
                                        showNavigationArrow: true,
                                        allowViewNavigation: false,
                                        initialDisplayDate: _initialDisplayDate,

                                        onViewChanged:
                                            (DateRangePickerViewChangedArgs
                                                args) {
                                          viweCalendar = true;
                                          DateTime? visibleStartDate =
                                              args.visibleDateRange.startDate;
                                          DateTime? visibleEndDate =
                                              args.visibleDateRange.endDate;
                                          int month = visibleEndDate!.month;
                                          int year = visibleEndDate.year;
                                          changedYear = year;
                                          changedmonth = month;
                                          _initialDisplayDate =
                                              args.visibleDateRange.startDate!;

                                          if (dateofmONTH != month) {
                                            dateofmONTH =
                                                month; // Update the current month
                                            BlocProvider.of<CalenderBloc>(
                                                    context)
                                                .add(GetCalenderEvent(
                                                    context,
                                                    year.toString(),
                                                    month.toString()));
                                          }

                                          // if(DateTime.now().month !=month){
                                          //   dateofmONTH=month;
                                          //   if (dateofmONTH == month) {
                                          //     if(count==1){
                                          //       BlocProvider.of<CalenderBloc>(context)
                                          //           .add(GetCalenderEvent(context, year.toString(), month.toString()));
                                          //     }
                                          //
                                          //   }
                                          // }
                                          //
                                          // if (dateofmONTH != month) {
                                          //   BlocProvider.of<CalenderBloc>(context)
                                          //       .add(GetCalenderEvent(context, year.toString(), month.toString()));
                                          // }
                                        },

                                        headerStyle: DateRangePickerHeaderStyle(
                                            textAlign: TextAlign.center,
                                            textStyle: TextStyle(
                                                color: AppTheme.primaryColor2,
                                                fontSize: 15.sp)),
                                        // showActionButtons:true,

                                        onSelectionChanged: _onSelectionChanged,
                                        cellBuilder: _buildCellWidget,
                                        selectionMode: widget.value == "Leave"
                                            ? DateRangePickerSelectionMode
                                                .multiple
                                            : DateRangePickerSelectionMode
                                                .single,
                                        initialSelectedRange: PickerDateRange(
                                            DateTime.now().subtract(
                                                const Duration(days: 4)),
                                            DateTime.now()
                                                .add(const Duration(days: 3))),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Gap(2.h),
                            Padding(
                              padding: EdgeInsets.fromLTRB(3.h, 1.h, 1.h, 1.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    AppConstant.presentIcon,
                                    scale: 3,
                                  ),
                                  Gap(2.w),
                                  CommonUI()
                                      .myText(text: "Present", fontSize: 10.sp),
                                  Gap(4.w),
                                  Image.asset(
                                    AppConstant.absentIcon,
                                    scale: 3,
                                  ),
                                  Gap(2.w),
                                  CommonUI()
                                      .myText(text: "Absent", fontSize: 10.sp),
                                  Gap(4.w),
                                  Image.asset(
                                    AppConstant.weekOffIcon,
                                    scale: 3,
                                  ),
                                  Gap(2.w),
                                  Gap(2.w),
                                  CommonUI()
                                      .myText(text: "Week_off", fontSize: 10.sp)
                                ],
                              ),
                            ),
                            Gap(2.h),
                            // _buildCalender(),
                            widget.value == 'Calender'
                                ? _buildCalender()
                                : widget.value == 'Permission'
                                    ? _buildPermission()
                                    : widget.value == "Leave"
                                        ? _buildLeave(context)
                                        : _buildOnDuty(),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      color: AppTheme.whiteColor,
                      child: Image.asset(AppConstant.noDataIcon));
        })));
  }

  Widget _buildoverAllCalendar(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CalenderBloc()
          ..add(GetCalenderEvent(context, DateTime.now().year.toString(),
              DateTime.now().month.toString()));
      },
      child: BlocListener<CalenderBloc, CalenderState>(
        listener: (context, state) {
          if (state is GetCalenderSuccessState) {
            count = 2;
            calenderDataList.clear();
            for (int i = 0; i < state.data['data'].length; i++) {
              calenderDataList
                  .add(GetCalenderData.fromJson(state.data['data'][i]));
            }
            presentDates.clear();
            absentDates.clear();
            weekOffDates.clear();
            for (int i = 0; i < calenderDataList.length; i++) {
              if (calenderDataList[i].present) {
                presentDates.add(calenderDataList[i].date);
              }
              if (calenderDataList[i].leave) {
                absentDates.add(calenderDataList[i].date);
              }
              if (calenderDataList[i].weekoff) {
                weekOffDates.add(calenderDataList[i].date);
              }
            }
          }
        },
        child: BlocBuilder<CalenderBloc, CalenderState>(
          builder: (context, state) {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {});
            });

            return state is GetCalenderSuccessState
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 95.w,
                        height: 50.h,
                        child: Card(
                          elevation: 2,
                          shadowColor: AppTheme.themeLightGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: const BorderSide(
                                  color: AppTheme.themeLightGrey, width: 0.1)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SfDateRangePicker(
                              viewSpacing: 0.1,
                              headerHeight: 40,
                              controller: _controller,
                              todayHighlightColor: AppTheme.todayColor,
                              selectionShape:
                                  DateRangePickerSelectionShape.rectangle,
                              selectionColor: AppTheme.todayColor,
                              showNavigationArrow: true,
                              allowViewNavigation: false,
                              initialDisplayDate: _initialDisplayDate,

                              onViewChanged:
                                  (DateRangePickerViewChangedArgs args) {
                                viweCalendar = true;
                                DateTime? visibleStartDate =
                                    args.visibleDateRange.startDate;
                                DateTime? visibleEndDate =
                                    args.visibleDateRange.endDate;
                                int month = visibleEndDate!.month;
                                int year = visibleEndDate.year;
                                changedYear = year;
                                changedmonth = month;
                                _initialDisplayDate =
                                    args.visibleDateRange.startDate!;

                                if (dateofmONTH != month) {
                                  dateofmONTH =
                                      month; // Update the current month
                                  BlocProvider.of<CalenderBloc>(context).add(
                                      GetCalenderEvent(context, year.toString(),
                                          month.toString()));
                                }

                                // if(DateTime.now().month !=month){
                                //   dateofmONTH=month;
                                //   if (dateofmONTH == month) {
                                //     if(count==1){
                                //       BlocProvider.of<CalenderBloc>(context)
                                //           .add(GetCalenderEvent(context, year.toString(), month.toString()));
                                //     }
                                //
                                //   }
                                // }
                                //
                                // if (dateofmONTH != month) {
                                //   BlocProvider.of<CalenderBloc>(context)
                                //       .add(GetCalenderEvent(context, year.toString(), month.toString()));
                                // }
                              },

                              headerStyle: DateRangePickerHeaderStyle(
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(
                                      color: AppTheme.primaryColor2,
                                      fontSize: 15.sp)),
                              // showActionButtons:true,

                              onSelectionChanged: _onSelectionChanged,
                              cellBuilder: _buildCellWidget,
                              selectionMode: widget.value == "Leave"
                                  ? DateRangePickerSelectionMode.multiple
                                  : DateRangePickerSelectionMode.single,
                              initialSelectedRange: PickerDateRange(
                                  DateTime.now()
                                      .subtract(const Duration(days: 4)),
                                  DateTime.now().add(const Duration(days: 3))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: AppTheme.whiteColor,
                    child: Image.asset(AppConstant.noDataIcon),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildCellWidget(
      BuildContext context, DateRangePickerCellDetails cellDetails) {
    bool isPresent = presentDates.contains(cellDetails.date);
    bool isAbsent = absentDates.contains(cellDetails.date);
    bool isWeekOff = weekOffDates.contains(cellDetails.date);
    bool isSelected = selecteddate.contains(cellDetails.date);

    //bool isselected?
    if (isPresent) {
      return Container(
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.presentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          cellDetails.date.day.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      );
    } else if (isAbsent) {
      return Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppTheme.absentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          cellDetails.date.day.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      );
    } else if (isWeekOff) {
      return Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppTheme.weekOffColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          cellDetails.date.day.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      );
    } else {
      // Default styling for other dates
      return Container(
        margin: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.todayColor : AppTheme.calendarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          cellDetails.date.day.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      );
    }
  }

  Widget _buildCalender() {
    return Container(
      height: 35.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: AppTheme.attendanceColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(2.h),
            CommonUI().myText(
                text: "Working Attendance",
                fontSize: 15.sp,
                fontWeight: FontWeight.w600),
            Gap(1.h),
            CommonUI().myText(
                text: "Current Month Working Attendance Report",
                fontSize: 10.sp,
                color: AppTheme.attendanceTextColor),
            Gap(4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUI().myText(
                    text: "Present Days of Month ",
                    fontWeight: FontWeight.w500),
                Spacer(),
                CommonUI().myText(
                    text: presentDates.length.toString(),
                    color: AppTheme.primaryColor1,
                    fontWeight: FontWeight.w600),
                Gap(4.w),
              ],
            ),
            Gap(2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUI()
                    .myText(text: "Absentees", fontWeight: FontWeight.w500),
                Spacer(),
                CommonUI().myText(
                    text: absentDates.length.toString(),
                    color: AppTheme.primaryColor1,
                    fontWeight: FontWeight.w600),
                Gap(4.w),
              ],
            ),
            Gap(2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUI()
                    .myText(text: "Week off ", fontWeight: FontWeight.w500),
                Spacer(),
                CommonUI().myText(
                    text: weekOffDates.length.toString(),
                    color: AppTheme.primaryColor1,
                    fontWeight: FontWeight.w600),
                Gap(4.w),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _buildOnDuty() {
    return Container(
      height: 40.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: AppTheme.attendanceColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(2.h),
            Row(
              children: [
                Image.asset(
                  AppConstant.dateIcon,
                  scale: 2,
                ),
                Gap(3.w),
                CommonUI().myText(text: '8th Novermber 2023'),
              ],
            ),
            Gap(2.h),
            Row(
              children: [
                Image.asset(
                  AppConstant.timerIcon,
                  scale: 3,
                ),
                Gap(3.w),
                CommonUI().myText(text: 'Shift Timing'),
                Gap(1.w),
                CommonUI().myText(
                    text: '8.00am to 4.00pm', color: AppTheme.primaryColor2),
              ],
            ),
            Gap(4.h),
            CommonUI().myText(text: "Purpose", fontSize: 12.sp),
            Card(
              color: AppTheme.whiteColor,
              child: SizedBox(
                child: CommonUI.textAreaFormField(
                    maxLines: 5,
                    editingController: _dutyController,
                    hinttext: ''),
              ),
            ),
            Gap(2.h),
            Center(
              child: CommonUI.buttonContainer(
                  gradientsecond: AppTheme.buttonColor,
                  gradientfirst: AppTheme.buttonColor,
                  height: 4.h,
                  width: 80.w,
                  onPressed: () {},
                  file: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonUI().myText(
                          text: "REQUEST ON DUTY",
                          color: AppTheme.whiteColor,
                          fontSize: 10.sp),
                      Gap(2.h),
                      Image.asset(
                        AppConstant.frontarrowIcon,
                        scale: 3,
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPermission() {
    return
    BlocProvider(create: (context){
      var bloc=PermissionBloc();
     // bloc.add(PermissionApplyEvent(context, payload))

      return bloc;
    },
    child: BlocListener<PermissionBloc,PermissionState>(
      listener: (context,state){
        if(state is PermissionApplySuccessState){
          print(state);
          print(state.data);
      }
      },
      child: BlocBuilder<PermissionBloc,PermissionState>(
        builder: (context,state){
          return   Container(
            //height: 40.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: AppTheme.attendanceColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(2.h),
                  Row(
                    children: [
                      Image.asset(
                        AppConstant.dateIcon,
                        scale: 2,
                      ),
                      Gap(3.w),
                      CommonUI().myText(text: '8th Novermber 2023'),
                    ],
                  ),
                  Gap(2.h),
                  Row(
                    children: [
                      Image.asset(
                        AppConstant.timerIcon,
                        scale: 3,
                      ),
                      Gap(3.w),
                      CommonUI().myText(text: 'Shift Timing'),
                      Gap(1.w),
                      CommonUI().myText(
                          text: '8.00am to 4.00pm', color: AppTheme.primaryColor2),
                    ],
                  ),
                  Gap(2.h),
                  CommonUI().myText(text: "PERMISSION"),
                  Gap(2.h),
                  CommonUI().myText(text: "Timing", fontSize: 10.sp),
                  Gap(2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 40.w,
                          child: CommonUI.textAreaFormField(
                              editingController: _permissionFromController,
                              hinttext: "")),
                      Gap(2.h),
                      CommonUI().myText(text: "TO"),
                      Gap(2.h),
                      SizedBox(
                          width: 40.w,
                          child: CommonUI.textAreaFormField(
                              editingController: _permissionToController,
                              hinttext: ""))
                    ],
                  ),
                  Gap(4.h),
                  CommonUI().myText(text: "Note", fontSize: 12.sp),
                  Card(
                    color: AppTheme.whiteColor,
                    child: SizedBox(
                      child: CommonUI.textAreaFormField(
                          maxLines: 5,
                          editingController: _dutyController,
                          hinttext: ''),
                    ),
                  ),
                  Gap(2.h),
                  Center(
                    child: CommonUI.buttonContainer(
                        gradientsecond: AppTheme.buttonColor,
                        gradientfirst: AppTheme.buttonColor,
                        height: 4.h,
                        width: 80.w,
                        onPressed: () {
                          var payload=PermissionApply(fromTime: _permissionFromController.text, toTime: _permissionToController.text, notes: _dutyController.text, userId: userId, fromdate: _selectedDate.toString().toString().split(' ')[0]);
                          BlocProvider.of<PermissionBloc>(context).add(PermissionApplyEvent(context, payload));


                        },
                        file: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonUI().myText(
                                text: "REQUEST PERMISSION",
                                color: AppTheme.whiteColor,
                                fontSize: 10.sp),
                          ],
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
      ),
    );



  }

  Widget _buildLeave(BuildContext context) {
    return Container(
        //height: 40.h,
        width: 100.w,
        decoration: BoxDecoration(
            color: AppTheme.attendanceColor.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selecteddate.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppConstant.dateIcon,
                                scale: 3,
                              ),
                              Gap(2.h),
                              CommonUI().myText(
                                  text:
                                      " ${selecteddate[index].day} th November 2023"),
                            ],
                          ),
                          Gap(2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                AppConstant.timerIcon,
                                scale: 3,
                              ),
                              Gap(2.h),
                              CommonUI().myText(text: "Shift Timing"),
                              Gap(1.h),
                              CommonUI().myText(
                                  text: "8.00am to 4.00pm",
                                  color: AppTheme.primaryColor2),
                            ],
                          ),
                          const Divider(
                            color: AppTheme.themeDarkGrey,
                          )
                        ],
                      ),
                    );
                  }),
              CommonUI.buttonContainer(
                  height: 4.h,
                  width: 90.w,
                  gradientfirst: AppTheme.primaryColor2,
                  gradientsecond: AppTheme.primaryColor2,
                  onPressed: () {
                    selecteddate.isNotEmpty
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LeaveApplyScreen(
                                      date: selecteddate,
                                      leaveType: widget.leaveType, userId: userId,leaveTypeId: widget.leaveTypeID,
                                    )))
                        : SizedBox();
                  },
                  file: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonUI().myText(
                          text: "SELECT DATE",
                          color: AppTheme.whiteColor,
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w600),
                      Gap(2.h),
                      Image.asset(
                        AppConstant.frontarrowIcon,
                        scale: 3,
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: (Colors.grey)!,
      highlightColor: (Colors.grey)!,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5, // Number of shimmering items
        itemBuilder: (context, index) {
          return Material(
            type: MaterialType.card,
            color: AppTheme.whiteColor,
            child: ListTile(
              title: Container(
                width: double.infinity,
                height: 15.h,
                color: Colors.white, // Placeholder color
              ),
            ),
          );
        },
      ),
    );
  }
}
