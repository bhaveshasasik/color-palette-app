import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

//palette
class ColorDisplayPage extends StatelessWidget {
  final List<Color> colors;
  dynamic image;
  ColorDisplayPage({required this.colors, required this.image});
  ScreenshotController screenshotController = ScreenshotController();
  dynamic _imageWithPalette;
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
        title: const Text(
          'Color Palette',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
            ),
            onPressed: () async {
              screenshotController.capture().then((img) async {
                _imageWithPalette = img;
                final dir = await getApplicationDocumentsDirectory();
                final imagePath = await File('${dir.path}/captured.png').create();
                await imagePath.writeAsBytes(_imageWithPalette!);
                await Share.shareXFiles([XFile(imagePath.path)]);
              });
            },
          ),
          IconButton(
              icon: const Icon(
                Icons.login,
              ),
              onPressed: () {}),
        ],
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
      body: Screenshot(
        controller: screenshotController,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
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
                return Tooltip(
                  message:
                      '#${colors[index].value.toRadixString(16).substring(2)}',
                  child: Container(
                    color: colors[index],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
