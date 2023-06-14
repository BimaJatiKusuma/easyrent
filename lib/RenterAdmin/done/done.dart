import 'package:easyrent/RenterAdmin/request/request_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Done extends StatefulWidget {
  const Done({super.key});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Request"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: ListView(
        children: [
          DoneItem(),
          DoneItem(),
          DoneItem(),
        ],
      ),
    );
  }
}

class DoneItem extends StatelessWidget {
  const DoneItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4
            )
          ]
        ),
        width: double.infinity,
        height: 120,
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
                        Text("tanggal selesai", style: TextStyle(fontSize: 14, color: Color.fromRGBO(164, 118, 0, 1)),),
                      ],
                    ),
                  ),
                  Text("Done")
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}