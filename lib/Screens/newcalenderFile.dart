  import 'package:syncfusion_flutter_datepicker/datepicker.dart';
  import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
  import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

  import '../Allnavigations/AllBlocDirectory.dart';

  class NewCalenderScreen extends StatefulWidget {
    const NewCalenderScreen({Key? key}) : super(key: key);

    @override
    State<NewCalenderScreen> createState() => _NewCalenderScreenState();
  }

  class _NewCalenderScreenState extends State<NewCalenderScreen> {
    String _selectedDate = DateTime.now().toString();
    String _dateCount = '';
    String _range = '';
    String _rangeCount = '';
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selecteddate.clear();
  }
   // DateTime? selecteddate;
    List<DateTime> selecteddate=[];
    List<DateTime> presentDates = [
    DateTime(2024,01,06),
      DateTime(2024,01,07),
      DateTime(2024,01,09),
      DateTime.now(),
    ];

    List<DateTime> absentDates = [
      DateTime(2024,01,02),
      DateTime(2024,01,26),
    ];

    List<DateTime> weekOffDates = [
      DateTime(2024,01,14),
    ];



    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        print('data has getted');

        if (args.value is PickerDateRange) {
          _range = args.value.startDate != null
              ? '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}'
              : '';
          print('_range');
          print(_range);
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
          print('_selectedDate');
          print(_selectedDate);
          selecteddate.clear();

          selecteddate.add(args.value);
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
          print('_dateCount');
          print(_dateCount);
          print(args.value);
          selecteddate.clear();
          selecteddate.addAll(args.value);
       //   selecteddate.re
        } else {
          _rangeCount = args.value.length.toString();
          print('_rangeCount');
          print(_rangeCount);
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      Future.delayed(Duration(seconds: 1),(){
        setState(() {

        });
      });
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppTheme.whiteColor,
          title:Row(
            children: [
              IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios)),
              CommonUI().myText(text: 'Calender')
            ],
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Card(
                child: SizedBox(
                  height: 52.h,
                  width: 90.w,
                  child:
                  SfDateRangePicker(
                    viewSpacing: 0.1,
                    headerHeight: 40,
                    todayHighlightColor: AppTheme.todayColor,
                    selectionShape: DateRangePickerSelectionShape.rectangle,
                    selectionColor: AppTheme.todayColor,
                  showNavigationArrow: true,
                  allowViewNavigation: false,
                  // onViewChanged:


                    //selectionColor: Colors.transparent,
                   headerStyle: DateRangePickerHeaderStyle(
                     textAlign: TextAlign.center,
                     textStyle: TextStyle(
                       color: AppTheme.primaryColor2,
                       fontSize: 15.sp
                     )
                   ),
                   // showActionButtons:true,

                    onSelectionChanged: _onSelectionChanged,
                    cellBuilder:_buildCellWidget ,
                    selectionMode: DateRangePickerSelectionMode.single,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

    }

    Widget _buildCellWidget(BuildContext context, DateRangePickerCellDetails cellDetails) {
      bool isPresent = presentDates.contains(cellDetails.date);
      bool isAbsent = absentDates.contains(cellDetails.date);
      bool isWeekOff = weekOffDates.contains(cellDetails.date);
      bool isSelected=selecteddate.contains(cellDetails.date);

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
            color:AppTheme.absentColor,
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
          margin: EdgeInsets.all(2),

          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.weekOffColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            cellDetails.date.day.toString(),
            style: TextStyle(color: Colors.black),
          ),
        );
      }

      else {
        // Default styling for other dates
        return Container(
          margin: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.todayColor  :AppTheme.calendarColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            cellDetails.date.day.toString(),
            style: const TextStyle(color: Colors.black),
          ),
        );
      }
    }

  }
