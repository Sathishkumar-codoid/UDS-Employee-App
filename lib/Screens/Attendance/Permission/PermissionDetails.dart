import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/PermissionBloc.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';

class PermissionDetailsScreen extends StatefulWidget {
   PermissionDetailsScreen({Key? key,required this.PermissionId}) : super(key: key);
   String PermissionId;

  @override
  State<PermissionDetailsScreen> createState() => _PermissionDetailsScreenState();
}

class _PermissionDetailsScreenState extends State<PermissionDetailsScreen> {
  TextEditingController _dateController=TextEditingController();
  TextEditingController _hoursControiller=TextEditingController();
  TextEditingController _fromTimeController=TextEditingController();
  TextEditingController _toTimeController=TextEditingController();
  TextEditingController _notesController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    BlocProvider(create: (context){
      var bloc=PermissionBloc();
    //  bloc.add(PermissionDetailsEvent(widget.PermissionId, context));
      return bloc;

    },
      child: BlocListener<PermissionBloc,PermissionState>(
        listener: (context,state){

        },
        child: BlocBuilder<PermissionBloc,PermissionState>(
          builder: (context,state){
            return Scaffold(
              backgroundColor: AppTheme.whiteColor,
              appBar: AppBar(

                automaticallyImplyLeading: false,
                backgroundColor: AppTheme.whiteColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                title: CommonUI().myText(text: "PERMISSION",fontSize: 16.sp,fontWeight: FontWeight.w600),


              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _buildbody(context),

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

  }
  Widget _buildbody(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonUI().myText(text: "Date",fontSize: 16.sp,fontWeight: FontWeight.w500),
          Gap(2.h),
          CommonUI.formField(editingController: _dateController, hinttext: '',enabled: false),
          Gap(2.h),
          CommonUI().myText(text: "Hours",fontSize: 16.sp,fontWeight: FontWeight.w500),
          Gap(2.h),
          CommonUI.formField(editingController: _hoursControiller, hinttext: '',enabled: false),
          Gap(2.h),
          CommonUI().myText(text: "Timing",fontSize: 15.sp,fontWeight: FontWeight.w500),
          Gap(2.h),
          Row(
            children: [
              SizedBox(width : 35.w,child: CommonUI.formField(editingController: _fromTimeController, hinttext: '',enabled: false)),
              Gap(4.w),
              CommonUI().myText(text: 'to'),
              Gap(4.w),
              SizedBox(width : 35.w,child: CommonUI.formField(editingController: _toTimeController, hinttext: '',enabled: false)),
            ],
          ),
          Gap(2.h),
          CommonUI().myText(text: "Notes",fontWeight: FontWeight.w500,fontSize: 16.sp),
          Gap(2.h),
          CommonUI.textAreaFormField(editingController: _notesController, hinttext: '',maxLines: 10,fillcolor: Colors.grey[200]!),
          Gap(2.h),
          Row(
            children: [
              CommonUI().myText(text: "Status "),
              Gap(1.w),
              CommonUI().myText(text: "Approved",color: AppTheme.presentColor)
            ],
          ),
          Gap(2.h),
          Row(
            children: [
              CommonUI().myText(text: "Applied Date "),
              Gap(1.w),
              CommonUI().myText(text: "22-01-2024")
            ],
          ),
          Gap(2.h),
          Row(
            children: [
              CommonUI().myText(text: "Approved Date "),
              Gap(1.w),
              CommonUI().myText(text: "22-01-2024",)
            ],
          ),
          Gap(2.h),


        ],
      ),
    );
  }
}
