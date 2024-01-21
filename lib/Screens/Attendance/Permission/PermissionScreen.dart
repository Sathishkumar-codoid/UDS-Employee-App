import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/PermissionBloc.dart';
import 'package:uds_employee/Screens/Attendance/Permission/permissionHistory.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';
import 'PermissionDetails.dart';

class PermissionScreen extends StatefulWidget {
   PermissionScreen({Key? key,required this.userID}) : super(key: key);
   String userID;

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  
  String? totalPermission;
  String? pendingPermission;
  String? validPermission;
  
  @override
  Widget build(BuildContext context) {
    return
    BlocProvider(create: (context){
      var bloc=PermissionBloc();
      bloc.add(PermissionHistoryEvent("pending", widget.userID, context));
      return bloc;

    },
      child: BlocListener<PermissionBloc,PermissionState>(
        listener: (context,state){
          if(state is PermissionHistorySuccessState){
            print(state);
            print(state.data);
            totalPermission=state.data['data']['total_permissions'].toString();
            pendingPermission=state.data['data']['pending_permissions'].toString();
            validPermission=state.data['data']['permissions_valid_until'].toString();
            
          }
        },
        child: BlocBuilder<PermissionBloc,PermissionState>(
          builder: (context,state){
            return    
            state is PermissionHistorySuccessState
              ?
              
              Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: AppTheme.whiteColor,
                title: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    Gap(2.h),
                    CommonUI().myText(text: "PERMISSION")
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildhours(),
                    Gap(4.h),
                    _buildpermission(context),
                    Gap(2.h),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PermissionHistory()));
                            },
                            child: CommonUI().myText(text: "VIEW PERMISSION HISTORY",fontSize: 10.sp,color: AppTheme.buttonColor)),
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

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderScreen(value: 'Permission')));
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
            )
            : _buildShimmer(context)
                
            ;
          },
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
                      text: "Available Permission hours",
                      color: AppTheme.whiteColor,
                      fontSize: 11.sp),
                  Spacer(),
                  CommonUI().myText(
                      text:  pendingPermission.toString(), fontSize: 16.sp, color: AppTheme.whiteColor),
                  CommonUI().myText(text: "/ $totalPermission",fontSize: 16.sp, color: AppTheme.whiteColor),
                  CommonUI().myText(
                      text: 'hours',
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
                      text: validPermission.toString(),
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
  Widget _buildpermission(BuildContext context){

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
                                  CommonUI().myText(text: "Permission",fontSize: 11.sp,fontWeight:FontWeight.w500),
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

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PermissionDetailsScreen(PermissionId: '',)));
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
