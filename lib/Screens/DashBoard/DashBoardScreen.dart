import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';





import 'package:uds_employee/Utils/CommonUI.dart';

import '../../Allnavigations/AllBlocDirectory.dart';
import '../../Utils/AppAlertController.dart';
import 'MenuBarScreen.dart';





enum AppLandingMenuList { HOME, ATTENDANCE, SALARY, PROFILE }
class DashBoardScreen extends StatefulWidget {
  int? index;
   DashBoardScreen({Key? key,this.index}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool selectedtab = false;
  TextEditingController? dropdownController;
  int? index1;
  List<String> screenTitle = [
    "Home",
    "Attendance",
    "Salary",
    'Profile',
  ];

  final List<Widget> _tabScreens = [
    const HomeScreen(),
    const AttendanceScreen(),
    const SalaryScreen(),
    //OnBoardingCompanyList(),
    const ProfileScreen(),


  ];
  String? selectedLanguage;
  String? selectedValue;
  List<String> dropdownItems = ['English', 'Hindi'];
  List<LanguageList> languages = <LanguageList>[
    LanguageList('0', 'English'),
    LanguageList('1', 'Hindi'),

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      length: AppLandingMenuList.values.length,
      vsync: this,
    );
    setState(() {
      selectedValue = "English";


    });
    _tabController.index = (widget.index ?? 0)!;
    index1=0;
  //  AppAlertController().showProgressIndicator();
  }
  @override
  Widget build(BuildContext context) {
    var _allLanguages = languages.map((e) => e.language!).toList();
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      endDrawer: DashMenuDrawer(),
      appBar:
      _tabController.index == 0 ?
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: _tabController.index == 2 ? 5.h: 15.h,
        elevation: 0,


        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonUI().verticleAlign(height: 2.h),
                Image.asset( AppConstant.logomini,
                  scale: 1.6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(


                      width: 15.w,
                      child: CommonUI().myText(text: "Redefining Business Services",
                        fontSize: 4.5.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.end,
                        maxLines: 2,

                      ),
                    ),
                  ],
                ),

              ],
            ),
            CommonUI().verticleAlign(width: 10.w),
            Image.asset(AppConstant.langIcon, scale: 2.5,),


            GestureDetector(
              child: Row(
                children: [
                  CommonUI().myText(text: selectedValue!,
                      color: AppTheme.blackColor),
                  CommonUI().verticleAlign(width: 1.w),
                  Image.asset(AppConstant.downarrowicon,
                    color: AppTheme.blackColor,)
                ],
              ),

              onTap: (){

                AppOptionsViewer(
                    inContext: context,
                    options: _allLanguages,
                    initialOption: dropdownController?.text,
                    initialOptions: _allLanguages,
                    whenUserSelected: (value) {
                      setState(() {
                        dropdownController?.text = value;
                        if (value == "English") {
                          selectedValue = "English";
                          selectedLanguage = "0";
                          LocaleNotifier.of(context)?. change("en");
                        } else if (value == "Hindi") {
                          selectedValue = "Hindi";
                          selectedLanguage = "1";
                          LocaleNotifier.of(context)?. change("hi");
                        }

                      });
                    }).showMenu();
              },),
            Image.asset(AppConstant.notificationicon,scale: 2.2,),



          ],
        ),

      )
      : AppBar(
        //centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.whiteColor,
        elevation: 0,
        // leading: GestureDetector(
        //     child:  Icon(Icons.chevron_left),
        //     onTap: (){
        //
        //       showDialog<bool>(
        //         context: context,
        //         builder: (context) {
        //           return AlertDialog(
        //             shape: const RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
        //             title: CommonUI().myText(
        //                 text: 'UDS',
        //                 textAlign: TextAlign.center,
        //                 color: AppTheme.primaryColor2),
        //             actionsAlignment: MainAxisAlignment.end,
        //             content: CommonUI().myText(
        //                 text: 'Do you want to exit!!',
        //                 fontWeight: FontWeight.normal,
        //                 textAlign: TextAlign.center,
        //                 color: AppTheme.primaryColor2,
        //                 maxLines: 2),
        //             actions: [
        //               TextButton(
        //                 onPressed: () {
        //                   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        //                 },
        //                 child: CommonUI().myText(
        //                   text: 'Ok',
        //                 ),
        //               ),
        //             ],
        //           );
        //         },
        //       );
        //     }
        // ),
        title: CommonUI().myText(text:screenTitle[index1!], textAlign: TextAlign.center,fontWeight: FontWeight.w600,fontSize: 12.sp),
      ),
      body:  _reloadingTabBarView,


      drawerEnableOpenDragGesture: false,
      bottomNavigationBar: _buildBottomTabBar,
      resizeToAvoidBottomInset: true,


    );

  }

  TabBarView get _reloadingTabBarView => TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: _tabScreens);
  void _handleTabBarSelection(int index) {
    setState(() {
      _tabController.index = index;
      index1=index;
    });
  }

  Widget get _buildBottomTabBar => Container(
    decoration:   const BoxDecoration(


      boxShadow: [
        BoxShadow(
          color: AppTheme.LightGrey,
          blurRadius: 10.0,
          spreadRadius: 2.0,
          offset: Offset(0, 10), // Changes the shadow position
        ),
      ],
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20)
      )
    ),
    constraints: BoxConstraints(
      minHeight: 10.h,
      maxHeight: 13.h,

    ),
    // decoration: _elevationShadow,
    child: Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color:AppTheme.LightGrey,
            blurRadius: 28,
          ),
        ],
      ),


      child: BottomNavigationBar(
        unselectedLabelStyle:  TextStyle(color: AppTheme.blackColor, fontSize: 8.sp,fontWeight: FontWeight.w600,letterSpacing: 0.6),
        selectedLabelStyle: TextStyle(color: AppTheme.blackColor, fontSize: 8.sp,fontWeight: FontWeight.w600,letterSpacing: 0.6) ,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: _bottomBarItems,
        currentIndex: _tabController.index,
        backgroundColor: AppTheme.BottomNavColor,
        onTap: (index) {

          _handleTabBarSelection(index);
        },
         selectedFontSize: 8.sp,

        // unselectedFontSize: 10.sp,
        // showUnselectedLabels: false,
        // showSelectedLabels: true,
        unselectedItemColor: AppTheme.blackColor,
        selectedItemColor: AppTheme.blackColor,
      ),
    ),
  );

  List<BottomNavigationBarItem> get _bottomBarItems {
    List<BottomNavigationBarItem> _tabItems = [];
    for (int idx = 0; idx < AppLandingMenuList.values.length; idx++) {
      var item = AppLandingMenuList.values[idx];
      var tab;
      if (idx == 1) {

        tab = BottomNavigationBarItem(
          backgroundColor: AppTheme.blackColor,
          icon: _bottomMenuIcon(item, idx == _tabController.index, item.name,),
          label: selectedtab == false ? item.name : item.name,
        );
      } else if (idx == 3) {

        tab = BottomNavigationBarItem(
          icon: _bottomMenuIcon(item, idx == _tabController.index, item.name),
          label: selectedtab == false ? item.name : item.name,
        );
      } else if (idx == 2) {

        tab = BottomNavigationBarItem(
          icon: _bottomMenuIcon(item, idx == _tabController.index, item.name),
          label: selectedtab == false ? item.name : item.name,
        );
      } else {

        tab = BottomNavigationBarItem(
          icon: _bottomMenuIcon(item, idx == _tabController.index, item.name),
          label: selectedtab == false ? item.name : item.name,
        );
      }

      _tabItems.add(tab);
    }
    return _tabItems;
  }

  Widget _bottomMenuIcon(AppLandingMenuList item, bool isSelected, name) {
    var color = isSelected ? AppTheme.whiteColor : AppTheme.primaryColor2;
    var size = 12.sp;
    var iconName = isSelected ? name : "";
    selectedtab = isSelected;
    switch (item) {
      case AppLandingMenuList.HOME:
        iconName = AppConstant.homeIcon;
        break;
      case AppLandingMenuList.ATTENDANCE:
        iconName = AppConstant.attendanceIcon;
        break;
      case AppLandingMenuList.SALARY:
        iconName = AppConstant.salaryIcon;
        break;
      case AppLandingMenuList.PROFILE:
        iconName = AppConstant.profileIcon;
        break;

    }
    return
    Column(
      //  crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Material(
          elevation: 0,
          color:Colors.transparent,
          child:

          Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primaryColor2
                  : Colors.transparent,
              border: Border.all(
                color: Colors.transparent,

                width: 1.0,
              ),
              // borderRadius: BorderRadius.circular(5.0)
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),

                bottomRight:Radius.circular(8),
              ),

            ),
            padding:  EdgeInsets.fromLTRB(15, 15,15,5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(iconName,
                    color: color, width: size.sp, height: size.sp),
              ],
            ),
          ),
        ),
        CommonUI().verticleAlign(height: 4),
      ],
    );
    //     :
    // Image.asset(iconName, color: color, width: size.sp, height: size.sp);
  }

}
