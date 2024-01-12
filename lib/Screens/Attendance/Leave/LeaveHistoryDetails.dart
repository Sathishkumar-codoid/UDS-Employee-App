import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';

class LeaveHistoryDetails extends StatefulWidget {
  const LeaveHistoryDetails({Key? key}) : super(key: key);

  @override
  State<LeaveHistoryDetails> createState() => _LeaveHistoryDetailsState();
}

class _LeaveHistoryDetailsState extends State<LeaveHistoryDetails> {

  TextEditingController _leaveTypeController=TextEditingController();
  TextEditingController _leavestartController=TextEditingController();
  TextEditingController _leaveendController=TextEditingController();
  TextEditingController _noptesController=TextEditingController();
  bool checkedValue=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
            Gap(2.w),
            CommonUI().myText(text: "LEAVE DETAILS")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _leavehistory(context),

            ],
          ),
        ),
      ),
    );
  }

  Widget _leavehistory(BuildContext context){
    return     Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonUI().myText(text: "Leave Type"),
        Gap(1.h),
        CommonUI.formField(editingController: _leaveTypeController, hinttext: '',enabled: false,sIcon:

        GestureDetector(
            onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderScreen(value: "Leave")));
            },

            child: Image.asset(AppConstant.downarrowicon,color: AppTheme.primaryColor2,))),
        Gap(1.h),
        CommonUI().myText(text: "Leave Date"),
        Gap(1.h),

        checkedValue
            ?Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommonUI().myText(text: "From"),
        ):SizedBox(),
        Gap(1.h),
        CommonUI.formField(editingController: _leavestartController, hinttext: '',enabled: false,sIcon: GestureDetector(

            onTap: (){
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderScreen(value: "Leave")));
            },
            child: Image.asset(AppConstant.dateIcon,scale: 3,color: AppTheme.primaryColor2,))),
        Gap(1.h),


        checkedValue
            ?Padding(
          padding: const EdgeInsets.all(8.0),
          child: CommonUI().myText(text: "To"),
        ):SizedBox(),
        Gap(1.h),
        checkedValue? CommonUI.formField(editingController: _leaveendController,enabled: false, hinttext: '',sIcon: Image.asset(AppConstant.dateIcon,scale: 3,color: AppTheme.primaryColor2,)):SizedBox(),
        Gap(1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 80.w,
              child: CheckboxListTile(
                title: CommonUI().myText(
                    text:"Continue Leave",
                    fontSize: 10.sp,
                    overflow: TextOverflow.visible),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                 //   checkedValue=!checkedValue;

                  });

                },
                controlAffinity: ListTileControlAffinity
                    .leading, //  <-- leading Checkbox
              ),
            ),
          ],
        ),
        Gap(5.h),
        CommonUI().myText(text: "Notes"),
        Gap(2.h),
        CommonUI.textAreaFormField(editingController: _noptesController, hinttext: 'xxxxxxxxx xxxxxx xxxxxx xxxxxx ',enabled:false,maxLines: 10,fillcolor: AppTheme.themeLightGrey.withOpacity(0.1)),
        Gap(5.h),
        Row(
          children: [
            CommonUI().myText(text: "Status"),
            Gap(2.h),
            CommonUI().myText(text: "Approved",color: AppTheme.presentColor)
          ],
        ),
        Gap(3.h),
        Row(
          children: [
            CommonUI().myText(text: "Apply Date"),
            Gap(2.h),
            CommonUI().myText(text: "23-10-2023",color: AppTheme.primaryColor2)
          ],
        ),
        Gap(3.h),
        Row(
          children: [
            CommonUI().myText(text: "Approved date on"),
            Gap(2.h),
            CommonUI().myText(text: "25-10-2023",color: AppTheme.primaryColor2)
          ],
        )


      ],
    );

  }
}
