import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/Componen/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class ProductCarEdit extends StatefulWidget {
  ProductCarEdit({
    required this.vehicleUID,
    super.key
    }) : super(){
      _referenceVehicle = FirebaseFirestore.instance.collection('vehicle').doc(vehicleUID);
      _futureData = _referenceVehicle.get();
    }
  final String vehicleUID;
  late DocumentReference _referenceVehicle;
  late Future _futureData;
  late Map dataVehicle;
  @override
  State<ProductCarEdit> createState() => _ProductCarEditState();
}

class _ProductCarEditState extends State<ProductCarEdit> {
  late TextEditingController productNameController = TextEditingController(text: widget.dataVehicle['vehicle_name'].toString());
  late TextEditingController priceController = TextEditingController(text: widget.dataVehicle['price'].toString());
  late TextEditingController totalSeatController = TextEditingController(text: widget.dataVehicle['seat'].toString());
  late TextEditingController colorController = TextEditingController(text: widget.dataVehicle['color'].toString());
  late TextEditingController plateNumberController = TextEditingController(text: widget.dataVehicle['plate_number'].toString());
  final _formkey = GlobalKey<FormState>();

  File? produkFoto;
  String fotoProduk1 = '';
  late String imageUrl = widget.dataVehicle['url_photo'];
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

  Future updateImage() async {
    String uniqeFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceFotoProdukUpdate =
        FirebaseStorage.instance.refFromURL(imageUrl);

    try {
      //menyimpan file
      await referenceFotoProdukUpdate.putFile(File(fotoProduk1));
      //success
      imageUrl = await referenceFotoProdukUpdate.getDownloadURL();
    } catch (error) {
      print(error);
    }
  }
  bool statusLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Add"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: FutureBuilder(
        future: widget._futureData,
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Center(child: Text(snapshot.hasError.toString()),);
          }
          if (snapshot.hasData){
            DocumentSnapshot _documentSnapshot = snapshot.data;
            widget.dataVehicle = _documentSnapshot.data() as Map;

            return ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        height: 150,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: produkFoto != null ?
                          Image.file(produkFoto!, fit: BoxFit.cover,) :
                          Image.network(imageUrl)
                      ),
                      Text(alertImage),
                      ElevatedButton(onPressed: (){
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
                      }, child: Text("Add Photo")),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            formAddEditProduct(label: "Product Name", controllerNama: productNameController, keyboardType: TextInputType.text,),
                            SizedBox(height: 10,),
                            formAddEditProduct(label: "Price", controllerNama: priceController, keyboardType: TextInputType.numberWithOptions(),),
                            SizedBox(height: 10,),
                            formAddEditProduct(label: "Total Seat", controllerNama: totalSeatController, keyboardType: TextInputType.numberWithOptions(),),
                            SizedBox(height: 10,),
                            formAddEditProduct(label: "Color", controllerNama: colorController, keyboardType: TextInputType.text,),
                            SizedBox(height: 10,),
                            formAddEditProduct(label: "Plate Number", controllerNama: plateNumberController, keyboardType: TextInputType.text,),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                        
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            if(_formkey.currentState!.validate()==true){
                              if(produkFoto != null){
                                setState(() {
                                  statusLoading = true;
                                });
                                _showLoading();
                                await updateImage();
                                await widget._referenceVehicle.update({
                                  "color":colorController.text,
                                  "id_admin":FirebaseAuth.instance.currentUser!.uid,
                                  "plate_number":plateNumberController.text,
                                  "price":int.parse(priceController.text),
                                  "seat":int.parse(totalSeatController.text),
                                  "url_photo":imageUrl,
                                  "vehicle_name":productNameController.text,
                                });
                                setState(() {
                                  statusLoading = false;
                                });
                                Navigator.pop(context);
                              }
                            }
                            else {
                              setState(() {
                                alertImage = "foto harus diisi";
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            
                          ),
                          child: Text("Save")),
                      )
                        
                    ],
                  ),
                ),
              ],
            );
            
          }
          return Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
  
  _showLoading(){
    if(statusLoading == true){
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("loading...", textAlign: TextAlign.center,),
          );
        },
      );
    }
  }
}






