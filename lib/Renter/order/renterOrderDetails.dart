import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class RenterOrderDetails extends StatefulWidget {
  RenterOrderDetails({
    required this.duration,
    required this.dropOffDate,
    super.key
    });
  final int duration;
  final String dropOffDate;
  @override
  State<RenterOrderDetails> createState() => _RenterOrderDetailsState();
}

class _RenterOrderDetailsState extends State<RenterOrderDetails> {
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
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(target: LatLng(-6.1758228, 106.8222985));
    print(widget.duration);
    print(widget.dropOffDate);
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
          ContainerCustomShadow(containerChild: RenterOrderDetailsDescription(), height: 225,),
          // Text("${lat}, ${long}"),
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


          ContainerCustomShadow(containerChild: RenterOrderDetailsButton(labelButton: "Add ID card (E-KTP / Password)", namaButton: "Set your pick-up location please", onPressed: (){addIDCard();},)),
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
  print(position);
    print("Ini method PickUp");
  }

  addIDCard(){
    print("Ini method Add Card");
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


class RenterOrderDetailsDescription extends StatelessWidget {
  const RenterOrderDetailsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 100,
                child: Image(image: AssetImage("images/carsItem.png"))
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Honda Brio"),
                    Text("@rentbali.jaya (Denpasar)", style: TextStyle(fontSize: 14),),
                    Text("Rp. 400.000/day", style: TextStyle(fontSize: 14, color: Color.fromRGBO(189, 85, 37, 1)),)
                  ],
                ),
              )
              
            ],
          ),
        )
      ],
    );
  }
}