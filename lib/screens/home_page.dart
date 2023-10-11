import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

      ),
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(title: Text("Home"), actions: [
        IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

            },
            icon: Icon(Icons.logout_outlined))
      ]),
      body: Center(
        child: Text.rich(
            TextSpan(
                text: 'Hi! ',style: TextStyle(fontSize: 30),
                children: <InlineSpan>[
                  TextSpan(
                    text: user?.displayName!.toUpperCase(),
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  )
                ]
            )
        ),
      ),
    );
  }
}
