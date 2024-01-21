import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/LeaveBloc.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';
import 'LeaveApply.dart';
import 'LeaveHistoryDetails.dart';

class LeaveHistoryScreen extends StatefulWidget {
   LeaveHistoryScreen({Key? key,required this.userId}) : super(key: key);
   String userId;

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {

  var status="approved";
  List<LeaveStatusType>   leavedata=[];
  @override
  Widget build(BuildContext context) {
    return

      BlocProvider( create: (context){

        var bloc=LeaveBloc();

        bloc.add(LeaveStatusEvent(context, widget.userId!, status));

        return bloc;
      },
          child: BlocListener<LeaveBloc,LeaveState>(
          listener: (context,state){
      if(state is LeaveStatusSuccessState){
        print(state.data['data']);
        var data=state.data['data']['data'];
        print(data.length);
        for(int i=0;i<data.length;i++){
          leavedata.add(LeaveStatusType.fromJson(data[i]));
        }

        print('leavedata.length');
        print(leavedata.length);


      }
    },
    child: BlocBuilder<LeaveBloc,LeaveState>(
    builder: (context,state){
      return   Scaffold(
        backgroundColor: AppTheme.whiteColor,
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
                  icon: const Icon(Icons.arrow_back_ios)),
              CommonUI().myText(text: "LEAVE HISTORY")
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              _buildleave(context),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveApplyScreen(userId: widget.userId,)));
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
      );


    })
          )
      );



  }
  Widget _buildleave(BuildContext context){

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonUI().myText(text: "Completed"),
          Gap(1.h),
          leavedata.isNotEmpty
          ?
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: leavedata.length,
              itemBuilder: (context,index){
                var items=leavedata[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
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
                                  CommonUI().myText(text: items.leaveType.leaveType,fontSize: 11.sp,fontWeight:FontWeight.w500),
                                  Gap(1.h),
                                  CommonUI().myText(text: items.fromDate.toString().split(' ')[0],color: AppTheme.primaryColor2,fontSize: 11.sp,fontWeight:FontWeight.w500   ),

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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LeaveHistoryDetails(leaveID:items.id ,)));
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
                              CommonUI().myText(text: items.appliedDate.toString().split(' ')[0],color: AppTheme.FontGrey,fontWeight: FontWeight.w500,fontSize: 9.sp),
                              Spacer(),
                              CommonUI().myText(text: 'Status',fontSize: 9.sp,fontWeight: FontWeight.w600),
                              Gap(1.w),
                              CommonUI().myText(text: items.status,color: AppTheme.presentColor,fontWeight: FontWeight.w500,fontSize: 9.sp),



                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                );


              }): Image.asset(AppConstant.noDataIcon),
        ],
      ),
    );
  }
}
