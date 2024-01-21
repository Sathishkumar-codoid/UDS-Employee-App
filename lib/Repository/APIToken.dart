import 'package:uds_employee/Allnavigations/AllimportedDirectory.dart';

setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();

  prefs.setString('token', token);

}
setName(String firstname) async{
  final prefs=await SharedPreferences.getInstance();
  prefs.setString('first_name', firstname);
}
setUserId(String userid) async{
  final prefs=await SharedPreferences.getInstance();
  prefs.setString('id', userid);
}