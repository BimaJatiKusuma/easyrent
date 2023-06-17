import 'package:shared_preferences/shared_preferences.dart';

login(role)async{
  final SharedPreferences loginPreferences = await SharedPreferences.getInstance();
  loginPreferences.setString("role", role);
}
logoutSharedPref()async{
  final SharedPreferences loginPreferences = await SharedPreferences.getInstance();
  print(loginPreferences.get("role"));
  loginPreferences.remove("role");
}