import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invoice_maker/widgets/drawer_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  // final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      width: screenWidth - 100,
      height: screenHeight,
      child: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey.shade200,
            child: Center(
              child: Text("Logo"),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          // Text("Name:  ${auth.currentUser!.displayName}"),
          // Text("Email:  ${auth.currentUser!.email}"),
          Divider(
            thickness: 2,
          ),
          SizedBox(
            height: 50,
          ),

          Spacer(),
          DrawerButtonWidget(
            buttonName: "Log Out",
            myicon: FontAwesomeIcons.rightFromBracket,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
