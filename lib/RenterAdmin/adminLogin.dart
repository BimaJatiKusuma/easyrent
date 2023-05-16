import 'package:easyrent/RenterAdmin/adminRegis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Componen/form.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 229, 237, 1),
      body: ListView(
        children: [
          Image(
            image: AssetImage('images/start.png'),
            // width: 311,
            height: 200,
          ),
          Container(
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35)),
              color: Color.fromRGBO(255, 255, 255, 1),
              ),
            child: Column(
              children: [
                Container(
                  // color: Colors.yellow,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 32),
                      ),
                      Text("Sign in to continue"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formkey,
                  child: Container(
                  // color: Colors.green,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      FormGroup(
                        stringNamaLabel: "Email",
                        controllerNama: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validasi: "^[1-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
                        validasiRespon: "Masukkan Email secara benar",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormGroup(
                        stringNamaLabel: "Password",
                        controllerNama: passwordController,
                        enableObscure: true,
                        keyboardType: TextInputType.visiblePassword,
                        validasi: r'^.{6,}$',
                        validasiRespon: "Password minimal 6 karakter",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // color: Colors.yellow,
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _formkey.currentState!.validate();
                                print(emailController.text);
                                print(passwordController.text);
                              },
                              child: Text("Login"),
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
                                Text("Don't have an account? "),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return AdminRegister();
                                      }));
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}



