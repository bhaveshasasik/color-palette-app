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
  dynamic image;
  ColorDisplayPage({required this.colors, required this.image});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Color Palette'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan.shade800, Colors.purple.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: screenWidth,
              child: Image.file(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(colors.length, (index) {
              return Container(
                color: colors[index],
              );
            }),
          ),
        ],
      ),
    );
  }
}
