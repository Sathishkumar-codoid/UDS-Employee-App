import 'package:uds_employee/Allnavigations/AllNavigationsDirectory.dart';

import '../../Allnavigations/AllBlocDirectory.dart';
import '../../Allnavigations/AllimportedDirectory.dart';

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({Key? key}) : super(key: key);

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            SizedBox(
              width: 90.w,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: AppTheme.themeLightGrey,width: 0.5)
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "Pay Slip"),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(1.h),
            SizedBox(
              width: 90.w,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: AppTheme.themeLightGrey,width: 0.5)
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "Reimbursement"),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(1.h),
            SizedBox(
              width: 90.w,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: AppTheme.themeLightGrey,width: 0.5)
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "Appraisal"),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(1.h),
            SizedBox(
              width: 90.w,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: AppTheme.themeLightGrey,width: 0.5)
                ),
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(3.h,2.h,3.h,2.h),
                  child: Row(
                    children: [
                      CommonUI().myText(text: "Resign"),
                      Spacer(),
                      Image.asset(AppConstant.rightArrowIcon,scale: 3,)
                    ],
                  ),
                ),
              ),
            ),
            Gap(1.h),

          ],
        ),
      ),
    );
  }
}
