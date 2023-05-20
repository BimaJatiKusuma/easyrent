import 'package:easyrent/Componen/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 1;
  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  List _widgetOptions = [
    Text("Ini Chat"),
    AdminMainHomepage(),
    AdminProfil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 229, 237, 1),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      currentIndex: _selectedIndex,
      onTap: _onItemTap,
      selectedItemColor: Color.fromRGBO(74, 73, 148, 1),
      ),
    );
  }
}




class AdminMainHomepage extends StatefulWidget {
  const AdminMainHomepage({super.key});

  @override
  State<AdminMainHomepage> createState() => _AdminMainHomepageState();
}

class _AdminMainHomepageState extends State<AdminMainHomepage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("images/admin_rent.png"),
                ),
                Text("@squarepants")
              ],
            ),
          ),

          SizedBox(height: 20,),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 160,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(74, 73, 148, 1),
                  ),
                  child: Column(
                    children: [
                      Text("Request", style: TextStyle(color: Colors.white),),
                      Expanded(
                        // height: double.infinity,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 160,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(74, 73, 148, 1),
                  ),
                  child: Column(
                    children: [
                      Text("Accepted", style: TextStyle(color: Colors.white),),
                      Expanded(
                        // height: double.infinity,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("177", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(child:
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)
                ),
                color: Colors.white,
              ),
            )
          )
        ],
      );
  }
}



class AdminProfil extends StatefulWidget {
  const AdminProfil({super.key});

  @override
  State<AdminProfil> createState() => _AdminProfilState();
}

class _AdminProfilState extends State<AdminProfil> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          indicatorColor: Color.fromRGBO(12, 10, 49, 1),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          labelColor: Colors.black,
          tabs: [
            Tab(text: "Profile",),
            Tab(text: "Rent Data",),
          ]),
        body: TabBarView(children: [
          AdminProfilProfil(),
          Text("Ini Rent Data")
        ]),
      ),
    );
  }
}


class AdminProfilProfil extends StatefulWidget {
  const AdminProfilProfil({super.key});

  @override
  State<AdminProfilProfil> createState() => _AdminProfilProfilState();
}

class _AdminProfilProfilState extends State<AdminProfilProfil> {
  TextEditingController usernameController = TextEditingController(text: "@squarepants");
  TextEditingController emailController = TextEditingController(text: "spongebobsquare@gmail.com");
  TextEditingController phoneController = TextEditingController(text: "+62 821394485123");
  TextEditingController addressController = TextEditingController(text: "Jl Gadjah Mada No. 666 Bekasi");

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("images/admin_rent.png"),
          ),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "Username", controllerNama: usernameController, keyboardType: TextInputType.text, hanyaBaca: true,),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "Email", controllerNama: emailController, keyboardType: TextInputType.emailAddress, hanyaBaca: true,),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "No Telp", controllerNama: phoneController, keyboardType: TextInputType.phone, hanyaBaca: true,),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "Address", controllerNama: addressController, keyboardType: TextInputType.text, hanyaBaca: true,),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AdminProfilEdit();
            }));
          }, child: Text("Edit Profile"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(74, 73, 148, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              minimumSize: Size(double.infinity, 50)
            ),
          )
        ],
      ),
    );
  }
}


class AdminProfilEdit extends StatefulWidget {
  const AdminProfilEdit({super.key});

  @override
  State<AdminProfilEdit> createState() => _AdminProfilEditState();
}

class _AdminProfilEditState extends State<AdminProfilEdit> {
  TextEditingController usernameController = TextEditingController(text: "@squarepants");
  TextEditingController emailController = TextEditingController(text: "spongebobsquare@gmail.com");
  TextEditingController phoneController = TextEditingController(text: "+62 821394485123");
  TextEditingController addressController = TextEditingController(text: "Jl Gadjah Mada No. 666 Bekasi");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Edit Profile"),
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ListView(
        children: [
          SizedBox(height: 20,),
          Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Image(image: AssetImage("images/admin_rent.png")),
                ),
                Positioned(
                  child: IconButton(onPressed: (){},
                    icon: Icon(Icons.edit_outlined)),
                  right: -10,
                  bottom: -10,
                )
              ],
            ),
          ),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "Username", controllerNama: usernameController, keyboardType: TextInputType.text),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "Email", controllerNama: emailController, keyboardType: TextInputType.emailAddress),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "No Telp", controllerNama: phoneController, keyboardType: TextInputType.phone),
          SizedBox(height: 10,),
          FormGroup(stringNamaLabel: "Address", controllerNama: addressController, keyboardType: TextInputType.text),
          SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Save Change"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(74, 73, 148, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              minimumSize: Size(double.infinity, 50)
            ),
          )
        ],
      )),
    );
  }
}