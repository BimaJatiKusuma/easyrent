import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RenterOrderDetails extends StatefulWidget {
  const RenterOrderDetails({super.key});

  @override
  State<RenterOrderDetails> createState() => _RenterOrderDetailsState();
}

class _RenterOrderDetailsState extends State<RenterOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Order Details"),
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: Column(
        children: [
          ContainerCustomShadow(containerChild: RenterOrderDetailsDescription(), height: 225,),
          ContainerCustomShadow(containerChild: RenterOrderDetailsButton(labelButton: "Pick-up Location", namaButton: "Set your pick-up location please", onPressed: (){pickUPLocation();},)),
          ContainerCustomShadow(containerChild: RenterOrderDetailsButton(labelButton: "Add ID card (E-KTP / Password)", namaButton: "Set your pick-up location please", onPressed: (){addIDCard();},)),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
            child: ElevatedButton(onPressed: (){
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: Text("Check out")),
          )
        ],
      ),
    );
  }

  pickUPLocation(){
    print("Ini method PickUp");
  }

  addIDCard(){
    print("Ini method Add Card");
  }
}


class ContainerCustomShadow extends StatefulWidget {
  Widget containerChild;
  double? height;
  ContainerCustomShadow({
    required this.containerChild,
    this.height,
    super.key,
  });

  @override
  State<ContainerCustomShadow> createState() => _ContainerCustomShadowState();
}

class _ContainerCustomShadowState extends State<ContainerCustomShadow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4
          )
        ]
      ),
      child: widget.containerChild,
    );
  }
}



class RenterOrderDetailsButton extends StatelessWidget {
  final String labelButton;
  final String namaButton;
  final void Function() onPressed;
  const RenterOrderDetailsButton({
    required this.labelButton,
    required this.namaButton,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labelButton),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    minimumSize: Size.fromHeight(40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.black)
                    )
                  ),
                  onPressed: onPressed,
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(namaButton),
                    Icon(Icons.keyboard_double_arrow_right_rounded)
                  ],
                ),),
              ],
            ),
          );
  }
}


class RenterOrderDetailsDescription extends StatelessWidget {
  const RenterOrderDetailsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 100,
                child: Image(image: AssetImage("images/carsItem.png"))
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Honda Brio"),
                    Text("@rentbali.jaya (Denpasar)", style: TextStyle(fontSize: 14),),
                    Text("Rp. 400.000/day", style: TextStyle(fontSize: 14, color: Color.fromRGBO(189, 85, 37, 1)),)
                  ],
                ),
              )
              
            ],
          ),
        )
      ],
    );
  }
}