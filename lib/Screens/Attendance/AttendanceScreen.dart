import 'package:sizer/sizer.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Screens/Attendance/Leave/LeaveScreen.dart';
import 'package:uds_employee/Screens/Attendance/OnDuty/OnDutyScreen.dart';
import 'package:uds_employee/Screens/Attendance/cameraFile.dart';


import '../../Allnavigations/AllBlocDirectory.dart';
import '../newcalenderFile.dart';
import 'Permission/PermissionScreen.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderScreen(value: 'Calender')));
              },
              child: Container(
                width: 90.w,
                decoration:  BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: AppTheme.themeLightGrey,width: 0.3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      //spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "Calender",fontWeight: FontWeight.w600,letterSpacing: 0.6),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(2.h),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveScreen()));
              },
              child: Container(
                width: 90.w,
                decoration:  BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: AppTheme.themeLightGrey,width: 0.3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      //spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "Leave",fontWeight: FontWeight.w600,letterSpacing: 0.6),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(2.h),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const PermissionScreen()));
              },
              child: Container(
                width: 90.w,
                decoration:  BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: AppTheme.themeLightGrey,width: 0.3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      //spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "Permission",fontWeight: FontWeight.w600,letterSpacing: 0.6),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(2.h),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>OnDutyScreen()));
              },
              child: Container(
                width: 90.w,
                decoration:  BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: AppTheme.themeLightGrey,width: 0.3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      //spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 0), // changes the position of the shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "ON Duty",fontWeight: FontWeight.w600,letterSpacing: 0.6  ),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(1.h),

          ],
        ),
      ),
    );
  }
}
