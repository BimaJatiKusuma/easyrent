import 'package:easyrent/Componen/form.dart';
import 'package:easyrent/Renter/profile/profile.dart';
import 'package:easyrent/Renter/renterChat.dart';
import 'package:easyrent/Renter/listvehicle/renterListVehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RenterHomePage extends StatefulWidget {
  RenterHomePage({
    this.selectedIndex = 1,
    super.key
    });

  int selectedIndex;
  @override
  State<RenterHomePage> createState() => _RenterHomePageState();
}

class _RenterHomePageState extends State<RenterHomePage> {
  void _onItemTap(int index){
    setState(() {
      widget.selectedIndex = index;
    });
  }
  List _widgetOptions = [
    RenterChat(),
    RenterMainHomepage(),
    RenterProfil(),
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




class RenterMainHomepage extends StatefulWidget {
  const RenterMainHomepage({super.key});

  @override
  State<RenterMainHomepage> createState() => _RenterMainHomepageState();
}

class _RenterMainHomepageState extends State<RenterMainHomepage> {
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
                  backgroundImage: AssetImage("images/renter.png"),
                ),
                Text("@squarepants")
              ],
            ),
          ),

          SizedBox(height: 20,),

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
                              SelectCategory(nama: "Bicycle", alamatGambar: "images/bicycle.png", newRoute: RenterListVehicle(category: 100),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Motor", alamatGambar: "images/motor.png", newRoute: RenterListVehicle(category: 200),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Car", alamatGambar: "images/car.png", newRoute: RenterListVehicle(category: 300),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Bus", alamatGambar: "images/bus.png", newRoute: RenterListVehicle(category: 400),)
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),

                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("promo", style: TextStyle(fontWeight: FontWeight.w800),),
                                  GestureDetector(
                                    child: Text("See more", style: TextStyle(color: Color.fromRGBO(189, 85, 37, 1)),),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4
                                    )
                                  ]
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),
                        
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text("News", style: TextStyle(fontWeight: FontWeight.w800),)),
                              Container(
                                height: 100,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    NewsComponent(alamatGambar: "images/news1.png",),
                                    NewsComponent(alamatGambar: "images/news2.png",),
                                    NewsComponent(alamatGambar: "images/news3.png",),
                                    NewsComponent(alamatGambar: "images/news4.png",),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
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

class NewsComponent extends StatelessWidget {
  final String alamatGambar;
  const NewsComponent({
    required this.alamatGambar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(00, 0, 10, 0),
      child: Image(image: AssetImage(alamatGambar)),
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

class RenterProfil extends StatefulWidget {
  const RenterProfil({super.key});

  @override
  State<RenterProfil> createState() => _RenterProfilState();
}

class _RenterProfilState extends State<RenterProfil> {
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
          RenterProfilProfil(),
          Text("Ini Rent Data")
        ]),
      ),
    );
  }
}


// class AdminProfilProfil extends StatefulWidget {
//   const AdminProfilProfil({super.key});

//   @override
//   State<AdminProfilProfil> createState() => _AdminProfilProfilState();
// }

// class _AdminProfilProfilState extends State<AdminProfilProfil> {
//   TextEditingController usernameController = TextEditingController(text: "@squarepants");
//   TextEditingController emailController = TextEditingController(text: "spongebobsquare@gmail.com");
//   TextEditingController phoneController = TextEditingController(text: "+62 821394485123");
//   TextEditingController addressController = TextEditingController(text: "Jl Gadjah Mada No. 666 Bekasi");

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage("images/renter.png"),
//           ),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "Username", controllerNama: usernameController, keyboardType: TextInputType.text, hanyaBaca: true,),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "Email", controllerNama: emailController, keyboardType: TextInputType.emailAddress, hanyaBaca: true,),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "No Telp", controllerNama: phoneController, keyboardType: TextInputType.phone, hanyaBaca: true,),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "Address", controllerNama: addressController, keyboardType: TextInputType.text, hanyaBaca: true,),
//           SizedBox(height: 30,),
//           ElevatedButton(onPressed: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context){
//               return AdminProfilEdit();
//             }));
//           }, child: Text("Edit Profile"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromRGBO(74, 73, 148, 1),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20)
//               ),
//               minimumSize: Size(double.infinity, 50)
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


// class AdminProfilEdit extends StatefulWidget {
//   const AdminProfilEdit({super.key});

//   @override
//   State<AdminProfilEdit> createState() => _AdminProfilEditState();
// }

// class _AdminProfilEditState extends State<AdminProfilEdit> {
//   TextEditingController usernameController = TextEditingController(text: "@squarepants");
//   TextEditingController emailController = TextEditingController(text: "spongebobsquare@gmail.com");
//   TextEditingController phoneController = TextEditingController(text: "+62 821394485123");
//   TextEditingController addressController = TextEditingController(text: "Jl Gadjah Mada No. 666 Bekasi");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){
//           Navigator.pop(context);
//         }, icon: Icon(Icons.keyboard_double_arrow_left)),
//         title: Text("Edit Profile"),
//         backgroundColor: Color.fromRGBO(12, 10, 49, 1),
//       ),
//       body: Container(
//       padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
//       child: ListView(
//         children: [
//           SizedBox(height: 20,),
//           Container(
//             alignment: Alignment.center,
//             width: 100,
//             height: 100,
//             child: Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   child: Image(image: AssetImage("images/renter.png")),
//                 ),
//                 Positioned(
//                   child: IconButton(onPressed: (){},
//                     icon: Icon(Icons.edit_outlined)),
//                   right: -10,
//                   bottom: -10,
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "Username", controllerNama: usernameController, keyboardType: TextInputType.text),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "Email", controllerNama: emailController, keyboardType: TextInputType.emailAddress),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "No Telp", controllerNama: phoneController, keyboardType: TextInputType.phone),
//           SizedBox(height: 10,),
//           FormGroup(stringNamaLabel: "Address", controllerNama: addressController, keyboardType: TextInputType.text),
//           SizedBox(height: 30,),
//           ElevatedButton(onPressed: (){
//             Navigator.pop(context);
//           }, child: Text("Save Change"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromRGBO(74, 73, 148, 1),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20)
//               ),
//               minimumSize: Size(double.infinity, 50)
//             ),
//           )
//         ],
//       )),
//     );
//   }
// }