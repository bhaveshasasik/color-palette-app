import 'package:flutter/material.dart';



class AccountPage extends StatefulWidget {
  @override
  _AccountPagestate createState() => _AccountPagestate();
}



class _AccountPagestate extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),

          // logo
            Icon(
            Icons.account_circle_outlined,
            size:100,
          ),
          ],
        ),
      ),
    ),
    );
  }
}