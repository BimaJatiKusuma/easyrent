import 'package:easyrent/Renter/renterHompage.dart';
import 'package:easyrent/RenterAdmin/adminHompage.dart';
import 'package:easyrent/welcomingPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Widget page = getRole() as Widget;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: WelcomingPage(),
      home: GetRole(),
    );
  }
}

class GetRole extends StatefulWidget {
  const GetRole({super.key});

  @override
  State<GetRole> createState() => _GetRoleState();
}

class _GetRoleState extends State<GetRole> {
  Widget loginRef = WelcomingPage();
  @override
  void initState() {
    Future getRole() async{
      SharedPreferences loginPreferences = await SharedPreferences.getInstance();
      print(loginPreferences.getString("role"));
      if(loginPreferences.getString("role")=="renter"){
        setState(() {
          loginRef = RenterHomePage();
        });
      }
      if(loginPreferences.getString("role")=="admin"){
        setState(() {
          loginRef = AdminHomePage();
        });
      }
      }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return loginRef;
  }
}

