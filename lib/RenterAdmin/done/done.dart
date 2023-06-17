import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/RenterAdmin/request/request_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  CollectionReference _orderList = FirebaseFirestore.instance.collection('orders');
  late Stream _streamOrder;
  @override
  void initState() {
    _streamOrder = _orderList.where('id_admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', isEqualTo: 300).snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Completed"),
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
            List listQueryDocumentSnapshot = _querySnapshot.docs;
            if(listQueryDocumentSnapshot.length ==0){
              return Center(child: Text("No orders have been completed yet"),);
            }
            return ListView.builder(
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
                      return DoneItem(dataOrder: orderData, dataVehicle: dataVehicle);
                    }
                    return CircularProgressIndicator();
                  },
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      )

    );
  }
}

class DoneItem extends StatefulWidget {
  DoneItem({
    required this.dataOrder,
    required this.dataVehicle,
    super.key,
  });
    final QueryDocumentSnapshot dataOrder;
    final Map dataVehicle;
  @override
  State<DoneItem> createState() => _DoneItemState();
}

class _DoneItemState extends State<DoneItem> {
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
                        Text(widget.dataOrder['drop_off_date']),
                        Text("DONE")
                      ],
                    ),
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