



import 'package:face_camera/face_camera.dart';
import 'package:uds_employee/Bloc/SplashScreenBloc.dart';

import 'Allnavigations/AllBlocDirectory.dart';
import 'Allnavigations/AllNavigationsDirectory.dart';
import 'Allnavigations/AllimportedDirectory.dart';


final mediaStorePlugin = MediaStore();
  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FaceCamera.initialize();
  await Locales.init(['en','hi']);



  if(Platform.isAndroid){

    List<Permission> permissions = [
      Permission.storage,
    ];

    if ((await mediaStorePlugin.getPlatformSDKInt()) >= 33) {
      permissions.add(Permission.photos);
      permissions.add(Permission.audio);
      permissions.add(Permission.videos);
    }
    await permissions.request();
  }else if(Platform.isIOS){

  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        LocaleBuilder(
          builder:(locale)=> MaterialApp(
              locale: locale,


              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,

              debugShowCheckedModeBanner: false,
              navigatorKey: AppDataHelper.navKey,
              title: "UDS Employee",
              theme: ThemeData(
                primarySwatch: buildMaterialColor(AppTheme.primaryColor1),
              ),
              home: MyApp()),
        ));

  });
}

class MyApp extends StatelessWidget {
  final SplashBloc _splashBloc = SplashBloc();




  MyApp({Key? key}) : super(key: key){

  }

  @override
  Widget build(BuildContext context) {

    //LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    //or set a map of translations

    bool isNeedSafeArea = MediaQuery.of(context).viewPadding.bottom > 0;
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(

        body: SafeArea(
          top: true,
          child: StreamBuilder(
            stream: _splashBloc.splashStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                return


                  const LoginScreen();
              } else {
                return const SplashScreen();
              }
            },
          ),
        ),
      );
    });
  }


}