import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            child: const Text('Sign Out'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/');
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({'signOutDate': Timestamp.now()});
            },
          ),
        ],
        title: Text('Welcome ${user.displayName}'),
      ),
      body: Center(
        child: Text('You are now signed in'),
      ),
    );
  }
}
