import 'package:blog_post_1/screens/authenticate/authenticate.dart';
import 'package:blog_post_1/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_post_1/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<StoredUser?>(context);

    //return either Home or Authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
