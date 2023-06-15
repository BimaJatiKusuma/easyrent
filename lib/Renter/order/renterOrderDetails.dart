import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';




class RenterOrderDetails extends StatefulWidget {
  RenterOrderDetails({
    required this.vehicleUID,
    required this.adminUID,
    required this.duration,
    required this.dropOffDate,
    required this.pickUpDate,
    super.key
    });
  final String vehicleUID;
  final String adminUID;
  final int duration;
  final String dropOffDate;
  final String pickUpDate;
  @override
  State<RenterOrderDetails> createState() => _RenterOrderDetailsState();
}

class _RenterOrderDetailsState extends State<RenterOrderDetails> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataVehicle = FirebaseFirestore.instance.collection('vehicle').doc(widget.vehicleUID).get();
  late Map dataVehicle;


  @override
  Widget build(BuildContext context) {
    print("hello2");
    print(widget.adminUID);
    return Scaffold(
      body: FutureBuilder(
        future: _futureDataVehicle,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text(snapshot.hasError.toString()),);
          }
          if(snapshot.hasData){
            dataVehicle = snapshot.data!.data() as Map;
            late Future<DocumentSnapshot<Map<String, dynamic>>> _futureDataAdmin = FirebaseFirestore.instance.collection('users_admin').doc(widget.adminUID).get();
            late Map dataAdmin;
            return FutureBuilder(
              future: _futureDataAdmin,
              builder: (context, snapshot2) {
                if(snapshot2.hasError){
                  return Center(child: Text(snapshot2.hasError.toString()),);
                }
                if(snapshot2.hasData){
                  dataAdmin = snapshot2.data!.data() as Map;
                  print("ini di get admin");
                  print(dataAdmin['username']);
                  return RenterOrderDetails2(vehiclePhotoURL: dataVehicle['url_photo'], vehicleName: dataVehicle['vehicle_name'], vehiclePrice: dataVehicle['price'], adminName: dataAdmin['username'], adminPhone: dataAdmin['phone_number'], orderDuration: widget.duration, orderPickUp: widget.pickUpDate, orderDropOff: widget.dropOffDate);
                }
                return CircularProgressIndicator();
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}















class RenterOrderDetails2 extends StatefulWidget {
  RenterOrderDetails2({
    required this.vehiclePhotoURL,
    required this.vehicleName,
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
    final int vehiclePrice;
    final String adminName;
    final String adminPhone;
    final String orderPickUp;
    final String orderDropOff;
    final int orderDuration;
  @override
  State<RenterOrderDetails2> createState() => _RenterOrderDetails2State();
}

class _RenterOrderDetails2State extends State<RenterOrderDetails2> {
Future<Position> lokasiSekarang() async{
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled){
    return Future.error('Location services are disabled');
  }

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

String lat='';
String long='';
Set<Marker> markers = {};
late GoogleMapController googleMapController;



  File? produkFoto;
  String fotoProduk1 = '';
  String imageUrl = '';
  String alertImage = "";

  Future getImage() async {
    final ImagePicker foto = ImagePicker();
    final XFile? fotoProduk = await foto.pickImage(source: ImageSource.gallery);
    if (fotoProduk == null) return;
    
    fotoProduk1 = fotoProduk.path;
    produkFoto = File(fotoProduk.path);


    setState(() {});
  }

    Future getImage2() async {
    final ImagePicker foto = ImagePicker();
    final XFile? fotoProduk = await foto.pickImage(source: ImageSource.camera);
    if (fotoProduk == null) return;

    fotoProduk1 = fotoProduk.path;
    produkFoto = File(fotoProduk.path);



    setState(() {});
  }

  Future uploadImage() async {
    String uniqeFileName = DateTime.now().millisecondsSinceEpoch.toString();
    //Reference ke storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirFotoProduk = referenceRoot.child('vehicle_photo');

    //Membuat reference untuk foto yang akan diupload
    Reference referenceFotoProdukUpload =
        referenceDirFotoProduk.child(uniqeFileName);

    try {
      //menyimpan file
      await referenceFotoProdukUpload.putFile(File(fotoProduk1));
      //success
      imageUrl = await referenceFotoProdukUpload.getDownloadURL();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(target: LatLng(-6.1758228, 106.8222985));
    print(widget.orderDuration);
    print(widget.orderDropOff);
    print(widget.orderPickUp);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Order Details"),
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: ListView(
        children: [
          ContainerCustomShadow(containerChild: RenterDetailVehicle(vehiclePhotoURL: widget.vehiclePhotoURL, vehicleName: widget.vehicleName, vehiclePrice: widget.vehiclePrice, adminName: widget.adminName, adminPhone: widget.adminPhone, orderDuration: widget.orderDuration, orderPickUp: widget.orderPickUp, orderDropOff: widget.orderDropOff)),
          
          ContainerCustomShadow(containerChild: RenterOrderDetailsButton(labelButton: "Pick-up Location", namaButton: lat =="" ? "Set your pick-up location please" : "${lat}, ${long}", onPressed: () async {
            await lokasiSekarang().then((value){
              lat = '${value.latitude}';
              long = '${value.longitude}';
              print(lat);
              print(long);
              setState(() {});
            });
            googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(double.parse(lat), double.parse(long)), zoom: 16)));
            markers.clear();
            markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(double.parse(lat), double.parse(long))));
            setState(() {});
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
              },
            ),
          ),


          ContainerCustomShadow(
            containerChild: RenterOrderDetailsButton(
              labelButton: "Add ID card (E-KTP / Password)",
              namaButton: "Set your pick-up location please",
              onPressed: (){addIDCard();},)),
          Container(
            height: 200,
            width: 250,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            child: produkFoto != null ?
              Image.file(produkFoto!, fit: BoxFit.cover,) :
              Icon(Icons.image, size: 50,),
          ),

          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
            child: ElevatedButton(onPressed: (){
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: Text("Check out")),
          )
        ],
      ),
    );
  }

  pickUPLocation() async{
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // print(position);
  //   print("Ini method PickUp");
  }

  addIDCard(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pilih Gambar"),
          actions: [
            ElevatedButton(onPressed: (){getImage(); Navigator.pop(context);}, child: Text("Galeri")),
            ElevatedButton(onPressed: (){getImage2(); Navigator.pop(context);}, child: Text("Kamera")),
          ],
        );
      },
      );
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
    final int vehiclePrice;
    final String adminName;
    final String adminPhone;
    final String orderPickUp;
    final String orderDropOff;
    final int orderDuration;
  @override
  Widget build(BuildContext context) {
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
                        Text(vehicleName),
                        Text(adminName, style: TextStyle(fontSize: 14),),
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
                Text(orderPickUp)
              ]
            ),
            TableRow(
              children: [
                Text("Pick-up Time"),
                Text(":"),
                Text(orderPickUp)
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
                Text(orderDropOff)
              ]
            ),
          ],
        )
      ],
    );
  }
}