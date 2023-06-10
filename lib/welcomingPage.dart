import 'package:easyrent/Renter/renterLogin.dart';
import 'package:easyrent/RenterAdmin/adminLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WelcomingPage extends StatelessWidget {
  const WelcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text('Easyrent', style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 16, fontWeight: FontWeight.w500),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 200,
              child: Image(image: AssetImage('images/start.png'))),
            Container(
              child: Column(
                children: [
                  Text("Hello !",style: TextStyle(fontFamily: 'PoppinsMedium', fontSize: 24),),
                  Text("Simply way to enjoy your trip")
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250,
              child: Column(
                children: [
                  Text("Set your role"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return RenterLogin();
                      }));
                    },
                    child: Text("Renter"),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Color.fromRGBO(74, 73, 148, 1)),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return AdminLogin();
                      }));
                    },
                    child: Text("Rent Admin"),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: Color.fromRGBO(140, 51, 95, 1)),
                    ),
                  SizedBox(height: 20,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
