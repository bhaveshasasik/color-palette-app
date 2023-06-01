import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:camera_gallery_demo/splash.dart';
import 'package:camera_gallery_demo/palette.dart';

//home
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: HomePage(),
        //adding splash screen
        home: SplashScreen());
  }
}

//home
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> hexColors = [];
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker Example"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Pick Image from Gallery",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: _pickImageFromGallery,
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Pick Image from Camera",
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: _pickImageFromCamera,
            ),
          ],
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      await _processImage(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      await _processImage(imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _processImage(File imageTemp) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://fd0e-168-150-39-67.ngrok-free.app/upload'),
    );
    request.files.add(
      await http.MultipartFile.fromPath('image', imageTemp.path),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      String colors = await response.stream.bytesToString();
      Map<String, dynamic> colorMap = json.decode(colors);
      List<dynamic> colorList = colorMap['colors'];

      List<Color> hexColors = colorList.map<Color>((color) {
        String hexString = color;
        hexString = hexString.replaceAll("#", "");
        return Color(int.parse(hexString, radix: 16)).withOpacity(1.0);
      }).toList();

      print(hexColors);
      _navigateToColorDisplayPage(hexColors);
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
    setState(() => this.image = imageTemp);
  }

  void _navigateToColorDisplayPage(List<Color> colors) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorDisplayPage(colors: colors),
      ),
    );
  }
}
