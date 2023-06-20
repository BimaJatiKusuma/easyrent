import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/Componen/abooutInformation.dart';
import 'package:easyrent/Componen/form.dart';
import 'package:easyrent/Renter/test_countdown/test.dart';
import 'package:easyrent/RenterAdmin/done/done.dart';
import 'package:easyrent/RenterAdmin/product_car/product.dart';
import 'package:easyrent/RenterAdmin/profile/profile.dart';
import 'package:easyrent/RenterAdmin/request/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdminHomePage extends StatefulWidget {
  AdminHomePage({
    this.selectedIndex = 0,
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
    // Center(child: Text("???"),),
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
          // BottomNavigationBarItem(icon: Icon(Icons.message_rounded), label: ""),
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
  String urlPhoto = '';
  String username = '';
  CollectionReference _orderList = FirebaseFirestore.instance.collection('orders');
  late Stream _streamOrderReq;
  late Stream _streamOrderDone;
  late Stream _streamOrderOnGoing;
  List statusOrder = [100,200,400];
  @override
  void initState() {
    FirebaseFirestore.instance.collection('users_admin').doc(FirebaseAuth.instance.currentUser!.uid).get().then((DocumentSnapshot document){
      if(document.exists){
        var x = document.data() as Map;
        setState(() {
          urlPhoto = x['photo_profile'];
          username = x['username'];
        });
      }
      else{
        print("false");
      }
    });
    _streamOrderOnGoing = _orderList.where('id_admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', isEqualTo: 200).snapshots();
    _streamOrderReq = _orderList.where('id_admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', isEqualTo: 100).snapshots();
    _streamOrderDone = _orderList.where('id_admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', isEqualTo: 300).snapshots();
    // _streamOrderDone = _orderList.where('id_admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', isEqualTo: 400).snapshots().map((event){return event.size;});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _orderList.snapshots();
    print("hallo");
    // print(totalOrderReq.toString());
    // print(_streamOrderReq.length);
    print("hallo");
    // print(_streamOrderDone.toList().then((value){return value.length.toString();}));
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
                  backgroundImage: urlPhoto == '' ? AssetImage("images/default_user.png"): Image.network(urlPhoto).image,
                ),
                Text("@${username}")
              ],
            ),
          ),

          SizedBox(height: 20,),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StreamBuilder(
                  stream: _streamOrderReq,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(child: Text(snapshot.hasError.toString()),);
                    }
                    if(snapshot.connectionState == ConnectionState.active){
                      QuerySnapshot _querySnapshot = snapshot.data;
                      List listQueryDocumentSnapshot = _querySnapshot.docs;
                      return Container(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Request", style: TextStyle(color: Colors.white),),
                                  Expanded(
                                    // height: double.infinity,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        listQueryDocumentSnapshot.length.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                        ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                StreamBuilder(
                  stream: _streamOrderDone,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(child: Text(snapshot.hasError.toString()),);
                    }
                    if(snapshot.connectionState == ConnectionState.active){
                      QuerySnapshot _querySnapshot = snapshot.data;
                      // QuerySnapshot _querySnapshot = snapshot.data;
                      List listQueryDocumentSnapshot = _querySnapshot.docs;
                      return Container(
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Accepted", style: TextStyle(color: Colors.white),),
                              Expanded(
                                // height: double.infinity,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    listQueryDocumentSnapshot.length.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                    ),
                                ),
                              )
                            ],
                          ),
                        )
                      );
                          }
                          return CircularProgressIndicator();
                        },
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
                              SelectCategory(nama: "Bicycle", alamatGambar: "images/bicycle.png", newRoute: ProductCar(category: 100),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Motor", alamatGambar: "images/motor.png", newRoute: ProductCar(category: 200),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Car", alamatGambar: "images/car.png", newRoute: ProductCar(category: 300,),),
                              SizedBox(width: 20,),
                              SelectCategory(nama: "Bus", alamatGambar: "images/bus.png", newRoute: ProductCar(category: 400),)
                            ],
                          ),
                        ),

                        SizedBox(height: 30,),
                        
                        StreamBuilder(
                          stream: _streamOrderOnGoing,
                          builder: (context, snapshot) {
                            if(snapshot.hasError){
                              return Center(child: Text(snapshot.hasError.toString()),);
                            }
                            if(snapshot.connectionState == ConnectionState.active){
                              QuerySnapshot _querySnapshot = snapshot.data;
                              List listQueryDocumentSnapshot = _querySnapshot.docs;
                              if(listQueryDocumentSnapshot.length ==0){
                                return Center(child: Text("No Orders Yet"),);
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: listQueryDocumentSnapshot.length,
                                itemBuilder: (context, index) {
                                  QueryDocumentSnapshot orderData = listQueryDocumentSnapshot[index];
                                  late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataVehicle = FirebaseFirestore.instance.collection('vehicle').doc(orderData['id_vehicle']).get();
                                  late Map dataVehicle;
                                  return FutureBuilder(
                                    future: _futureDataVehicle,
                                    builder: (context, snapshot2) {
                                      if(snapshot2.hasError){
                                        return Center(child: Text(snapshot2.hasError.toString()),);
                                      }
                                      if(snapshot2.hasData){
                                        dataVehicle = snapshot2.data!.data() as Map;
                                        return OnGoing(dataOrder: orderData, dataVehicle: dataVehicle);
                                      }
                                      return CircularProgressIndicator();
                                    },
                                  );
                                },
                              );
                            }
                            return CircularProgressIndicator();
                          },
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
  OnGoing({
    required this.dataOrder,
    required this.dataVehicle,
    super.key
    });

    final QueryDocumentSnapshot dataOrder;
    final Map dataVehicle;
  @override
  State<OnGoing> createState() => _OnGoingState();
}

class _OnGoingState extends State<OnGoing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            width: 75,
            child: Image(image: NetworkImage(widget.dataVehicle['url_photo'])),
          ),
          SizedBox(width: 10,),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.dataVehicle['vehicle_name'], style: TextStyle(fontWeight: FontWeight.w800),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Time Remaining", style: TextStyle(fontSize: 14),),
                        TestCountDown(dropOffDate: widget.dataOrder['drop_off_date'],)
                      ],
                    ),
                    Container(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          onPressed: () async{
                            await FirebaseFirestore.instance.collection('orders').doc(widget.dataOrder.id).update({
                              'status_order':300
                            });
                          },
                          child: Text("Done")),
                    )

                  ],
                )
              ],
            ),
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
      length: 1,
      child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("PROFILE"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AboutInformation();
            }));
          }, icon: Icon(Icons.info, color: Colors.white,))
        ],
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
        body: AdminProfilProfil()
      ),
    );
  }
}
