import "package:cloud_firestore/cloud_firestore.dart";
import "package:easyrent/Renter/test_countdown/test.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
class RenterChat extends StatefulWidget {
  const RenterChat({super.key});

  @override
  State<RenterChat> createState() => _RenterChatState();
}

class _RenterChatState extends State<RenterChat> {
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
            Tab(text: "Active",),
            Tab(text: "Complete",),
          ]),
        body: TabBarView(children: [
          RenterOrderActive(),
          RenterOrderComplete()
        ]),
      ),
    );
  }
}

class RenterOrderActive extends StatefulWidget {
  const RenterOrderActive({super.key});

  @override
  State<RenterOrderActive> createState() => _RenterOrderActiveState();
}

class _RenterOrderActiveState extends State<RenterOrderActive> {
  CollectionReference _orderList = FirebaseFirestore.instance.collection('orders');
  late Stream _streamOrder;
  List statusOrder = [100,200,400];
  @override
  void initState() {
    _streamOrder = _orderList.where('id_renter', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', whereIn:List.of(statusOrder)).snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _orderList.snapshots();
    return Scaffold(
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
              return Center(child: Text("No Orders Yet"),);
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
                      return ContainerCustomeShadowOrder(vehicleUrl: dataVehicle['url_photo'], vehicleName: dataVehicle['vehicle_name'], orderDropOff: orderData['drop_off_date'], orderStatus: orderData['status_order'], orderUID: orderData.id, orderPhotoID: orderData['card_id_url'],);
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

class RenterOrderComplete extends StatefulWidget {
  const RenterOrderComplete({super.key});

  @override
  State<RenterOrderComplete> createState() => _RenterOrderCompleteState();
}

class _RenterOrderCompleteState extends State<RenterOrderComplete> {
  CollectionReference _orderList = FirebaseFirestore.instance.collection('orders');
  late Stream _streamOrder;
  @override
  void initState() {
    _streamOrder = _orderList.where('id_renter', isEqualTo: FirebaseAuth.instance.currentUser!.uid).where('status_order', isEqualTo: 300).snapshots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    _orderList.snapshots();
    return Scaffold(
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
                      return ContainerCustomeShadowOrder(vehicleUrl: dataVehicle['url_photo'], vehicleName: dataVehicle['vehicle_name'], orderDropOff: orderData['drop_off_date'], orderStatus: orderData['status_order'], orderUID: orderData.id, orderPhotoID: orderData['card_id_url'],);
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







class ContainerCustomeShadowOrder extends StatefulWidget {
  ContainerCustomeShadowOrder({
    required this.vehicleUrl,
    required this.orderPhotoID,
    required this.vehicleName,
    required this.orderUID,
    required this.orderDropOff,
    required this.orderStatus,
    super.key,
  });

  final String vehicleUrl;
  final String vehicleName;
  final String orderPhotoID;
  final String orderUID;
  final String orderDropOff;
  final int orderStatus;

  @override
  State<ContainerCustomeShadowOrder> createState() => _ContainerCustomeShadowOrderState();
}

class _ContainerCustomeShadowOrderState extends State<ContainerCustomeShadowOrder> {
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
            child: Image(image: NetworkImage(widget.vehicleUrl)),
          ),
          SizedBox(width: 10,),

          _divideByStatus(widget.orderStatus),
        ],
      ),
    );
  }

  _divideByStatus(status){
    if(status == 100){
      return _order100();
    }
    if(status == 200){
      return _order200();
    }
    if(status == 300){
      return _order300();
    }
    if(status == 400){
      return _order400();
    }
  }

  _order100(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.vehicleName, style: TextStyle(fontWeight: FontWeight.w800),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("Time Remaining", style: TextStyle(fontSize: 14),),
                  // Text("21:43: 29", style: TextStyle(fontSize: 14),),
                  Text("Menunggu Konfirmasi", style: TextStyle(fontSize: 14),),
                ],
              ),
              Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onPressed: () async{
                      await FirebaseStorage.instance.refFromURL(widget.orderPhotoID).delete();
                      await FirebaseFirestore.instance.collection('orders').doc(widget.orderUID).delete();
                    },
                    child: Text("Batal")),
              )

            ],
          )
        ],
      ),
    );
  }

  _order200(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.vehicleName, style: TextStyle(fontWeight: FontWeight.w800),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time Remaining", style: TextStyle(fontSize: 14),),
                  TestCountDown(dropOffDate: widget.orderDropOff,)
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
                      await FirebaseFirestore.instance.collection('orders').doc(widget.orderUID).update({
                        'status_order':300
                      });
                    },
                    child: Text("Done")),
              )

            ],
          )
        ],
      ),
    );
  }


  _order300(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.vehicleName, style: TextStyle(fontWeight: FontWeight.w800),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.orderDropOff),
                  Text("DONE")
                ],
              ),
            ],
          )
        ],
      ),
    );
  }


    _order400(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.vehicleName, style: TextStyle(fontWeight: FontWeight.w800),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text("Time Remaining", style: TextStyle(fontSize: 14),),
                  // Text("21:43: 29", style: TextStyle(fontSize: 14),),
                  Text("Pemesanan Ditolak", style: TextStyle(fontSize: 14),),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }















}

