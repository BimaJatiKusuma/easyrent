import 'package:flutter/material.dart';

import '../Componen/form.dart';

class RenterRegister extends StatefulWidget {
  const RenterRegister({super.key});

  @override
  State<RenterRegister> createState() => _RenterRegisterState();
}

class _RenterRegisterState extends State<RenterRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

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
                    padding: EdgeInsets.only(top: 10, bottom: 15),
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi!",
                          // textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                        ),
                        Text("Create an account!")
                      ],
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
                          _formkey.currentState!.validate();
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
}
