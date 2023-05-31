import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:camera_gallery_demo/splash.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              child: const Text("Pick Image from Gallery",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () async {
                try {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final imageTemp = File(image.path);
                  //add http request
                  var request = http.MultipartRequest(
                    'POST',
                    Uri.parse(
                        'https://fd0e-168-150-39-67.ngrok-free.app/upload'),
                  );

                  request.files.add(
                    await http.MultipartFile.fromPath('image', imageTemp.path),
                  );
                  var response = await request.send();
                  if (response.statusCode == 200) {
                    //print(await response.stream.bytesToString());
                    String colors = await response.stream.bytesToString();
                    Map<String, dynamic> colorMap = json.decode(colors);
                    List<dynamic> colorList = colorMap['colors'];
                    //print(colorList);
                  } else {
                    // Handle the error
                    print(
                        'HTTP request failed with status: ${response.statusCode}');
                  }
                  setState(() => this.image = imageTemp);
                } on PlatformException catch (e) {
                  print('Failed to pick image: $e');
                }
              },
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text("Pick Image from Camera",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold)),
              onPressed: () async {
                try {
                  final image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (image == null) return;
                  final imageTemp = File(image.path);
                  //add http request
                  var request = http.MultipartRequest(
                    'POST',
                    Uri.parse(
                        'https://fd0e-168-150-39-67.ngrok-free.app/upload'),
                  );
                  request.files.add(
                    await http.MultipartFile.fromPath('image', imageTemp.path),
                  );
                  var response = await request.send();
                  if (response.statusCode == 200) {
                    //print(await response.stream.bytesToString());
                    String colors = await response.stream.bytesToString();
                    Map<String, dynamic> colorMap = json.decode(colors);
                    List<dynamic> colorList = colorMap['colors'];
                    //print(colorList);
                  } else {
                    // Handle the error
                    print(
                        'HTTP request failed with status: ${response.statusCode}');
                  }

                  setState(() => this.image = imageTemp);
                } on PlatformException catch (e) {
                  print('Failed to pick image: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
