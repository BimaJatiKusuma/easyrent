import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/Componen/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class ProductCarAdd extends StatefulWidget {
  ProductCarAdd({
    required this.category,
    super.key
    });
  final int category;
  @override
  State<ProductCarAdd> createState() => _ProductCarAddState();
}

class _ProductCarAddState extends State<ProductCarAdd> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalSeatController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var vehicleDB = FirebaseFirestore.instance.collection('vehicle');

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
      body: ListView(
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
                    Icon(Icons.image, size: 50,),
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
                          await uploadImage();
                          await vehicleDB.add({
                            "color":colorController.text,
                            "id_admin":FirebaseAuth.instance.currentUser!.uid,
                            "id_category":widget.category,
                            "plate_number":plateNumberController.text,
                            "price":int.parse(priceController.text),
                            "seat":int.parse(totalSeatController.text),
                            "url_photo":imageUrl,
                            "vehicle_name":productNameController.text,
                            "deleted_at":"",
                            "available":100
                          });
                          setState(() {
                            statusLoading = false;
                          });
                          Navigator.pop(context);
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






