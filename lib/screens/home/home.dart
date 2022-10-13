import 'package:blog_post_1/models/brew.dart';
import 'package:blog_post_1/screens/home/settings_form.dart';
import 'package:blog_post_1/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:blog_post_1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:blog_post_1/screens/home/brew-list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: const SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: "").brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.pink,
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text Color
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('settings'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text Color
              ),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )),
            child: const BrewList()),
      ),
    );
  }
}
