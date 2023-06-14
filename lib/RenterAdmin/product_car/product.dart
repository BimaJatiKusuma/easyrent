import 'package:easyrent/RenterAdmin/product_car/product_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductCar extends StatefulWidget {
  ProductCar({
    required this.category,
    super.key
    });
  final String category;
  @override
  State<ProductCar> createState() => _ProductCarState();
}

class _ProductCarState extends State<ProductCar> {
  late var category = widget.category.toUpperCase();
  @override
  Widget build(BuildContext context) {
    print(category);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text(category),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ProductCarAdd();
            }));
          }, icon: Icon(Icons.add))
        ],
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: ListView(
              children: [
                ProductCarItem()
              ],
            )
          )
        ],
      ),
    );
  }
}



class ProductCarItem extends StatelessWidget {
  const ProductCarItem({
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
                      Text("status", style: TextStyle(fontSize: 14, color: Color.fromRGBO(164, 118, 0, 1)),),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Color.fromRGBO(148, 23, 23, 1),)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return RenterFormRent();
                        // }));
                      },
                      child: Text("Edit"))
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