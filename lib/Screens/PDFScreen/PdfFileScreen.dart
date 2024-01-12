import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:open_file/open_file.dart';
import 'dart:async';
import '../../Allnavigations/AllBlocDirectory.dart';
import '../../Allnavigations/AllNavigationsDirectory.dart';
import '../../Allnavigations/AllimportedDirectory.dart';

class PDFScreen extends StatefulWidget {
   PDFScreen({Key? key,required this.pdfPath}) : super(key: key);
  String pdfPath;

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {

  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  share() async{
    final result = await OpenFile.open(widget.pdfPath);


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
        backgroundColor: AppTheme.primaryColor2,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // Adjust the radius as needed
            bottomRight: Radius.circular(20.0), // Adjust the radius as needed
          ),
        ),
        bottom: const PreferredSize(
            preferredSize:
            Size.fromHeight(2.0), // Set the height of the border line
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Divider(
                thickness: 1.0,
                height: 1,
                color: AppTheme.whiteColor,
              ),
            )),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios,color: AppTheme.whiteColor,),onPressed: (){
          Navigator.pop(context);
        },),
        title: CommonUI().myText(text: "PDF View Screen",color: AppTheme.whiteColor),
        // actions: [
        //   IconButton(onPressed: (){
        //     share();
        //
        //
        //   }, icon: Icon(Icons.share,color: AppTheme.whiteColor,))
       // ],
      ),
      body:   Stack(
        children: <Widget>[
          PDFView(
            filePath:widget.pdfPath,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
            true,
            onRender: (pages) {
              setState(() {
                pages = pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });

            },
            onPageError: (page, error) {
              setState(() {

                errorMessage = '$page: ${error.toString()}';

              });
            },
            onViewCreated: (PDFViewController pdfViewController) {

              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page;
              });
            },
          ),
        ],
      ),

    );
  }
}
