import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';

class PermissionHistory extends StatefulWidget {
  const PermissionHistory({Key? key}) : super(key: key);

  @override
  State<PermissionHistory> createState() => _PermissionHistoryState();
}

class _PermissionHistoryState extends State<PermissionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CommonUI().myText(text: "PERMISSION HISTORY")
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [

            _buildpermission(context),
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

    );
  }


  Widget _buildpermission(BuildContext context){

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonUI().myText(text: "Completed"),
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
                                  CommonUI().myText(text: "2 hours",fontSize: 11.sp,fontWeight:FontWeight.w500),
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

                                    onPressed: (){}, file: Row(
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
                              CommonUI().myText(text: 'Approved',color: AppTheme.presentColor,fontWeight: FontWeight.w500,fontSize: 9.sp),



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
