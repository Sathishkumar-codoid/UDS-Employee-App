import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';
import 'LeaveApply.dart';
import 'LeaveHistory.dart';
import 'LeaveHistoryDetails.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({Key? key}) : super(key: key);

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.whiteColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
            CommonUI().myText(text: "LEAVE")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildhours(),
              Gap(1.h),
              _buildLeave(context),
              Gap(2.h),
              Row(
                children: [
                  Spacer(),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveHistoryScreen()));
                      },
                      child: CommonUI().myText(text: "VIEW LEAVE HISTORY",fontSize: 10.sp,color: AppTheme.buttonColor)),
                  Gap(2.h),
                ],
              ),
              Gap(5.h),
              Row(
                children: [
                  Spacer(),

                  Material(
                    elevation: 5,
                    color: Colors.transparent,
                    child: CommonUI.buttonContainer(
                        height: 4.h,
                        width: 30.w,
                        gradientfirst: AppTheme.buttonColor,
                        gradientsecond: AppTheme.buttonColor,
                        onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveApplyScreen()));
                        }, file: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonUI().myText(text: "APPLY",color: AppTheme.whiteColor,fontSize: 10.sp)

                      ],)),
                  ),
                  Gap(2.h),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildhours() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //height: 10.h,
        //   width: 90.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primaryColor2, AppTheme.primaryColor1],
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Gap(1.h),
              Row(
                children: [
                  CommonUI().myText(
                      text: "Available Leaves",
                      color: AppTheme.whiteColor,
                      fontSize: 11.sp),
                  Spacer(),
                  CommonUI().myText(
                      text: '12 ', fontSize: 16.sp, color: AppTheme.whiteColor),
                  CommonUI().myText(
                      text: '/15 Days',
                      fontSize: 10.sp,
                      color: AppTheme.whiteColor),
                  Gap(1.h)
                ],
              ),
              Gap(3.h),
              Row(
                children: [
                  CommonUI().myText(
                      text: "Valid Until",
                      color: AppTheme.whiteColor,
                      fontSize: 11.sp),
                  Spacer(),
                  CommonUI().myText(
                      text: '31-09-2024',
                      fontSize: 12.sp,
                      color: AppTheme.whiteColor),
                  //CommonUI().myText(text: '/ 15 Days',fontSize: 10.sp,color: AppTheme.whiteColor),
                ],
              ),
              Gap(1.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeave(BuildContext context){

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonUI().myText(text: "Pending"),
          Gap(1.h),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context,index){
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100]!,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        offset: Offset(0, 3), // Changes the shadow position
                      ),
                    ],
                  ),

                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonUI().myText(text: "Casual Leave",fontSize: 11.sp,fontWeight:FontWeight.w500),
                                  Gap(1.h),
                                  CommonUI().myText(text: "05-01-2024",color: AppTheme.primaryColor2,fontSize: 11.sp,fontWeight:FontWeight.w500   ),

                                ],
                              ),
                              Spacer(),

                              Material(
                                elevation: 5,
                                color: Colors.transparent,
                                child: CommonUI.buttonContainer(
                                    height: 3.h,
                                    gradientfirst: AppTheme.primaryColor2,
                                    gradientsecond:AppTheme.primaryColor2 ,
                                    width: 20.w,

                                    onPressed: (){


                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveHistoryDetails()));
                                    }, file: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonUI().myText(text: "VIEW",color: AppTheme.whiteColor,fontSize: 9.sp)
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                        Gap(1.h),
                        const Divider(
                          endIndent: 0,
                          indent: 0,
                          color: Colors.black,
                          thickness: 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CommonUI().myText(text: 'Applied Date',fontSize: 9.sp,fontWeight: FontWeight.w600),
                              Gap(1.w),
                              CommonUI().myText(text: '05-01-2024',color: AppTheme.FontGrey,fontWeight: FontWeight.w500,fontSize: 9.sp),
                              Spacer(),
                              CommonUI().myText(text: 'Status',fontSize: 9.sp,fontWeight: FontWeight.w600),
                              Gap(1.w),
                              CommonUI().myText(text: 'Pending',color: AppTheme.primaryColor1,fontWeight: FontWeight.w500,fontSize: 9.sp),



                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                );


              }),
        ],
      ),
    );
  }
}
