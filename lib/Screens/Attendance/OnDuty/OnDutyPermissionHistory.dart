import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';

import '../../../Allnavigations/AllBlocDirectory.dart';

class OnDutyPermissionHistory extends StatefulWidget {
  const OnDutyPermissionHistory({Key? key}) : super(key: key);

  @override
  State<OnDutyPermissionHistory> createState() => _OnDutyPermissionHistoryState();
}

class _OnDutyPermissionHistoryState extends State<OnDutyPermissionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppTheme.whiteColor,
        title: Row(
          children: [
            IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios))
          ],
        )
      ),
    );
  }


}
