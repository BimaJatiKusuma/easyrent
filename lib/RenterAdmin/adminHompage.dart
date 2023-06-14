import 'package:easyrent/Componen/form.dart';
import 'package:easyrent/RenterAdmin/done/done.dart';
import 'package:easyrent/RenterAdmin/product_car/product.dart';
import 'package:easyrent/RenterAdmin/profile/profile.dart';
import 'package:easyrent/RenterAdmin/request/request.dart';
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
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Request();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
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
                  )
                ),
                Container(
                  width: 160,
                  height: 80,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Done();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      )
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
                  )
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
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text("Select Category", style: TextStyle(fontWeight: FontWeight.w800), textAlign: TextAlign.start,)),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SelectCategory(nama: "Bicycle", alamatGambar: "images/bicycle.png", newRoute: ProductCar(category: "bicycle"),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Motor", alamatGambar: "images/motor.png", newRoute: ProductCar(category: "motorcycle"),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Car", alamatGambar: "images/car.png", newRoute: ProductCar(category: "car",),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Bus", alamatGambar: "images/bus.png", newRoute: ProductCar(category: "bus"),)
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),

                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ongoing", style: TextStyle(fontWeight: FontWeight.w800),),
                              OnGoing(),
                              OnGoing(),
                              OnGoing(),
                              OnGoing(),
                              OnGoing(),
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),
                      ],
                    ),
                  )
                ],
              ),
            )
          )
        ],
      );
  }
}



class SelectCategory extends StatelessWidget {
  final String nama;
  final String alamatGambar;
  final dynamic newRoute;
  const SelectCategory({
    required this.nama,
    required this.alamatGambar,
    required this.newRoute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return newRoute;
        }));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(239, 229, 237, 1),
        foregroundColor: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(alamatGambar), width: 50, height: 50,),
          Text(nama)
        ],
      ),
    );
  }
}


class OnGoing extends StatefulWidget {
  const OnGoing({super.key});

  @override
  State<OnGoing> createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4
            )
          ]
        ),
        width: double.infinity,
        height: 120,
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Image(image: AssetImage("images/carsItem.png"),)
            ),
            SizedBox(width: 10,),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Honda Brio"),
                        Text("Remaining time", style: TextStyle(fontSize: 14, color: Color.fromRGBO(164, 118, 0, 1)),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 15,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        onPressed: (){},
                        child: Text("Done"))
                    ],
                  )
                ],
              )
            )
          ],
        ),
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
