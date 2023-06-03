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
    return const MaterialApp(
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
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: const Text(
          "Color Palette Pro",
        ),
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
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                  width: 175,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.cyan.shade800,
                    onPressed: _pickImageFromGallery,
                    child: const Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  height: 75,
                  width: 175,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.cyan.shade800,
                    onPressed: _pickImageFromCamera,
                    child: const Text(
                      "Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: double.infinity,
              height: 25,
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
    _navigateToLoadingScreen();
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
      _navigateToColorDisplayPage(hexColors, imageTemp);
    } else {
      print('HTTP request failed with status: ${response.statusCode}');
    }
    setState(() => this.image = imageTemp);
  }

  void _navigateToColorDisplayPage(List<Color> colors, final image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorDisplayPage(colors: colors, image: image),
      ),
    );
  }

  void _navigateToLoadingScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadingScreen()),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
