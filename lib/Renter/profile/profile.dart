import 'package:easyrent/Componen/form.dart';
import 'package:easyrent/Renter/renterHompage.dart';
import 'package:easyrent/welcomingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class RenterProfilProfil extends StatefulWidget {
  RenterProfilProfil({super.key}){
  futureData = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  }
  late var futureData;
  late Map dataUsers;

  @override
  State<RenterProfilProfil> createState() => _RenterProfilProfilState();
}

class _RenterProfilProfilState extends State<RenterProfilProfil> {
  late TextEditingController usernameController = TextEditingController(text: widget.dataUsers['username']);
  late TextEditingController emailController = TextEditingController(text: widget.dataUsers['email']);
  late TextEditingController phoneController = TextEditingController(text: widget.dataUsers['phone_number']);
  late TextEditingController addressController = TextEditingController(text: widget.dataUsers['address']);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.futureData,
      builder: (context, AsyncSnapshot snapshot) {
        if(snapshot.hasError){
          return Text('${snapshot.hasError}');
        }
        if(snapshot.hasData){
          widget.dataUsers = snapshot.data!.data() as Map;
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: widget.dataUsers['photo_profile'] != "" ? Image.network(widget.dataUsers['photo_profile']).image :AssetImage("images/admin_rent.png"),
                      
                    ),
                    SizedBox(height: 10,),
                    FormGroup(stringNamaLabel: "Username", controllerNama: usernameController, keyboardType: TextInputType.text, hanyaBaca: true,),
                    SizedBox(height: 10,),
                    FormGroup(stringNamaLabel: "Email", controllerNama: emailController, keyboardType: TextInputType.emailAddress, hanyaBaca: true,),
                    SizedBox(height: 10,),
                    FormGroup(stringNamaLabel: "No Telp", controllerNama: phoneController, keyboardType: TextInputType.phone, hanyaBaca: true,),
                    SizedBox(height: 10,),
                    FormGroup(stringNamaLabel: "Address", controllerNama: addressController, keyboardType: TextInputType.text, hanyaBaca: true,),
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return RenterProfilEdit();
                      }));
                    }, child: Text("Edit Profile"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        minimumSize: Size(double.infinity, 50)
                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(onPressed: () async {
                      try{
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                          return WelcomingPage();
                        }), (route) => false);
                      }
                      catch (e){
                        print(e);
                      }
                    }, child: Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        minimumSize: Size(double.infinity, 50)
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }
        else return CircularProgressIndicator();
      }
    );
  }
}





class RenterProfilEdit extends StatefulWidget {
  RenterProfilEdit({super.key}){
    futureData = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
  }

  late var futureData;
  late Map dataUsers;
  @override
  State<RenterProfilEdit> createState() => _RenterProfilEditState();
}

class _RenterProfilEditState extends State<RenterProfilEdit> {
  late TextEditingController usernameController = TextEditingController(text: widget.dataUsers['username']);
  late TextEditingController emailController = TextEditingController(text: widget.dataUsers['email']);
  late TextEditingController phoneController = TextEditingController(text: widget.dataUsers['phone_number']);
  late TextEditingController addressController = TextEditingController(text: widget.dataUsers['address']);

  File? produkFoto;
  String fotoProduk1 = '';
  late String imageUrl = widget.dataUsers['photo_profil'];

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Edit Profile"),
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: FutureBuilder<Object>(
        future: widget.futureData,
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasError){
            return Text("${snapshot.hasError}");
          }
          if(snapshot.hasData){
            widget.dataUsers = snapshot.data!.data() as Map; 
            return Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: ListView(
              children: [
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: widget.dataUsers['photo_profile'] != "" ? Image.network(widget.dataUsers['photo_profile']).image : (produkFoto != null ? Image.file(produkFoto!).image :AssetImage("images/admin_rent.png"))
                      ),
                      Positioned(
                        child: IconButton(onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Pilih Gambar"),
                                actions: [
                                  ElevatedButton(onPressed: ()async {await getImage(); Navigator.pop(context);}, child: Text("Galeri")),
                                  ElevatedButton(onPressed: ()async {await getImage2(); Navigator.pop(context);}, child: Text("Kamera")),
                                ],
                              );
                            },
                            );
                        },
                          icon: Icon(Icons.edit_outlined)),
                        right: -10,
                        bottom: -10,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                FormGroup(stringNamaLabel: "Username", controllerNama: usernameController, keyboardType: TextInputType.text),
                SizedBox(height: 10,),
                FormGroup(stringNamaLabel: "Email", controllerNama: emailController, keyboardType: TextInputType.emailAddress, hanyaBaca: true,),
                SizedBox(height: 10,),
                FormGroup(stringNamaLabel: "No Telp", controllerNama: phoneController, keyboardType: TextInputType.phone),
                SizedBox(height: 10,),
                FormGroup(stringNamaLabel: "Address", controllerNama: addressController, keyboardType: TextInputType.text),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: () async{
                  await updateImage();
                  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
                    'username':usernameController.text,
                    'address':addressController.text,
                    'phone_number':phoneController.text,
                    "photo_profile":imageUrl,
                  });

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return RenterHomePage(selectedIndex: 2,);
                  }));
                }, child: Text("Save Change"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    minimumSize: Size(double.infinity, 50)
                  ),
                )
              ],
            ));
          }
          else return CircularProgressIndicator();
        }
      ),
    );
  }
}