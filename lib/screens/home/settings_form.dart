import 'package:blog_post_1/models/user.dart';
import 'package:blog_post_1/services/database.dart';
import 'package:blog_post_1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:blog_post_1/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName = '';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<StoredUser?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData?.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugar(s)'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),
                  Slider(
                    activeColor: Colors.pink[_currentStrength],
                    inactiveColor: Colors.pink[50],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    value: (_currentStrength ?? userData?.strength)!.toDouble(),
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round()),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugars ?? userData!.sugars,
                          _currentName ?? userData!.name,
                          _currentStrength ?? userData!.strength,
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink, // Background color
                    ),
                    child: const Text(
                      'Update',
                      style: (TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
