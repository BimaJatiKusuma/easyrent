import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/Componen/custombox1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RequestDetail extends StatelessWidget {
  RequestDetail({
    required this.orderUID,
    super.key
    });
  final String orderUID;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataOrder = FirebaseFirestore.instance.collection('orders').doc(orderUID).get();
  late Map _dataOrder;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Order Details"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: FutureBuilder(
        future: _futureDataOrder,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text(snapshot.hasError.toString()),);
          }
          if(snapshot.hasData){
            _dataOrder = snapshot.data!.data() as Map;
                late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataVehicle = FirebaseFirestore.instance.collection('vehicle').doc(_dataOrder['id_vehicle']).get();
                late Map _dataVehicle;
                
                late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataUsers = FirebaseFirestore.instance.collection('users').doc(_dataOrder['id_renter']).get();
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
                            
                            return RequestItem(
                              // vehicleUID: vehicleUID,
                              vehiclePhotoURL: _dataVehicle['url_photo'],
                              vehicleName: _dataVehicle['vehicle_name'],
                              vehicleColor: _dataVehicle['color'],
                              vehicleSeats: _dataVehicle['seat'].toString(),
                              vehiclePlate: _dataVehicle['plate_number'],
                              // adminUID: adminUID,
                              adminName: _dataUsers['username'],
                              adminPhone: _dataUsers['phone_number'],
                              latPickUp: _dataOrder['pick_loc_lat'],
                              longPickUp: _dataOrder['pick_loc_long'],
                              urlPhotoID: _dataOrder['card_id_url'],
                              orderPrice: _dataOrder['total_price'],
                              orderDuration: int.parse(_dataOrder['duration']),
                              orderUID: orderUID,
                              orderStatus: _dataOrder['status_order'],
                              orderPickUp: _dataOrder['pick_up_date'],
                              orderDropOff: _dataOrder['drop_off_date']);
                          }
                          return CircularProgressIndicator();
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      )

      // ListView(
      //   children: [
      //     ContainerCustomShadow(containerChild: RequestDetailVehicle()),
      //     ContainerCustomShadow(containerChild: RequestDetailPickUpLocation()),
      //     ContainerCustomShadow(containerChild: RequestDetailIdCard()),
      //     Container(
      //       width: double.infinity,
      //       padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      //       child: ElevatedButton(
      //         onPressed: (){},
      //         child: Text("Send")),
      //     )
      //   ],
      // ),
    );
  }
}


class RequestItem extends StatefulWidget {
  RequestItem({
    // required this.vehicleUID,
    required this.vehiclePhotoURL,
    required this.vehicleName,
    required this.vehicleColor,
    required this.vehicleSeats,
    required this.vehiclePlate,
    // required this.adminUID,
    required this.adminName,
    required this.adminPhone,
    required this.latPickUp,
    required this.longPickUp,
    required this.urlPhotoID,
    required this.orderPrice,
    required this.orderUID,
    required this.orderStatus,
    required this.orderDuration,
    required this.orderPickUp,
    required this.orderDropOff,
    super.key
    });

    // final String vehicleUID;
    final String vehiclePhotoURL;
    final String vehicleName;
    final String vehicleColor;
    final String vehicleSeats;
    final String vehiclePlate;
    // final String adminUID;
    final String adminName;
    final String adminPhone;
    final String latPickUp;
    final String longPickUp;
    final String urlPhotoID;
    final int orderPrice;
    final String orderUID;
    final int orderStatus;
    final String orderPickUp;
    final String orderDropOff;
    final int orderDuration;
  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
Future<Position> lokasiSekarang() async{
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if(!serviceEnabled){
  //   return Future.error('Location services are disabled');
  // }

  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error('Location permissions are denied');
    }
  }
  if(permission == LocationPermission.deniedForever){
    return Future.error('Location permissions are permanently denied, we cannot request location');
  }

  return await Geolocator.getCurrentPosition();
}

late String lat=widget.latPickUp;
late String long=widget.longPickUp;
Set<Marker> markers = {};
late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(target: LatLng(double.parse(lat), double.parse(long)), zoom: 16);
    markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(double.parse(lat), double.parse(long))));
    print(widget.orderDuration);
    print(widget.orderDropOff);
    print(widget.orderPickUp);
    return Scaffold(
      body: ListView(
        children: [
          ContainerCustomShadow(containerChild: RenterDetailVehicle(vehiclePhotoURL: widget.vehiclePhotoURL, vehicleName: widget.vehicleName, vehicleSeats: widget.vehicleSeats, vehiclePlate: widget.vehiclePlate, vehiclePrice: widget.orderPrice, adminName: widget.adminName, adminPhone: widget.adminPhone, orderDuration: widget.orderDuration, orderPickUp: widget.orderPickUp, orderDropOff: widget.orderDropOff, vehicleColor: widget.vehicleColor,)),
          
          ContainerCustomShadow(containerChild: RenterOrderDetailsButton(labelButton: "Pick-up Location", namaButton: lat =="" ? "Set your pick-up location please" : "${lat}, ${long}", onPressed: () async {
            // await lokasiSekarang().then((value){
            //   lat = '${value.latitude}';
            //   long = '${value.longitude}';
            //   print(lat);
            //   print(long);
            //   setState(() {});
            // });
            // googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(double.parse(lat), double.parse(long)), zoom: 16)));
            // markers.clear();
            // markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(double.parse(lat), double.parse(long))));
            // setState(() {});
          },)),


          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 200,
            color: Colors.red,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              zoomControlsEnabled: false,  
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
                // markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(double.parse(lat), double.parse(long))));
              },
            ),
          ),


          ContainerCustomShadow(
            containerChild: RenterOrderDetailsButton(
              labelButton: "ID card (E-KTP)",
              namaButton: "ID Card Information",
              onPressed: (){},)),
          Container(
            height: 200,
            width: 250,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Image(image: NetworkImage(widget.urlPhotoID))
          ),

          SizedBox(height: 10,),
          _confirmStatus(widget.orderStatus, widget.orderUID)
        ],
      ),
    );
  }

  _confirmStatus(statusOrder, orderUID){
    if(statusOrder==100){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(148, 23, 23, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
            onPressed: () async{
              await FirebaseFirestore.instance.collection('orders').doc(orderUID).update({
                'status_order':400
              });
              Navigator.pop(context);
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
            onPressed: ()async{
              await FirebaseFirestore.instance.collection('orders').doc(orderUID).update({
                'status_order':200
              });
              Navigator.pop(context);
            },
            child: Text("Acc"))
        ],
      );
    }
    if(statusOrder==200){
      return Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: ElevatedButton(onPressed: () async{
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(74, 73, 148, 1),
            minimumSize: Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
          child: Text("Delivered")),
      );
    }
    else return Container();
  }
  pickUPLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // print(position);
  //   print("Ini method PickUp");
  }
}


class ContainerCustomShadow extends StatefulWidget {
  Widget containerChild;
  double? height;
  ContainerCustomShadow({
    required this.containerChild,
    this.height,
    super.key,
  });

  @override
  State<ContainerCustomShadow> createState() => _ContainerCustomShadowState();
}

class _ContainerCustomShadowState extends State<ContainerCustomShadow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
      child: widget.containerChild,
    );
  }
}



class RenterOrderDetailsButton extends StatelessWidget {
  final String labelButton;
  final String namaButton;
  final void Function() onPressed;
  const RenterOrderDetailsButton({
    required this.labelButton,
    required this.namaButton,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labelButton),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    minimumSize: Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black)
                    )
                  ),
                  onPressed: onPressed,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(namaButton),
                    Icon(Icons.keyboard_double_arrow_right_rounded)
                  ],
                ),),
              ],
            ),
          );
  }
}


















class RenterDetailVehicle extends StatelessWidget {
  const RenterDetailVehicle({
    required this.vehiclePhotoURL,
    required this.vehicleName,
    required this.vehicleColor,
    required this.vehicleSeats,
    required this.vehiclePlate,
    required this.vehiclePrice,
    required this.adminName,
    required this.adminPhone,
    required this.orderDuration,
    required this.orderPickUp,
    required this.orderDropOff,
    super.key
    });

    final String vehiclePhotoURL;
    final String vehicleName;
    final String vehicleColor;
    final String vehicleSeats;
    final String vehiclePlate;
    final int vehiclePrice;
    final String adminName;
    final String adminPhone;
    final String orderPickUp;
    final String orderDropOff;
    final int orderDuration;
  @override
  Widget build(BuildContext context) {
    var newDate = DateTime.parse(orderPickUp);
    var newDate2 = DateTime.parse(orderPickUp);
    var pickUpDate = DateFormat("dd MMMM yyyy").format(newDate);
    var pickUpTime = DateFormat("HH.mm").format(newDate);
    var dropOff = DateFormat("dd MMMM yyyy, HH.mm").format(newDate2);
    return Column(
      children: [
        Container(
          child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Image(image: NetworkImage(vehiclePhotoURL),)
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
                        Text("@${adminName}", style: TextStyle(fontSize: 14),),
                      ],
                    ),
                  ),
                  Text("Rp. ${vehiclePrice * orderDuration}", style: TextStyle(color: Colors.red),)
                ],
              )
            )
          ],
        ),
        ),
        Table(
          columnWidths: {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(0.3),
            2: FlexColumnWidth(4),
          },
          children: [
            TableRow(
              children: [
                Text("Color"),
                Text(":"),
                Text(vehicleColor)
              ]
            ),
            TableRow(
              children: [
                Text("Seats"),
                Text(":"),
                Text(vehicleSeats)
              ]
            ),
            TableRow(
              children: [
                Text("Plate Number"),
                Text(":"),
                Text(vehiclePlate)
              ]
            ),
            TableRow(
              children: [
                Text("Renter Name"),
                Text(":"),
                Text(adminName)
              ]
            ),
            TableRow(
              children: [
                Text("Phone Number"),
                Text(":"),
                Text(adminPhone)
              ]
            ),
            TableRow(
              children: [
                Text("Pick-up Date"),
                Text(":"),
                Text(pickUpDate)
              ]
            ),
            TableRow(
              children: [
                Text("Pick-up Time"),
                Text(":"),
                Text(pickUpTime)
              ]
            ),
            TableRow(
              children: [
                Text("Duration"),
                Text(":"),
                Text("${orderDuration} Days")
              ]
            ),
            TableRow(
              children: [
                Text("Drop-off Time"),
                Text(":"),
                Text(dropOff)
              ]
            ),
          ],
        )
      ],
    );
  }
}












// class RequestDetailVehicle extends StatelessWidget {
//   const RequestDetailVehicle({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           child: Row(
//           children: [
//             Flexible(
//               flex: 2,
//               child: Image(image: AssetImage("images/carsItem.png"),)
//             ),
//             SizedBox(width: 10,),
//             Flexible(
//               flex: 3,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Honda Brio"),
//                         Text("@squarepants", style: TextStyle(fontSize: 14),),
//                       ],
//                     ),
//                   ),
//                   Text("Total harganya", style: TextStyle(color: Colors.red),)
//                 ],
//               )
//             )
//           ],
//         ),
//         ),
//         Table(
//           columnWidths: {
//             0: IntrinsicColumnWidth(),
//             1: FlexColumnWidth(0.3),
//             2: FlexColumnWidth(4),
//           },
//           children: [
//             TableRow(
//               children: [
//                 Text("Renter Name"),
//                 Text(":"),
//                 Text("Squarepants")
//               ]
//             ),
//             TableRow(
//               children: [
//                 Text("Phone Number"),
//                 Text(":"),
//                 Text("0837423487328")
//               ]
//             ),
//             TableRow(
//               children: [
//                 Text("Pick-up Date"),
//                 Text(":"),
//                 Text("09 May 2023")
//               ]
//             ),
//             TableRow(
//               children: [
//                 Text("Pick-up Time"),
//                 Text(":"),
//                 Text("11.00 WIB")
//               ]
//             ),
//             TableRow(
//               children: [
//                 Text("Duration"),
//                 Text(":"),
//                 Text("3 Days")
//               ]
//             ),
//             TableRow(
//               children: [
//                 Text("Drop-off Time"),
//                 Text(":"),
//                 Text("12 May 2023")
//               ]
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }


// class RequestDetailPickUpLocation extends StatefulWidget {
//   const RequestDetailPickUpLocation({super.key});

//   @override
//   State<RequestDetailPickUpLocation> createState() => _RequestDetailPickUpLocationState();
// }

// class _RequestDetailPickUpLocationState extends State<RequestDetailPickUpLocation> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text("Pick-up Location"),
//         Text("Koordinat Pengirimannya"),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.red
//           ),
//           child: Text("Ini akan jadi peta"),
//         )
//       ],
//     );
//   }
// }


// class RequestDetailIdCard extends StatelessWidget {
//   const RequestDetailIdCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text("ID Card"),
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(5),
//           decoration: BoxDecoration(
//             color: Colors.amber
//           ),
//           child: Image(image: AssetImage("images/carsItem.png")),
//         )
//       ],
//     );
//   }
// }