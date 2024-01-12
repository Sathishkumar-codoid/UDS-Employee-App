import 'package:face_camera/face_camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/CalenderScreenBloc.dart';
import 'package:uds_employee/Bloc/HomeScreenBloc.dart';
import 'package:uds_employee/Screens/DashBoard/DashBoardScreen.dart';

import '../../Allnavigations/AllBlocDirectory.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _capturedImage;
  bool facevariable=false;
  @override
  Widget build(BuildContext context) {
    return
    BlocProvider(create: (context){
      var bloc=HomeScreenBloc();
      return bloc;
    },
    child: BlocListener<HomeScreenBloc,HomeScreenState>(
      listener: (context,state){

        if(state is UpdateAttendanceSuccessState){
          print("state.data====29");
          print(state.data);

          showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: CommonUI().myText(
                    text: 'UDS',
                    textAlign: TextAlign.center,
                    color: AppTheme.primaryColor2),
                actionsAlignment: MainAxisAlignment.end,
                content: CommonUI().myText(
                    text: 'Checked In Successfully',
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                    color: AppTheme.primaryColor2,
                    maxLines: 2),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      DashBoardScreen(index: 0,)));
                    },
                    child: CommonUI().myText(
                      text: 'Ok',
                    ),
                  ),

                ],
              );
            },
          );
        }
        if(state is UpdateAttendanceErrorState){
          print("state error");
          print(state);
        }
      },
      child: BlocBuilder<HomeScreenBloc,HomeScreenState>(
        builder: (context, state){
          return       Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppTheme.whiteColor,
                elevation: 0,
                title: Row(
                  children: [
                    IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,)),
                    CommonUI().myText(text: "Take a Picture")
                  ],
                ),
              ),
              body: Builder(builder: (context) {
                if (_capturedImage != null) {
                  return Center(
                    child: Column(
                      children: [
                        Gap(10.h),
                        SizedBox(
                          height: 20.h,
                          width: 50.w,
                          child: Image.file(
                            _capturedImage!,
                            width: double.maxFinite,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Gap(4.h),
                        CommonUI.buttonContainer(
                            height: 4.h,
                            width: 30.w,
                            onPressed: (){


                              DateTime now = DateTime.now();
                              String currentTime;
                              currentTime = "${now.hour}:${now.minute}:${now.second}";



                              Attendance payload = Attendance(
                                date: DateTime.now().toString().split(" ")[0],
                                month: DateTime.now().month.toString(),
                                year: DateTime.now().year.toString(),
                                checkInTime: currentTime.trim(),


                              );
                              BlocProvider.of<HomeScreenBloc>(context).add(UpdateAttendanceEvent(context, payload));
                            }, file: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonUI().myText(text: "Submitt",color: AppTheme.whiteColor,fontSize: 10.sp)

                          ],
                        ))
                      ],
                    ),
                  );
                }
                return SmartFaceCamera(
                    autoCapture: facevariable,
                    defaultCameraLens: CameraLens.front,
                    showCaptureControl: false,
                   // showControls: false,
                    message: 'Center your face in the square',

                    onCapture: (File? image) {
                      setState((){
                        _capturedImage = image;
                        print("_capturedImage?.path");
                        print(_capturedImage?.path);
                      }
                      );
                    },
                    onFaceDetected: (Face? face) {
                      print('face1212121');
                      print(face);
                      setState(() {
                        facevariable=true;
                      });
                      //Do something
                    },
                    messageBuilder: (context, face) {
                      if (face == null) {
                        return _message('Place your face in the camera');
                      }
                      if (!face.wellPositioned) {
                        return _message('Center your face in the square');
                      }
                      return const SizedBox.shrink();
                    });
              }));

        },
      ),
    ),);


  }


  Widget _message(String msg) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
    child: Text(msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
  );
}
