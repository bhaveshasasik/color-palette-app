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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "",
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
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.cyan.shade800,
                              Colors.purple.shade800
                            ],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'ColorFlix',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: double.infinity,
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                SizedBox(
                  height: 50,
                  width: 175,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.cyan.shade800,
                    onPressed: _pickImageFromCamera,
                    child: const Text(
                      "Take Image from Camera",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Colors.cyan.shade800,
                                Colors.purple.shade800
                              ],
                            ).createShader(bounds);
                          },
                          child: Text(
                            'discover your perfect color palette!',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
      Uri.parse('https://1ccf-24-130-143-73.ngrok-free.app/upload'),
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
