import 'package:easyrent/Renter/renterOrderDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class RenterFormRent extends StatefulWidget {
  const RenterFormRent({super.key});

  @override
  State<RenterFormRent> createState() => _RenterFormRentState();
}

class _RenterFormRentState extends State<RenterFormRent> {
  DateTime dateTime = DateTime.now();
    Future<DateTime?> pickDate(){
    return showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2222));
  }

  Future<TimeOfDay?> pickTime(){
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
  }

  pickDateButtonLogic() async {
    final date = await pickDate();
    if (date == null) return;
    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      dateTime.hour,
      dateTime.minute,
    );
    setState(() {
      dateTime = newDateTime;
    });
  }

  pickTimeButtonLogic() async {
    final time = await pickTime();
    if (time == null) return;
    final newDateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      time.hour,
      time.minute,
    );
    setState(() {
      dateTime = newDateTime;
    });
  }

  int durationDate = 1;



  @override
  Widget build(BuildContext context) {
    DateTime dropOffDate = DateTime(dateTime.year, dateTime.month, dateTime.day + durationDate, dateTime.hour, dateTime.minute);
    final hours = dateTime.hour.toString().padLeft(2, '0');
    // final hours = dateTime.hour.toString();
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    // final minutes = dateTime.hour.toString();
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.keyboard_double_arrow_left)),
        title: Text("Car Rent"),
        backgroundColor: Color.fromRGBO(12, 10, 49, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      ButtonFormRentDate(),
                      ButtonFormRentTime(hours, minutes),
                      ButtonFormRentDuration(),
                      ButtonFormRentDropOff(dropOffDate),
                    ],
                  ),
                ),
                
            
              ],
            ),
          ),


          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
            child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return RenterOrderDetails();
                }));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(74, 73, 148, 1),
                minimumSize: Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: Text("Submit")),
          )
        ],
      ),
    );
  }


  ButtonFormRentDate() {
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pick-up date"),
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
                  onPressed: (){
                    pickDateButtonLogic();
                  },
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${DateFormat('dd MMMM yyyy').format(dateTime)}"),
                  ],
                ),),
              ],
            ),
          );
  }


  ButtonFormRentTime(hours, minutes) {
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pick-up time"),
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
                  onPressed: (){
                    pickTimeButtonLogic();
                  },
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$hours.$minutes'),
                  ],
                ),),
              ],
            ),
          );
  }

  ButtonFormRentDuration() {
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Duration"),
                Container(
                  height: 40,
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${durationDate} Days"),
                      Container(
                        child: Row(
                          children: [
                            IconButton(onPressed: (){
                              if(durationDate != 1){
                                setState(() {
                                  durationDate -=1;
                                });
                              }
                              print(durationDate);
                            }, icon: Icon(Icons.remove)),
                            IconButton(onPressed: (){
                              setState(() {
                                durationDate +=1;
                              });
                              print(durationDate);
                            }, icon: Icon(Icons.add))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

  ButtonFormRentDropOff(dropOffDate) {
    return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Drop-off"),
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
                  onPressed: (){

                  },
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${DateFormat("dd MMMM yyyy, HH:mm").format(dropOffDate)}"),
                  ],
                ),),
              ],
            ),
          );
  }



}















          // ElevatedButton(onPressed: (){
          //   pickDateAndTime();
          // }, child: Text("Date And Time"))





  // Future pickDateAndTime() async {
  //   DateTime? date = await pickDate();
  //   if (date == null) return;

  //   TimeOfDay? time = await pickTime();
  //   if (time == null) return;

  //   final dateTimeFull = DateTime(
  //     date.year,
  //     date.month,
  //     date.day,
  //     time.hour,
  //     time.minute
  //   );
  //   setState(() {
  //     this.dateTime = dateTimeFull;
  //   });
  // }