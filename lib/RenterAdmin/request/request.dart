import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/RenterAdmin/request/request_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  CollectionReference _orderList = FirebaseFirestore.instance.collection('orders');
  late Stream _streamOrder;

  @override
  void initState() {
    _streamOrder = _orderList.where('id_admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', isEqualTo: 100).snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _orderList.snapshots();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Request"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: StreamBuilder(
        stream: _streamOrder,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text(snapshot.hasError.toString()),);
          }
          if(snapshot.connectionState == ConnectionState.active){
            QuerySnapshot _querySnapshot = snapshot.data;
            List _listQueryDocumentSnapshot = _querySnapshot.docs;
            if(_listQueryDocumentSnapshot.length == 0){
              return Center(child: Text("No Orders Yet"),);
            }
            return ListView.builder(
              itemCount: _listQueryDocumentSnapshot.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot _orderData = _listQueryDocumentSnapshot[index];
                late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataVehicle = FirebaseFirestore.instance.collection('vehicle').doc(_orderData['id_vehicle']).get();
                late Map _dataVehicle;
                
                late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataUsers = FirebaseFirestore.instance.collection('users').doc(_orderData['id_renter']).get();
                late Map _dataUsers;
                return FutureBuilder(
                  future: _futureDataVehicle,
                  builder: (context, snapshot2) {
                    if(snapshot2.hasError){
                      return Center(child: Text(snapshot2.hasError.toString()),);
                    }
                    if(snapshot2.hasData){
                      _dataVehicle = snapshot2.data!.data() as Map;
                      return FutureBuilder(
                        future: _futureDataUsers,
                        builder: (context, snapshot3) {
                          if(snapshot3.hasError){
                            return Center(child: Text(snapshot2.hasError.toString()),);
                          }
                          if(snapshot3.hasData){
                            _dataUsers = snapshot3.data!.data() as Map;
                            
                            return RequestItem(vehicleUrl: _dataVehicle['url_photo'], vehicleName: _dataVehicle['vehicle_name'], orderUID: _orderData.id, orderPickUp: _orderData['pick_up_date']);
                          }
                          return CircularProgressIndicator();
                        },
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
    );
  }
}

class RequestItem extends StatelessWidget {
  const RequestItem({
    required this.vehicleUrl,
    required this.vehicleName,
    required this.orderUID,
    required this.orderPickUp,
    super.key,
  });

  final String vehicleUrl;
  final String vehicleName;
  final String orderUID;
  final String orderPickUp;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return RequestDetail(orderUID: orderUID,);
        }));
      },
      child: Container(
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
              child: Image(image: NetworkImage(vehicleUrl),)
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
                        Text(vehicleName),
                        Text(orderPickUp, style: TextStyle(fontSize: 14, color: Color.fromRGBO(164, 118, 0, 1)),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(148, 23, 23, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance.collection('orders').doc(orderUID).update({
                            'status_order':400
                          });
                        },
                        child: Text("Reject")
                      ),
                      SizedBox(width: 15,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                        onPressed: (){
                          FirebaseFirestore.instance.collection('orders').doc(orderUID).update({
                            'status_order':200
                          });
                        },
                        child: Text("Acc"))
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}