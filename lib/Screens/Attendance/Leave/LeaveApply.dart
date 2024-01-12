import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/LeaveBloc.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';

class LeaveApplyScreen extends StatefulWidget {
  LeaveApplyScreen({Key? key, this.date, this.leaveType}) : super(key: key);
  List<DateTime>? date;
  String? leaveType;

  @override
  State<LeaveApplyScreen> createState() => _LeaveApplyScreenState();
}

class _LeaveApplyScreenState extends State<LeaveApplyScreen> {
  TextEditingController _leaveTypeController = TextEditingController();
  TextEditingController _leavestartController = TextEditingController();
  TextEditingController _leaveendController = TextEditingController();
  TextEditingController _noptesController = TextEditingController();
  bool checkedValue = false;
  List<LeaveType> leaveData = [];
  String? selectedleaveTypeID;

  @override
  void initState() {
    // TODO: implement initState
    //Medical Leave
    super.initState();
    if (widget.leaveType != null) {
      _leaveTypeController.text = widget.leaveType!;
      print('widget.leaveType');
      print(widget.leaveType);
    }

    if (widget.date != null) {
      if (widget.date!.length == 1) {
        _leavestartController.text =
            widget.date!.first.toString().split(' ')[0];
      } else {
        _leavestartController.text =
            widget.date!.first.toString().split(' ')[0];
        _leaveendController.text = widget.date!.last.toString().split(' ')[0];
        checkedValue = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = LeaveBloc();
        bloc.add(LeaveTypeListEvent(context));
        return bloc;
      },
      child: BlocListener<LeaveBloc, LeaveState>(
        listener: (context, state) {
          if (state is LeaveTypeListSuccessState) {
            print(state);
            print('Leave type list getted');
            var data = state.data;

            for (int i = 0; i < data.length - 1; i++) {
              leaveData.add(LeaveType.fromJson(data[i]));
            }
          }
        },
        child: BlocBuilder<LeaveBloc, LeaveState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppTheme.whiteColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AppTheme.whiteColor,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    CommonUI().myText(text: "LEAVE APPLY")
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLEaveApply(context),
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

  Widget _buildLEaveApply(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonUI().myText(text: "Leave Type"),
        Gap(1.h),
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
              controller: _leaveTypeController,
              style: TextStyle(
                  color: AppTheme.blackColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Metropolis'),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 7.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                helperStyle: const TextStyle(
                    color: AppTheme.primaryColor2, fontFamily: 'Metropolis'),
                suffixIcon: Image.asset(
                  AppConstant.downarrowicon,
                  scale: 1,
                  color: AppTheme.primaryColor2,
                ),
                hintText: 'Select State...',
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
              )),
          suggestionsCallback: (pattern) async {
            return await _statefetchSuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                    title: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(2.w, 0, 0, 0),
                          child: Container(
                            width: 70.w,
                            child: CommonUI().myText(
                                text: suggestion,
                                maxLines: 2,
                                color: AppTheme.blackColor,
                                fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      endIndent: 0,
                    )
                  ],
                )));
          },
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppTheme.whiteColor,
              elevation: 4.0),
          onSuggestionSelected: (suggestion) {
            _stateonItemSelected(suggestion, context);
          },
          noItemsFoundBuilder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Container(
                height: 60.h,
                child: Column(
                  children: [
                    Image.asset(
                      AppConstant.noDataIcon,
                      width: 80.w,
                    ),
                  ],
                ),
              )),
            );
          },
        ),
        Gap(1.h),
        CommonUI().myText(text: "Leave Date"),
        Gap(1.h),
        checkedValue
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonUI().myText(text: "From"),
              )
            : SizedBox(),
        Gap(1.h),
        CommonUI.formField(
            editingController: _leavestartController,
            hinttext: '',
            sIcon: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalenderScreen(
                                value: "Leave",
                                leaveType: _leaveTypeController.text.toString(),
                              )));
                },
                child: Image.asset(
                  AppConstant.dateIcon,
                  scale: 3,
                  color: AppTheme.primaryColor2,
                ))),
        Gap(1.h),
        checkedValue
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonUI().myText(text: "To"),
              )
            : SizedBox(),
        Gap(1.h),
        checkedValue
            ? CommonUI.formField(
                editingController: _leaveendController,
                hinttext: '',
                sIcon: Image.asset(
                  AppConstant.dateIcon,
                  scale: 3,
                  color: AppTheme.primaryColor2,
                ))
            : SizedBox(),
        Gap(1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 80.w,
              child: CheckboxListTile(
                title: CommonUI().myText(
                    text: "Continue Leave",
                    fontSize: 10.sp,
                    overflow: TextOverflow.visible),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = !checkedValue;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
            ),
          ],
        ),
        Gap(5.h),
        CommonUI().myText(text: "Notes"),
        Gap(2.h),
        CommonUI.textAreaFormField(
            editingController: _noptesController,
            hinttext: 'xxxxxxxxx xxxxxx xxxxxx xxxxxx ',
            maxLines: 10,
            fillcolor: AppTheme.themeLightGrey.withOpacity(0.1)),
        Gap(2.h),
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
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>CalenderScreen(value: "Leave")));
                  },
                  file: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonUI().myText(
                          text: "APPLY",
                          color: AppTheme.whiteColor,
                          fontSize: 10.sp)
                    ],
                  )),
            ),
            Gap(2.h),
          ],
        ),
      ],
    );
  }

  Future<List<String>> _statefetchSuggestions(String input) async {
    input = input.toLowerCase();
    var _allStates = leaveData.map((e) => e.leaveType!).toList();
    input = input.toLowerCase();
    // setState(() {
    _allStates =
        _allStates.where((role) => role.toLowerCase().contains(input)).toList();
    // });

    return _allStates;
  }

  void _stateonItemSelected(String suggestion, BuildContext context) async {
    // Call a geocoding API to get coordinates from the selected suggestion

    setState(() {
      _leaveTypeController.text = suggestion;
    });

    for (int i = 0; i < leaveData.length; i++) {
      if (suggestion == leaveData[i].leaveType) {
        setState(() {
          _leaveTypeController.text = leaveData[i].leaveType;
          selectedleaveTypeID = leaveData[i].id;
          print('selectedleaveTypeID');
          print(selectedleaveTypeID);
          print(_leaveTypeController.text);

          // isSelected = true;
        });
      }
    }
  }
}
