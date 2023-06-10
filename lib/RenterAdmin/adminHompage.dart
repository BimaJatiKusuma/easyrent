import 'package:easyrent/Componen/form.dart';
import 'package:easyrent/RenterAdmin/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({
    this.selectedIndex = 1,
    super.key
    });

  int selectedIndex;
  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  void _onItemTap(int index){
    setState(() {
      widget.selectedIndex = index;
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
        child: _widgetOptions.elementAt(widget.selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      currentIndex: widget.selectedIndex,
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
