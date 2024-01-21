import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';
import 'package:uds_employee/Bloc/LeaveBloc.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';
import '../../../Network/APIMethods.dart';
import 'LeaveScreen.dart';

class LeaveApplyScreen extends StatefulWidget {
  LeaveApplyScreen({Key? key, this.date, this.leaveType, required this.userId,this.leaveTypeId})
      : super(key: key);
  List<DateTime>? date;
  String? leaveType;
  String userId;
  String? leaveTypeId;

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
  String? authToken;
  CroppedFile? cropimage;
  var medicalCertificate;
  var formKey = GlobalKey<FormState>();

  @override
  initState() {
    // TODO: implement initState
    //Medical Leave
    super.initState();
    getToken();
    getUserId();
    if(widget.leaveTypeId !=null){
      selectedleaveTypeID=widget.leaveTypeId;
    }
    if (widget.leaveType != null) {
      _leaveTypeController.text = widget.leaveType!;

      print('widget.leaveType');
      print(widget.leaveType);
      // for (int i = 0; i < leaveData.length; i++) {
      //   if (widget.leaveType == leaveData[i].leaveType) {
      //     setState(() {
      //    //   _leaveTypeController.text = leaveData[i].leaveType;
      //       selectedleaveTypeID = leaveData[i].id;
      //       print('selectedleaveTypeID');
      //       print(selectedleaveTypeID);
      //       // isSelected = true;
      //     });
      //   }
      // }


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

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.userId = prefs.getString('id')!;
    });
  }

  getToken() async {
    print("get un");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token');
    });
    print('userid');
    print(authToken);
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
          if (state is LeaveApplySuccessState) {
            print(state.data);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LeaveScreen(userId: widget.userId,)));
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaveScreen(userId: userId,)));
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonUI().myText(text: "Leave Type"),
                CommonUI().myText(text: '*',color: AppTheme.primaryColor2),
              ],
            ),
            Gap(2.h),
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
                  ),
    ),


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
            Row(
              children: [
                CommonUI().myText(text: "Leave Date"),
                CommonUI().myText(text: "*",color: AppTheme.primaryColor2)
              ],
            ),
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
                validator: (value){
              if(    value!.isNotEmpty){
                return null;
              }else{
                return   "Please enter the date";
              }

                },
                sIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalenderScreen(
                                    value: "Leave",
                                    leaveType: _leaveTypeController.text.toString(),
                                leaveTypeID: selectedleaveTypeID!,
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
           _leaveTypeController.text=="Sick Leave" || _leaveTypeController.text=="Medical Leave" ? _buildImage() : SizedBox(),



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
                        var form=formKey.currentState;

                        if (form?.validate() ?? true) {

                          var payload = ApplyLeave(
                              fromDate: _leavestartController.text,
                              toDate: _leaveendController.text.isNotEmpty ? _leaveendController.text :null,
                              continueLeave: checkedValue,
                              notes: _noptesController.text,
                              userId: widget.userId,
                              leaveType: selectedleaveTypeID!);

                          BlocProvider.of<LeaveBloc>(context)
                              .add(LeaveApplyEvent(payload, context, authToken!,File(medicalCertificate ?? '')));
                        }


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
        ),
      ),
    );
  }


  Widget _buildImage(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonUI().myText(text: 'Upload Mediacal Certificate',fontSize: 12.sp),
        Gap(2.h),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: GestureDetector(
                onTap: (){

                  openImagePickerOptions(context);
                },
                child:
    medicalCertificate !=null
    ?
    Container(
      height: 20.h,
      width: 90.w,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: FileImage(
              File(medicalCertificate),

            ),
            fit: BoxFit.cover
        ) ,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppTheme.grey,  // Border color
          width: 0.5,           // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 12.0,
            spreadRadius: 2.0,
            offset: Offset(0, 3), // Changes the shadow position
          ),
        ],
      ),


    )
    :

                CommonUI().imageUploadContainer(
                    height: 20.h,
                    width: 90.w,
                    typeText: "front"
                )
            ),
          ),
        ),

      ],
    );
  }




  openImagePickerOptions(context) async {
    await showCupertinoModalPopup(
      context: context!,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () =>
                        openImagePicker(ImageResource.CAMERA, context),
                    child: Text('Camera')),
                CupertinoActionSheetAction(
                    onPressed: () =>
                        openImagePicker(ImageResource.GALLERY, context),
                    child: const Text('Gallery')),
              ],
            );
          }),
    );
  }



  openImagePicker(ImageResource resource, context) {
    Navigator.pop(context, true);
    if (resource.name == "GALLERY") {
      _pickFile();
    }
    if(resource.name =="CAMERA"){
      ImagePicker()
          .pickImage(
          source: resource == ImageResource.CAMERA
              ? ImageSource.camera
              : ImageSource.gallery)
          .then((image) async {
        if (image != null) {
          final croppedFile = await ImageCropper().cropImage(
              sourcePath: image!.path,
              compressFormat: ImageCompressFormat.jpg,
              compressQuality: 100,
              uiSettings: [
                AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  toolbarColor: Colors.deepOrange,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false,
                ),
                IOSUiSettings(
                  title: 'Cropper',
                ),
                WebUiSettings(
                  context: context,
                  presentStyle: CropperPresentStyle.dialog,
                  boundary: const CroppieBoundary(
                    width: 520,
                    height: 520,
                  ),
                  viewPort: const CroppieViewPort(
                      width: 480, height: 480, type: 'circle'),
                  enableExif: true,
                  enableZoom: true,
                  showZoomer: true,
                ),
              ]);
          setState(() {
            cropimage = croppedFile;
          });

          medicalCertificate = croppedFile?.path;
          // networkImagePB = false;



          // print("imageprofile");
          // print(bankPassBookImage);





        }
      });
    }


  }


  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      File pickedFile = File(result.files.single.path!);

      // Check if the selected file is an image
      if (pickedFile.path.toLowerCase().endsWith('.jpg') ||
          pickedFile.path.toLowerCase().endsWith('.jpeg') ||
          pickedFile.path.toLowerCase().endsWith('.png')) {
        final croppedFile = await ImageCropper().cropImage(
            sourcePath: pickedFile!.path,
            compressFormat: ImageCompressFormat.jpg,
            compressQuality: 100,
            uiSettings: [
              AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false,
              ),
              IOSUiSettings(
                title: 'Cropper',
              ),
              WebUiSettings(
                context: context,
                presentStyle: CropperPresentStyle.dialog,
                boundary: const CroppieBoundary(
                  width: 520,
                  height: 520,
                ),
                viewPort: const CroppieViewPort(
                    width: 480, height: 480, type: 'circle'),
                enableExif: true,
                enableZoom: true,
                showZoomer: true,
              ),
            ]);

        if (croppedFile != null) {
          setState(() {
            cropimage = croppedFile;
          });

          medicalCertificate = croppedFile.path;
      //    networkImagePB = false;



        }
      } else if (pickedFile.path.toLowerCase().endsWith('.pdf')) {
        medicalCertificate = pickedFile.path;
        //networkImagePB = false;



      }
    } else {
      // User canceled the file picking
    }
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
