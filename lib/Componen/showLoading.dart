  import 'package:flutter/material.dart';

showLoading(statusLoading, context){
    if(statusLoading == true){
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text("loading...", textAlign: TextAlign.center,),
          );
        },
      );
    }
  }