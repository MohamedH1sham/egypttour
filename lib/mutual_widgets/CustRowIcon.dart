
import "package:flutter/material.dart";

class CUSTRowICON extends StatelessWidget {
  CUSTRowICON({this.image, this.text1, this.ontap});
  String? image;
  String? text1;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xfff6d690)),
      height: MediaQuery.sizeOf(context).height / 5,
      width: MediaQuery.sizeOf(context).width / 4.6,
      child: Column(children: [
        IconButton(
          color: const Color(0xfff6d690),
          icon: Image.asset(image!),
          iconSize: 14,
          onPressed: ontap,
        ),
        Text(
          '$text1',
          style: const TextStyle(color: Color.fromARGB(255, 194, 144, 37)),
        ),
      ]),
    );
  }
}