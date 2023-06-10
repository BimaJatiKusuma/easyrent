import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easyrent/RenterAdmin/adminLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../Componen/form.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String alertTextRegis = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Text(
                      "Rent Admin",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    )),
                FormGroup(
                  stringNamaLabel: "Email",
                  controllerNama: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10,),
                FormGroup(
                  stringNamaLabel: "Username",
                  controllerNama: usernameController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 10,),
                FormGroup(
                  stringNamaLabel: "Address",
                  controllerNama: addressController,
                  keyboardType: TextInputType.streetAddress,
                ),
                SizedBox(height: 10,),
                FormGroup(
                  stringNamaLabel: "Phone Number",
                  controllerNama: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10,),
                FormGroup(
                  stringNamaLabel: "Password",
                  controllerNama: passwordController,
                  enableObscure: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 10,),
                FormGroup(
                  stringNamaLabel: "Konfirmasi Password",
                  controllerNama: passwordConfirmController,
                  enableObscure: true,
                  keyboardType: TextInputType.visiblePassword,
                  confirmPassword: passwordController,
                ),
                SizedBox(height: 10,),
                Container(
                  // color: Colors.yellow,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate() == true){
                            signUp(usernameController.text, emailController.text, passwordController.text, addressController.text, phoneController.text);
                          }
                          // _formkey.currentState!.validate();
                          // print(_formkey.currentState!.validate());
                        },
                        child: Text("Sign Up"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: Size(250, 50),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Do you have an account? "),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String username, String email, String password, String address, String phone_number) async {
    CircularProgressIndicator();
    if(_formkey.currentState!.validate()){
      try{
        //fix this
      await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore(username, email, address, phone_number)});
        // .catchError((e){});
      }
      on FirebaseAuthException catch (e){
        if(e.code == 'email-already-in-use'){
            setState(() {
              alertTextRegis ='email sudah digunakan';
            });
            
          }
      }
    }
  }

  postDetailsToFirestore(String username, String email, String address, String phone_number) async {
    CircularProgressIndicator();
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users_admin');
    ref.doc(user!.uid).set({'username':username, 'email':email, 'address':address, 'phone_number':phone_number, "deleted_at":"", "photo_profile":""});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return AdminLogin();
    }));
  }


}





