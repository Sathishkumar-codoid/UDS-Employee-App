import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Screens/DashBoard/DashBoardScreen.dart';
import 'package:uds_employee/Utils/AppConstant.dart';


import '../../Allnavigations/AllBlocDirectory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? gettoken;

  Future<String?> getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); //getting token from localstorage
    gettoken = token;
    return token;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    navigationPage();

  }


  Future<void> navigationPage() async {
 

    Future.delayed(const Duration(seconds: 3), () {

      gettoken ==null ?
      Navigator.of(context).pushReplacement(
        CustomPageRoute(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
          duration: 1,
          child:
          LoginScreen()
          ,
        ),
      ):Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));


    });

  }
  @override
  Widget build(BuildContext context) {
    return   AnnotatedRegion(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: AppTheme.primaryColor2),
      child: Scaffold(

        body:
        Stack(
          children: [
            Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryColor1, AppTheme.primaryColor2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                  child: Padding(
                    padding:  EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        CommonUI().verticleAlign(height: 60.h),
                        Image.asset(AppConstant.logoIcon),
                        CommonUI().verticleAlign(height: 1.h),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CommonUI().myText(text: "Redefining Business", fontSize: 7.sp,color: AppTheme.whiteColor),
                            CommonUI().myText(text: " Services", fontSize: 7.sp,color: AppTheme.whiteColor),
                            CommonUI().verticleAlign(height: 15.h)


                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ),

            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/spiral.png', // Replace with the path to your image asset
                scale: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
