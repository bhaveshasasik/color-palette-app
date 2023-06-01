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
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Palette'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Align(
          child: GridView.count(
            crossAxisCount: 5, // Number of columns in the grid
            //padding: EdgeInsets.all(20.0),
            padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
            children: List.generate(colors.length, (index) {
              return Container(
                color: colors[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}
