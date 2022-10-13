import 'package:blog_post_1/models/user.dart';
import 'package:blog_post_1/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_post_1/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<StoredUser?>.value(
        catchError: (_, __) {
          return null;
        },
        value: AuthService().user,
        initialData: null,
        child: const MaterialApp(home: Wrapper()));
  }
}
