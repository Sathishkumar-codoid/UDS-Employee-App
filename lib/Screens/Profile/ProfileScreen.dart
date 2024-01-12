import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/HomeScreenBloc.dart';
import 'package:uds_employee/Screens/PDFScreen/PdfFileScreen.dart';
import 'package:uds_employee/Utils/AppAlertController.dart';
import '../../Allnavigations/AllBlocDirectory.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  EmployeeData? _employeeData;
  String? pdfPath;


  @override
  Widget build(BuildContext context) {




    return    BlocProvider(
      create: (context){
        var bloc=HomeScreenBloc();
        bloc.add(GetOfferLetterevent(context));
        return bloc;

        //   HomeScreenBloc()..add(GetCheckinStatusEvent(context));

      },
        child: BlocListener<HomeScreenBloc,HomeScreenState>(

        listener: (context,state) {
          if (state is GetOfferLetterSuccessState) {
            _employeeData = EmployeeData.fromJson(state.data['data']);
            print(_employeeData);
            var name = _employeeData!.userData.firstName;
          }
        },
          child: BlocBuilder<HomeScreenBloc,HomeScreenState>(
            builder: (context,state){
              return  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){

                        createFileOfPdfUrl()
                            .then((value) {
                          setState(() {
                            pdfPath = value.path;
                          });
                        });
                        AppAlertController()
                            .showProgressIndicator();

                        Future.delayed(
                            Duration(seconds: 5), () {
                          AppAlertController()
                              .hideProgressIndicator();
                          setState(() {
                            Navigator.of(context).push(
                                CustomPageRoute(
                                    begin: const Offset(
                                        1.0, 0.0),
                                    end: Offset.zero,
                                    duration: 1,
                                    child: PDFScreen(
                                      pdfPath: pdfPath!,
                                    )));
                          });
                        });


                      },
                      child: Container(
                        //  width: 90.w,
                        decoration: BoxDecoration(
                          color: AppTheme.whiteColor,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              // spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0,0), // changes the position of the shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(2.w),
                              CommonUI().myText(text: 'Offer Letter'),
                              Spacer(),
                              Image.asset(AppConstant.rightArrowIcon,scale: 2,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],

              );

            }

          ),
        )

    );



  }
  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print(_employeeData!.offerLetter.letterId.mediaUrl);
    print(_employeeData!.offerLetter.letterId.mediaUrl);
    try {
      final url = _employeeData!.offerLetter.letterId.mediaUrl;
      final filename = url?.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url!));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      print(e);
      print(e);
      throw Exception('Error parsing asset file!');

    }

    return completer.future;
  }



}

