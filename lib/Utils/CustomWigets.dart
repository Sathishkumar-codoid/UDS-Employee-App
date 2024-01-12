

import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

import '../Allnavigations/AllBlocDirectory.dart';
import '../Allnavigations/AllNavigationsDirectory.dart';

enum AppOptionsMode { SINGLE, MULTIPLE }

class AppOptionsViewer {
  final BuildContext inContext;
  final List<String> options;
  final String? initialOption;
  final List<String>? initialOptions;
  final AppOptionsMode mode;
  final Function(String)? whenUserSelected;
  final Function(List<String>)? whenUserCompleted;

  const AppOptionsViewer({
    required this.inContext,
    required this.options,
    this.initialOption,
    this.initialOptions,
    this.mode = AppOptionsMode.SINGLE,
    this.whenUserSelected,
    this.whenUserCompleted,
  });

  void showMenu() async {
    var optionsArea = AppOptionsArea(
      inContext: inContext,
      options: options,
      initialOption: initialOption,
      initialOptions: initialOptions,
      mode: mode,
      whenUserCompleted: whenUserCompleted,
      whenUserSelected: whenUserSelected,
    );

    showDialog(
      barrierColor: AppTheme.themeLightGrey.withAlpha(100),
      context: inContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(child: optionsArea),
        );
      },
    );
  }
}


class AppOptionsArea extends StatefulWidget {
  final BuildContext inContext;
  final List<String> options;
  final String? initialOption;
  final List<String>? initialOptions;
  final AppOptionsMode mode;
  final Function(String)? whenUserSelected;
  final Function(List<String>)? whenUserCompleted;

  const AppOptionsArea(
      {required this.inContext,
        required this.options,
        this.initialOption,
        this.initialOptions,
        this.mode = AppOptionsMode.SINGLE,
        this.whenUserSelected,
        this.whenUserCompleted,
        Key? key})
      : super(key: key);

  @override
  _AppOptionsAreaState createState() => _AppOptionsAreaState();
}

class _AppOptionsAreaState extends State<AppOptionsArea> {
  late List<String> _initialOptions;
  bool sizer = false;

  @override
  void initState() {
    _collectInitialOption();
    super.initState();
    sizer = SizerUtil.deviceType.toString() == DeviceType.tablet.toString();
  }

  @override
  Widget build(BuildContext context) {
    return _buildOptionsArea();
  }

  Widget _buildOptionsArea() {
    return SizedBox(
      width: 90.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _titleArea(),
          _optionsList(),
          _buttonsArea(),
        ],
      ),
    );
  }

  Widget _optionsList() {
    var listView = ListView.separated(
        padding: EdgeInsets.all(10.0.sp),
        shrinkWrap: true,
        itemBuilder: (context, idx) {
          var title = widget.options[idx];
          var isSelected = _initialOptions.contains(title);
          return ListTile(
            title: Text(
              title,
              style: AppTheme.customTextStyleWithSize(
                  weight: FontWeight.w300, size: 12.0),
            ),
            trailing: isSelected
                ? const Icon(
              Icons.check,
              color: Colors.black,
            )
                : null,
            onTap: () {
              setState(() {
                if (widget.mode == AppOptionsMode.SINGLE) {
                  _initialOptions.clear();
                  _initialOptions.add(title);
                }

                if (widget.mode == AppOptionsMode.MULTIPLE) {
                  if (_initialOptions.contains(title)) {
                    _initialOptions.remove(title);
                  } else {
                    _initialOptions.add(title);
                  }
                }
              });
            },
          );
        },
        separatorBuilder: (c, i) {
          return const Divider(
            color: Colors.grey,
          );
        },
        itemCount: widget.options.length);

    return Flexible(
      child: Container(
        color: Colors.white,
        child: listView,
      ),
    );
  }

  Widget _titleArea() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),
      padding: EdgeInsets.all(13.sp),
      child: Center(
          child: CommonUI().myText(
              text: 'Please select',
              color: AppTheme.primaryColor1,
              fontSize: 15.sp)),
    );
  }

  Widget _buttonsArea() {
    var okButton = TextButton(
      child: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: CommonUI().myText(
              text: "OK",
              color: AppTheme.primaryColor1,
              fontSize: sizer ? 10.sp : 15)),
      onPressed: () {
        switch (widget.mode) {
          case AppOptionsMode.SINGLE:
            widget.whenUserSelected!(_initialOptions.last);
        }
        _closeAction();
      },
    );

    var cancelButton = TextButton(
      onPressed: _closeAction,
      child: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: CommonUI().myText(
              text: "CANCEL",
              fontSize: sizer ? 10.sp : 15,
              color: AppTheme.primaryColor1)),
    );
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          cancelButton,
          okButton,
          CommonUI().verticleAlign(width: 10.w)
        ],
      ),
    );
  }

  void _closeAction() {
    Navigator.pop(context);
  }

  void _collectInitialOption() {
    List<String> alreadySelectedOptions = [];
    if (widget.mode == AppOptionsMode.SINGLE && widget.initialOption != null) {
      alreadySelectedOptions.add(widget.initialOption ?? '');
    }

    if (widget.mode == AppOptionsMode.MULTIPLE &&
        widget.initialOptions != null) {
      alreadySelectedOptions.addAll(widget.initialOptions ?? []);
    }
    _initialOptions = alreadySelectedOptions;
  }
}

class AppOptionsViewrProfile {
  final BuildContext inContext;
  final List<String> options;
  final List<String> profile;
  final String? initialOption;
  final List<String>? initialOptions;
  final AppOptionsMode mode;
  final Function(String)? whenUserSelected;
  final Function(List<String>)? whenUserCompleted;

  AppOptionsViewrProfile({
    required this.inContext,
    required this.options,
    required this.profile,
    this.initialOption,
    this.initialOptions,
    this.mode = AppOptionsMode.SINGLE,
    this.whenUserSelected,
    this.whenUserCompleted,
  });

  void showMenu() async {
    var optionsArea = AppOptionsAreaslist(
      inContext: inContext,
      options: options,
      initialOption: initialOption,
      initialOptions: initialOptions,
      mode: mode,
      whenUserCompleted: whenUserCompleted,
      whenUserSelected: whenUserSelected,
      profilepic: profile,
    );

    showDialog(
      barrierColor: AppTheme.themeLightGrey.withAlpha(100),
      context: inContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: optionsArea)),
        );
      },
    );
  }
}

class AppOptionsAreaslist extends StatefulWidget {
  final BuildContext inContext;
  final List<String> options;
  final List<String> profilepic;
  final String? initialOption;
  final List<String>? initialOptions;
  final AppOptionsMode mode;
  final Function(String)? whenUserSelected;
  final Function(List<String>)? whenUserCompleted;

  const AppOptionsAreaslist(
      {required this.inContext,
        required this.options,
        required this.profilepic,
        this.initialOption,
        this.initialOptions,
        this.mode = AppOptionsMode.SINGLE,
        this.whenUserSelected,
        this.whenUserCompleted,
        Key? key})
      : super(key: key);

  @override
  State<AppOptionsAreaslist> createState() => _AppOptionsAreaslistState();
}

class _AppOptionsAreaslistState extends State<AppOptionsAreaslist> {
  late List<String> _initialOptions;
  bool sizer = false;

  @override
  void initState() {
    _collectInitialOption();
    sizer = SizerUtil.deviceType.toString() == DeviceType.tablet.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildOptionsArea();
  }

  Widget _buildOptionsArea() {
    return SizedBox(
      width: 90.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _optionsList(),
          _buttonsArea(),
        ],
      ),
    );
  }

  Widget _optionsList() {
    var listView = ListView.separated(
        padding: EdgeInsets.all(10.sp),
        shrinkWrap: true,
        itemBuilder: (context, idx) {
          var title = widget.options[idx].trim();
          var profile = widget.profilepic[idx];
          var isSelected = _initialOptions.contains(title);
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 1.h),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: profile == null || profile == 'null'
                    ? Image.asset(AppConstant.profileIcon).image
                    : Image.network(profile).image,
              ),
              title: Text(
                title,
                style: AppTheme.customTextStyleWithSize(
                    weight: FontWeight.w300, size: 12.0),
              ),
            //  trailing: isSelected ? Image.asset(AppConstant) : null,
              onTap: () {
                setState(() {
                  if (widget.mode == AppOptionsMode.SINGLE) {
                    _initialOptions.clear();
                    _initialOptions.add(title);
                  }

                  if (widget.mode == AppOptionsMode.MULTIPLE) {
                    if (_initialOptions.contains(title)) {
                      _initialOptions.remove(title);
                    } else {
                      _initialOptions.add(title);
                    }
                  }
                });
              },
            ),
          );
        },
        separatorBuilder: (c, i) {
          return SizedBox();
        },
        itemCount: widget.options.length);

    return Flexible(
      child: Container(
        color: Colors.white,
        child: listView,
      ),
    );
  }

  Widget _buttonsArea() {
    var okButton = TextButton(
      child: CommonUI().myText(
          text: "OK",
          color: AppTheme.primaryColor1,
          fontSize: sizer ? 10.sp : 15),
      onPressed: () {
        switch (widget.mode) {
          case AppOptionsMode.SINGLE:
            widget.whenUserSelected!(_initialOptions.last);
        }
        _closeAction();
      },
    );

    var cancelButton = TextButton(
      onPressed: _closeAction,
      child: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: CommonUI().myText(
              text: "CANCEL",
              color: AppTheme.primaryColor1,
              fontSize: sizer ? 10.sp : 15)),
    );

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          cancelButton,
          okButton,
          CommonUI().verticleAlign(width: 10.w)
        ],
      ),
    );
  }

  void _closeAction() {
    Navigator.pop(context);
  }

  void _collectInitialOption() {
    List<String> alreadySelectedOptions = [];
    if (widget.mode == AppOptionsMode.SINGLE && widget.initialOption != null) {
      alreadySelectedOptions.add(widget.initialOption ?? '');
      if (widget.mode == AppOptionsMode.MULTIPLE &&
          widget.initialOptions != null) {
        alreadySelectedOptions.addAll(widget.initialOptions ?? []);
      }
      _initialOptions = alreadySelectedOptions;
    }
  }
}
