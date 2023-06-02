import 'package:flutter/material.dart';

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
              return Tooltip(
                message: '#${colors[index].value.toRadixString(16).substring(2)}',
                child: Container(
                  color: colors[index],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
