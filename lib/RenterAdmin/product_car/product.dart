import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/RenterAdmin/product_car/product_add.dart';
import 'package:easyrent/RenterAdmin/product_car/product_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductCar extends StatefulWidget {
  ProductCar({
    required this.category,
    super.key
    });
  final int category;
  @override
  State<ProductCar> createState() => _ProductCarState();
}

class _ProductCarState extends State<ProductCar> {
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
    _streamVehicle = _vehicleList.where('id_admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('id_category', isEqualTo: widget.category).where('deleted_at', isEqualTo: '').snapshots();
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
        title: Text(_getCategory(widget.category)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ProductCarAdd(category: widget.category,);
            }));
          }, icon: Icon(Icons.add))
        ],
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body:
          StreamBuilder(
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
                    return ProductCarItem(vehicleURLphoto: vehicleData['url_photo'], vehicleName: vehicleData["vehicle_name"], vehicleStatus: vehicleData['available'], vehicleUID: vehicleData.id,);
                  },
                );
              }
              return Center(child: CircularProgressIndicator(),);
            },
          )
    );
  }
}



class ProductCarItem extends StatefulWidget {
  ProductCarItem({
    required this.vehicleURLphoto,
    required this.vehicleName,
    required this.vehicleStatus,
    required this.vehicleUID,
    super.key,
  });

  final String vehicleURLphoto;
  final String vehicleName;
  final int vehicleStatus;
  final String vehicleUID;

  @override
  State<ProductCarItem> createState() => _ProductCarItemState();
}

class _ProductCarItemState extends State<ProductCarItem> {
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
      height: 120,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Image(image: NetworkImage(widget.vehicleURLphoto),),
              )
            
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
                      Text(widget.vehicleName),
                      Text("status ${widget.vehicleStatus}", style: TextStyle(fontSize: 14, color: Color.fromRGBO(164, 118, 0, 1)),),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Color.fromRGBO(148, 23, 23, 1),)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ProductCarEdit(vehicleUID: widget.vehicleUID);
                        }));
                      },
                      child: Text("Edit"))
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