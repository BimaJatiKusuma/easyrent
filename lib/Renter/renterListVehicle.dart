import 'package:easyrent/Renter/renterFormRent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RenterListVehicle extends StatefulWidget {
  const RenterListVehicle({super.key});

  @override
  State<RenterListVehicle> createState() => _RenterListVehicleState();
}

class _RenterListVehicleState extends State<RenterListVehicle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Cars"),
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            // color: Colors.red,
            height: 50,
            margin: EdgeInsets.only(bottom: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SortByListVehicle(child: Icon(Icons.tune_rounded),),
                SortByListVehicle(child: Text("Jember")),
                SortByListVehicle(child: Text("Malang")),
                SortByListVehicle(child: Text("Surabaya")),
              ],
            ),
          ),
          
          // SizedBox(height: 10,),

          Expanded(
            child: ListView(
              children: [
                ListVehicleDataView(),
                ListVehicleDataView(),
                ListVehicleDataView(),
                ListVehicleDataView(),
                ListVehicleDataView(),
                ListVehicleDataView(),
                ListVehicleDataView(),
                ListVehicleDataView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




class SortByListVehicle extends StatelessWidget {
  final Widget child;
  const SortByListVehicle({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: ElevatedButton(onPressed: (){}, child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromRGBO(239, 229, 237, 1),
          foregroundColor: Colors.black
        ),
        ));
  }
}







class ListVehicleDataView extends StatelessWidget {
  const ListVehicleDataView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      Text("@rentbali.jaya (Denpasar)", style: TextStyle(fontSize: 14),),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rp 400.000/day", style: TextStyle(fontSize: 14, color: Color.fromRGBO(189, 85, 37, 1)),),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return RenterFormRent();
                        }));
                      },
                      child: Text("Rent"))
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}