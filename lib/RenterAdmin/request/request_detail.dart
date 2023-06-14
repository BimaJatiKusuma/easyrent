import 'package:easyrent/Componen/custombox1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RequestDetail extends StatelessWidget {
  const RequestDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Order Details"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: ListView(
        children: [
          ContainerCustomShadow(containerChild: RequestDetailVehicle()),
          ContainerCustomShadow(containerChild: RequestDetailPickUpLocation()),
          ContainerCustomShadow(containerChild: RequestDetailIdCard()),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: ElevatedButton(
              onPressed: (){},
              child: Text("Send")),
          )
        ],
      ),
    );
  }
}


class RequestDetailVehicle extends StatelessWidget {
  const RequestDetailVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Image(image: AssetImage("images/carsItem.png"),)
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
                        Text("Honda Brio"),
                        Text("@squarepants", style: TextStyle(fontSize: 14),),
                      ],
                    ),
                  ),
                  Text("Total harganya", style: TextStyle(color: Colors.red),)
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
                Text("Squarepants")
              ]
            ),
            TableRow(
              children: [
                Text("Phone Number"),
                Text(":"),
                Text("0837423487328")
              ]
            ),
            TableRow(
              children: [
                Text("Pick-up Date"),
                Text(":"),
                Text("09 May 2023")
              ]
            ),
            TableRow(
              children: [
                Text("Pick-up Time"),
                Text(":"),
                Text("11.00 WIB")
              ]
            ),
            TableRow(
              children: [
                Text("Duration"),
                Text(":"),
                Text("3 Days")
              ]
            ),
            TableRow(
              children: [
                Text("Drop-off Time"),
                Text(":"),
                Text("12 May 2023")
              ]
            ),
          ],
        )
      ],
    );
  }
}


class RequestDetailPickUpLocation extends StatefulWidget {
  const RequestDetailPickUpLocation({super.key});

  @override
  State<RequestDetailPickUpLocation> createState() => _RequestDetailPickUpLocationState();
}

class _RequestDetailPickUpLocationState extends State<RequestDetailPickUpLocation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Pick-up Location"),
        Text("Koordinat Pengirimannya"),
        Container(
          decoration: BoxDecoration(
            color: Colors.red
          ),
          child: Text("Ini akan jadi peta"),
        )
      ],
    );
  }
}


class RequestDetailIdCard extends StatelessWidget {
  const RequestDetailIdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("ID Card"),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.amber
          ),
          child: Image(image: AssetImage("images/carsItem.png")),
        )
      ],
    );
  }
}