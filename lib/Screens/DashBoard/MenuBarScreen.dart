import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

import '../../Allnavigations/AllBlocDirectory.dart';

class DashMenuDrawer extends StatefulWidget {
  const DashMenuDrawer({super.key});

  @override
  State<DashMenuDrawer> createState() => _DashMenuDrawerState();
}

class _DashMenuDrawerState extends State<DashMenuDrawer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getUserName();


  }
  bool userLoggedOut = false;
  String? user_firstname;


  getUserName() async{
    print("get un");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_firstname = prefs.getString("first_name");

    });
    print(prefs.getString("first_name"));
    print("${user_firstname} username 31");


  }



  removeToken(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('token'); //getting token from localstorage

    userLoggedOut = true;
    if(userLoggedOut){
      Navigator.of(context).pushReplacement(
        CustomPageRoute(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
          duration: 1,
          child:

          const LoginScreen(),
        ),
      );
    }





  }
  @override
  Widget build(BuildContext context) {
    return   Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryColor1, AppTheme.primaryColor2],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonUI().verticleAlign(height: 1.5.h),

                CommonUI().myText(text: "WELCOME", color: AppTheme.whiteColor, fontSize: 11.sp),
                CommonUI().verticleAlign(height: 1.5.h),
                user_firstname == null ?
                const SizedBox() :

                CommonUI().myText(text: user_firstname!.toUpperCase(), color: AppTheme.whiteColor, fontSize: 16.sp,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.input, color: AppTheme.primaryColor2,),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user, color: AppTheme.primaryColor2,),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: AppTheme.primaryColor2,),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color, color: AppTheme.primaryColor2,),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: AppTheme.primaryColor2,),
            title: Text('Logout'),
            onTap: () {
              removeToken(context);


            },
          ),
        ],
      ),
    );
  }
}