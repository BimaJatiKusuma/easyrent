import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutInformation extends StatelessWidget {
  const AboutInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("ABOUT US"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              width: 200,
              height: 150,
              child: Image(image: AssetImage('images/start.png'))
            ),
            Container(
              child: Column(
                children: [
                  Text("Easyrent", style: TextStyle(fontWeight: FontWeight.w600),),
                  Text("version 1.0.0")
                ],
              ),
            ),
            SizedBox(height: 30,),
            _content(Text("Aplikasi mobile yang digunakan untuk membantu pemilik rental dalam memperluas skala penyewaan kendaraan yang dimiliki, serta membantu penyewa  dalam menyewa kendaraan.", textAlign: TextAlign.center,)),
            SizedBox(height: 20,),
            Text("Features for Renter", style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            _content(
             Column(children: [
              Text("Sewa Kendaraan"),
              Text("Lokasi Terkini"),
              Text("Data Riwayat Sewa"),
              Text("Edit Profile")
             ],) 
            ),
            SizedBox(height: 20,),
            Text("Features for Rent Admin", style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            _content(
             Column(children: [
              Text("Penyewaan kendaraan"),
              Text("Tambah data kendaraan"),
              Text("Data riwayat sewa"),
              Text("Edit Profile")
             ],) 
            ),
            SizedBox(height: 20,),
            Text("Contact info", style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            _content(
              Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(8),
                },
                children: [
                  TableRow(
                    children: [
                      Icon(Icons.phone),
                      Text("+62 858-9592-9918"),
                    ]
                  ),
                  TableRow(
                    children: [
                      Icon(Icons.email_outlined),
                      Text("bimajatislebew@gmail.com"),
                    ]
                  ),
                  TableRow(
                    children: [
                      Icon(FontAwesomeIcons.twitter),
                      Text("@bimajati"),
                    ]
                  ),
                ],
              )
            ),
            SizedBox(height: 30,),
            Container(
              child: Text("Created by Kelompok 15", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center,))
          ],
        )
        ),
    );
  }
  _content(child){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(234, 234, 248, 1),
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: child,
    );
  }
}