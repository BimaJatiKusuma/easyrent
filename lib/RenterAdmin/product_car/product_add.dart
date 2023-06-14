import 'package:easyrent/Componen/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductCarAdd extends StatefulWidget {
  const ProductCarAdd({super.key});

  @override
  State<ProductCarAdd> createState() => _ProductCarAddState();
}

class _ProductCarAddState extends State<ProductCarAdd> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalSeatController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Add"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  height: 150,
                  width: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Icon(Icons.image, size: 50,),
                ),
                ElevatedButton(onPressed: (){}, child: Text("Add Photo"))
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      formAddEditProduct(label: "Product Name", controllerNama: productNameController, keyboardType: TextInputType.text,),
                      SizedBox(height: 10,),
                      formAddEditProduct(label: "Price", controllerNama: priceController, keyboardType: TextInputType.numberWithOptions(),),
                      SizedBox(height: 10,),
                      formAddEditProduct(label: "Total Seat", controllerNama: totalSeatController, keyboardType: TextInputType.numberWithOptions(),),
                      SizedBox(height: 10,),
                      formAddEditProduct(label: "Color", controllerNama: colorController, keyboardType: TextInputType.text,),
                      SizedBox(height: 10,),
                      formAddEditProduct(label: "Plate Number", controllerNama: plateNumberController, keyboardType: TextInputType.text,),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
                  
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formkey.currentState!.validate()==true){
                        print("success");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      
                    ),
                    child: Text("Save")),
                )
                  
              ],
            ),
          ),
        ],
      ),
    );
  }
}






