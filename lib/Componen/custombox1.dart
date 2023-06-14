import 'package:flutter/material.dart';

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