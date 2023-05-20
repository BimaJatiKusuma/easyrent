import 'package:flutter/material.dart';

class FormGroup extends StatefulWidget {
  final String stringNamaLabel;
  final TextInputType keyboardType;
  final TextEditingController controllerNama;
  final String? validasi;
  final String? validasiRespon;
  final TextEditingController? confirmPassword;
  final bool? hanyaBaca;
  
  bool enableObscure;
  FormGroup({
    Key? key,
    required this.stringNamaLabel,
    required this.controllerNama,
    required this.keyboardType,
    this.enableObscure = false,
    this.hanyaBaca = false,
    this.validasi,
    this.validasiRespon,
    this.confirmPassword,
  }) : super(key: key);

  @override
  State<FormGroup> createState() => _FormGroupState();
}

class _FormGroupState extends State<FormGroup> {
  obscureOrNot(){
    return IconButton(
      icon: Icon(obscureText ? Icons.visibility:Icons.visibility_off),
      onPressed: () {
        setState(() {
          obscureText = !obscureText;
        });
      },
    );
  }
  bool obscureText = false;
  
  val1(a){
    if(!RegExp(widget.validasi!).hasMatch(a)){
      return widget.validasiRespon;
    }
  }

  confirmPassword(a,b){
    if(a != b){
      return "Password tidak cocok";
    }
  }

  @override
  void initState() {
    if(widget.enableObscure == true){
      setState(() {
        obscureText = true;
      });
    }
    super.initState();
  }
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.stringNamaLabel),
          TextFormField(
            readOnly: widget.hanyaBaca!,
            controller: widget.controllerNama,
            obscureText: obscureText,
            keyboardType: widget.keyboardType,
            validator: (value) {
              if (value!.isEmpty){
                return "${widget.stringNamaLabel} tidak boleh kosong";
              }
              if (widget.validasi != null){
                return val1(value);
              }
              if (widget.confirmPassword != null){
                if (widget.controllerNama.text != widget.confirmPassword!.text){
                  return "Password tidak cocok";
                }
              }
              else {return null;};
            },
            onSaved:(newValue) {
              widget.controllerNama.text = newValue!;
            },
            decoration: InputDecoration(
                suffixIcon: widget.enableObscure != false ? obscureOrNot(): Icon(null),
                filled: true,
                fillColor: Color.fromRGBO(234, 234, 248, 1),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none)),
          )
        ],
      ),
    );
  }
}
