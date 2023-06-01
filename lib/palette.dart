//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'dart:io';
//import 'package:flutter/services.dart';
//import 'package:http/http.dart' as http;
//import 'package:camera_gallery_demo/splash.dart';
//import 'dart:convert';

//palette
class ColorDisplayPage extends StatelessWidget {
  final List<Color> colors;
  ColorDisplayPage({required this.colors});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Pallette'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network("https://media.wired.com/photos/598e35994ab8482c0d6946e0/master/w_2560%2Cc_limit/phonepicutres-TA.jpg"),
            Expanded(
              child: GridView.count(
                crossAxisCount: 5, // Number of columns in the grid
                children: List.generate(colors.length, (index) {
                  return Container(
                    color: colors[index],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}