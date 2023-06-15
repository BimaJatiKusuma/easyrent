import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/Renter/order/renterFormRent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RenterListVehicle extends StatefulWidget {
  RenterListVehicle({
    required this.category,
    super.key
    });

    final int category;
  @override
  State<RenterListVehicle> createState() => _RenterListVehicleState();
}

class _RenterListVehicleState extends State<RenterListVehicle> {
  _getCategory(category){
    if(category == 100){
      return "BICYCLE";
    }
    else if (category == 200){
      return "MOTORCYCLE";
    }
    else if (category == 300){
      return "CAR";
    }
    else if (category == 400){
      return "BUS";
    }
    else {return "Error";}
  }

  CollectionReference _vehicleList = FirebaseFirestore.instance.collection('vehicle');
  late Stream _streamVehicle;
  
  @override
  void initState() {
    _streamVehicle = _vehicleList.where('id_category', isEqualTo: widget.category).where('deleted_at', isEqualTo: '').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _vehicleList.snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Cars"),
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            // color: Colors.red,
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SortByListVehicle(child: Icon(Icons.tune_rounded),),
                SortByListVehicle(child: Text("Jember")),
                SortByListVehicle(child: Text("Malang")),
                SortByListVehicle(child: Text("Surabaya")),
              ],
            ),
          ),
          
          // SizedBox(height: 10,),

          Expanded(
            child: StreamBuilder(
              stream: _streamVehicle,
              builder: (context, snapshot) {
                if (snapshot.hasError){
                  return Center(child: Text(snapshot.hasError.toString()),);
                }
                if (snapshot.connectionState == ConnectionState.active){
                  QuerySnapshot querySnapshot = snapshot.data;
                  List listQueryDocumentSnapshot = querySnapshot.docs;
                  return ListView.builder(
                    itemCount: listQueryDocumentSnapshot.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot vehicleData = listQueryDocumentSnapshot[index];
                      late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataAdmin = FirebaseFirestore.instance.collection('users_admin').doc(vehicleData['id_admin']).get();
                      late Map dataAdmin;
                      return FutureBuilder(
                        future: _futureDataAdmin,
                        builder: (context, snapshot2) {
                          if(snapshot2.hasError){
                            return Center(child: Text(snapshot2.hasError.toString()),);
                          }
                          if(snapshot2.hasData){
                            dataAdmin = snapshot2.data!.data() as Map;
                            return ListVehicleDataView(
                              vehicleURLphoto: vehicleData['url_photo'],
                              vehicleName: vehicleData['vehicle_name'],
                              vehicleAdminName: dataAdmin['username'],
                              vehiclePrice: vehicleData['price'],
                              vehicleAdminAddress: dataAdmin['address'],
                              vehicleUID: vehicleData.id,
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator(),);
              },
            )
            // ListView(
            //   children: [
            //     ListVehicleDataView(),
            //   ],
            // ),
          ),
        ],
      ),
    );
  }
}




class SortByListVehicle extends StatelessWidget {
  final Widget child;
  const SortByListVehicle({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: ElevatedButton(onPressed: (){}, child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(239, 229, 237, 1),
          foregroundColor: Colors.black
        ),
        ));
  }
}







class ListVehicleDataView extends StatelessWidget {
  const ListVehicleDataView({
    required this.vehicleURLphoto,
    required this.vehicleName,
    required this.vehicleAdminName,
    required this.vehicleAdminAddress,
    required this.vehiclePrice,
    required this.vehicleUID,
    super.key,
  });

  final String vehicleURLphoto;
  final String vehicleName;
  final String vehicleAdminName;
  final String vehicleAdminAddress;
  final int vehiclePrice;
  final String vehicleUID;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
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
      height: 150,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Image(image: NetworkImage(vehicleURLphoto),))
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
                      Text(vehicleName, style: TextStyle(fontWeight: FontWeight.w600),),
                      Text("@${vehicleAdminName}", style: TextStyle(fontSize: 14),),
                      Text("Rp. ${vehicleAdminAddress}", style: TextStyle(fontSize: 10),),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${vehiclePrice}/day", style: TextStyle(fontSize: 14, color: Color.fromRGBO(189, 85, 37, 1)),),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return RenterFormRent(vehicleUID: vehicleUID,);
                        }));
                      },
                      child: Text("Rent"))
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