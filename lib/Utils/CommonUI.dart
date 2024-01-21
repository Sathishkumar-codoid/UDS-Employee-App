
import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

import '../Allnavigations/AllBlocDirectory.dart';
import '../Allnavigations/AllNavigationsDirectory.dart';
import 'AppThemeManager.dart';

class CommonUI {
  Widget myTextL({
    required String text,
    double fontSize = 15,
    double letterSpacing = 15,
    TextAlign? textAlign = TextAlign.start,
    fontWeight = FontWeight.w500,
    color = Colors.black,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 0,
    String fontfamily = 'metropolis',
    double lineHeight = 0.0,
  }) {
    var letterspacing = letterSpacing == 15 ? 0.3.sp : letterSpacing;
    return LocaleText(
      text,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines == 0 ? null : maxLines,
      style: TextStyle(
          color: color,
          fontFamily: fontfamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          overflow: overflow,
          height: lineHeight,
          letterSpacing: letterspacing),
    );
  }

  Widget myText({
    required String text,
    double fontSize = 15,
    double letterSpacing = 15,
    TextAlign? textAlign = TextAlign.start,
    fontWeight = FontWeight.w500,
    color = Colors.black,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines = 0,
    String fontfamily = 'metropolis',
    double lineHeight = 0.0,

  }) {
    var letterspacing = letterSpacing == 15 ? 0.3.sp : letterSpacing;
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines == 0 ? null : maxLines,
      style: TextStyle(
          color: color,
          fontFamily: fontfamily,
          fontSize: fontSize,
          fontWeight: fontWeight,
          overflow: overflow,
          height: lineHeight,
          letterSpacing: letterspacing),
    );
  }


  Widget shimmer(
  

  ) {
  //  var letterspacing = letterSpacing == 15 ? 0.3.sp : letterSpacing;
    return Shimmer.fromColors(
      baseColor: (Colors.grey[300])!,
      highlightColor: (Colors.grey[100])!,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5, // Number of shimmering items
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              width: double.infinity,
              height: 15.h,
              color: Colors.white, // Placeholder color
            ),
          );
        },
      ),
    );

  }


  Widget imageUploadContainer({
    double height = 13,
    double width = 40,
    String? typeText,

  }){
    return     Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
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
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppConstant.imageContainer,
            scale: 4.0,),
          CommonUI().myTextL(text: typeText!,color: AppTheme.blackColor,
              fontSize: 10.sp)
        ],
      ),
    );
  }



  static Widget textAreaFormField({
    required TextEditingController editingController,
    required String hinttext,
    Key? key,
    String? prefix = "",
    bool? enabled = true,
    bool readOnly = false,
    TextStyle hintstyle = const TextStyle(color: AppTheme.primaryColor2),

    AutovalidateMode? autovalidateMode,
    List? inputFormatters,
    TextInputType? keyboardType,
    textInputAction,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    textAlign,
    focusNode,
    int? maxLength,
    onEditingComplete,
    onFieldSubmitted,
    TextCapitalization? textCapitalization,


    void Function(String?)? onChanged,
    int? maxLines,

    style,
    OutlineInputBorder? disabledBorder,
    Widget? sIcon,
    double contentpadding=15.0,
    Color fillcolor=Colors.white,
  }) {
    bool pref = prefix == "";
    return
      TextFormField(
        maxLines: maxLines,
        onChanged: onChanged,
        enabled: enabled,
        key: key,
        readOnly: readOnly,
        validator: validator,
        autovalidateMode: autovalidateMode,
        controller: editingController,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        inputFormatters: keyboardType == TextInputType.number
        // ?[FilteringTextInputFormatter.allow(RegExp(r'\d'))]:
            ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
            : keyboardType == TextInputType.name
            ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))]
            : [
          FilteringTextInputFormatter.allow(
              RegExp(r'[a-zA-Z0-9.,@\-\s]'))
        ],
        onTap: onTap,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(contentpadding),
          // border: InputBorder.none,
          filled: true,
          fillColor:fillcolor,
          hoverColor: Colors.grey[200],
          isDense: true,
          hintText: hinttext,
          hintStyle: hintstyle,
          counterText: "",
          suffixIcon: sIcon,
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none
          ),
          // prefix: Text(prefix!),




        ),
        textAlign: TextAlign.justify,
        style: TextStyle(
            fontFamily: AppThemeManager.defaultFontMetro,
            fontSize: 11.0.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3.sp),
        // style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      );

  }


  Widget verticleAlign({double height = 10, double width = 10}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static Widget formField({
    required TextEditingController editingController,
    required String hinttext,
    Key? key,
    String? prefix = "",
    bool? enabled = true,
    bool readOnly = false,
    TextStyle hintstyle = const TextStyle(color: AppTheme.primaryColor2),
    AutovalidateMode? autovalidateMode,
    List? inputFormatters,
    TextInputType? keyboardType,
    textInputAction,
    VoidCallback? onTap,
    String? Function(String?)? validator,
    textAlign,
    focusNode,
    int? maxLength,
    onEditingComplete,
    onFieldSubmitted,
    TextCapitalization? textCapitalization,
    bool obscureText = false,
    void Function(String?)? onChanged,
    // int? maxLines,

    style,
    OutlineInputBorder? disabledBorder,
    Widget? sIcon,
    double contentpadding = 15.0,
  }) {
    bool pref = prefix == "";
    return TextFormField(
      // maxLines: maxLines,
      onChanged: onChanged,
      enabled: enabled,
      key: key,
      readOnly: readOnly,
      validator: validator,
      autovalidateMode: autovalidateMode,
      controller: editingController,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      obscureText: obscureText,
      inputFormatters: keyboardType == TextInputType.number
          // ?[FilteringTextInputFormatter.allow(RegExp(r'\d'))]:
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
          : keyboardType == TextInputType.name
              ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))]
              : [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z0-9.,@\-\s]'))
                ],
      onTap: onTap,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentpadding),
        // border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[200],
        hoverColor: Colors.grey[200],
        isDense: true,
        hintText: hinttext,
        hintStyle: hintstyle,
        counterText: "",
        suffixIcon: sIcon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        // prefix: Text(prefix!),
      ),
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontFamily: AppThemeManager.defaultFontMetro,
          fontSize: 11.0.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3.sp),
      // style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );
  }

  static Widget buttonContainer({
required VoidCallback onPressed,
 //   required String text,
    required Widget file,
    double width = 30,
    double height = 6.5,
    double fontsize = 10,
    double letterspacing =2,
    Color gradientfirst=AppTheme.primaryColor2,
    Color gradientsecond=AppTheme.primaryColor1,

}) {
    return GestureDetector(
      onTap: onPressed,
      child:
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientfirst, gradientsecond],
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: file
      ),
    );
  }
}

class CustomPageRoute extends PageRouteBuilder {
  final Offset begin;
  final Offset end;
  final Widget child;
  final int duration;

  CustomPageRoute(
      {required this.begin,
      required this.end,
      required this.child,
      required this.duration})
      : super(
          transitionDuration: Duration(seconds: duration),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: Curves.easeIn),
            );
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
